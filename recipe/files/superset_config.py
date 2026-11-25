# ReadyStack superset_config.py (loaded through SUPERSET_CONFIG_PATH). Every setting comes from the
# environment; no secret or connection string is baked into the image. Mount your own file and point
# SUPERSET_CONFIG_PATH at it to change anything else Superset's config.py allows.
import os

SECRET_KEY = os.environ.get("SUPERSET_SECRET_KEY", "")
SQLALCHEMY_DATABASE_URI = os.environ.get("SUPERSET_DATABASE_URI", "")
DATA_DIR = os.environ.get("SUPERSET_HOME", "/var/lib/superset")
# Set ENABLE_PROXY_FIX=true when Superset runs behind a reverse proxy that sets X-Forwarded-* headers.
ENABLE_PROXY_FIX = os.environ.get("ENABLE_PROXY_FIX", "false").lower() in ("1", "true", "yes")
