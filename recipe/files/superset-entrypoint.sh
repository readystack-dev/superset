#!/bin/sh
# ReadyStack Apache Superset entrypoint. Checks the two required settings, waits for the metadata database,
# applies migrations, syncs roles and permissions, optionally creates the first admin, then execs gunicorn as
# the single foreground process (PID 1, non-root user superset).
set -eu
if [ -z "${SUPERSET_SECRET_KEY:-}" ]; then
  echo "ERROR: SUPERSET_SECRET_KEY is not set. Generate one with: openssl rand -base64 42" >&2
  exit 1
fi
if [ -z "${SUPERSET_DATABASE_URI:-}" ]; then
  echo "ERROR: SUPERSET_DATABASE_URI is not set. Point it at your PostgreSQL metadata database," >&2
  echo "       for example <redacted: credentials in a URL>:5432/superset" >&2
  exit 1
fi
python3 - <<'PY'
import os, sys, time
from sqlalchemy import create_engine, text
deadline = time.time() + int(os.environ.get("DB_WAIT_TIMEOUT", "120"))
err = None
while time.time() < deadline:
    try:
        with create_engine(os.environ["SUPERSET_DATABASE_URI"]).connect() as c:
            c.execute(text("SELECT 1"))
        sys.exit(0)
    except Exception as e:
        err = e
        time.sleep(2)
print(f"ERROR: metadata database not reachable after {os.environ.get('DB_WAIT_TIMEOUT', '120')}s: {err}", file=sys.stderr)
sys.exit(1)
PY
superset db upgrade
superset init
if [ -n "${SUPERSET_ADMIN_PASSWORD:-}" ]; then
  superset fab create-admin --username "${SUPERSET_ADMIN_USERNAME:-admin}" --firstname "${SUPERSET_ADMIN_FIRSTNAME:-Superset}" \
    --lastname "${SUPERSET_ADMIN_LASTNAME:-Admin}" --email "${SUPERSET_ADMIN_EMAIL:-admin@example.com}" --password "$SUPERSET_ADMIN_PASSWORD"
fi
exec gunicorn --bind "0.0.0.0:${SUPERSET_PORT:-8088}" --access-logfile - --error-logfile - \
  --workers "${SERVER_WORKER_AMOUNT:-1}" --worker-class gthread --threads "${SERVER_THREADS_AMOUNT:-20}" \
  --timeout "${GUNICORN_TIMEOUT:-60}" --keep-alive 2 --limit-request-line 0 --limit-request-field_size 0 \
  "superset.app:create_app()"
