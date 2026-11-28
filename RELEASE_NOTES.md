# Apache Superset 6.1.0 — ReadyStack release `6.1.0-CE-ubuntu24.04-r9`

Generated 2026-11-28 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/superset:6.1.0-CE-ubuntu24.04-r9` (linux/amd64). Index digest `sha256:ca553ab5e99ff39d9548e99b0f2b5a7ec0083d46d62583d54a6c53060ff0a528` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:b665af892ef3fbbcad19298f805fdce0d6783ed1eac1809908d7e62fff8f1007` [`TARGET_DIGEST.txt`].
- **Upstream:** Apache Superset 6.1.0 built from upstream's published release artifact https://pypi.org/project/apache-superset/6.1.0/; its source is `6.1.0` of https://github.com/apache/superset — upstream notes: https://github.com/apache/superset/releases/tag/6.1.0 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `superset`.
- **Build:** `source-rebuild-python`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `6.1.0-CE-ubuntu24.04-r8`.

## What changed in this release

- Upstream version unchanged (6.1.0); ReadyStack rebuild.
- Minimum dependency versions ReadyStack enforces on top of upstream (raised only where upstream's own version was lower); shipped versions from the SBOM [`docs/sbom/SBOM.json`]:
  - `pillow` at least `13.0.0` (shipped: `13.0.0`)
  - `cryptography` at least `50.0.2` (shipped: `50.0.2`)
  - `pyopenssl` at least `26.4.0` (shipped: `26.4.0`)
  - `pyarrow` at least `23.0.1` (shipped: `23.0.1`)
  - `msgpack` at least `1.2.3` (shipped: `1.2.3`)
  - `certifi` at least `2026.10.19` (shipped: `2026.10.19`)
  - `setuptools` at least `84.2.1` (shipped: `84.2.1`)
  - `pyjwt` at least `2.15.1` (shipped: `2.15.1`)
  - `urllib3` at least `2.8.0` (shipped: `2.8.0`)
  - `pyasn1` at least `0.6.5` (shipped: `0.6.5`)
  - `mako` at least `1.4.3` (shipped: `1.4.3`)
  - `markdown` at least `3.8.2` (shipped: `3.8.2`)
  - `idna` at least `3.20` (shipped: `3.20`)
  - `werkzeug` at least `3.1.9` (shipped: `3.1.9`)
  - `python-dotenv` at least `1.2.4` (shipped: `1.2.4`)
  - `geopy` at least `2.5.0` (shipped: `2.5.0`)
  - `requests` at least `2.33.1` (shipped: `2.33.1`)
  - `brotli` at least `1.2.1` (shipped: `1.2.1`)
  - `dnspython` at least `2.9.2` (shipped: `2.9.2`)
- Apache Superset 6.1.0 is unchanged from the release this supersedes (6.1.0-CE-ubuntu24.04-r8); this release rebuilds it. Changes: libexpat1 moves from 2.6.1-2ubuntu0.6 to 2.6.1-2ubuntu0.7 (USN-9196-1). Settings, ports and data volumes are those of 6.1.0-CE-ubuntu24.04-r8: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-28)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `superset` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/superset:6.1.0-CE-ubuntu24.04-r9` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** SUPERSET_SECRET_KEY encrypts the database credentials Superset stores; keep it secret and keep it stable: once a database connection is saved, a container started with a different key exits during `superset init` with `ValueError: Invalid decryption key` and does not listen.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:b665af892ef3fbbcad19298f805fdce0d6783ed1eac1809908d7e62fff8f1007`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 8 of 8 use cases passed (8 authored) against the running image [`docs/validation/test-results.json`].

## Known issues

- **low** (ReadyStack package): While SUPERSET_ADMIN_PASSWORD is set, every start passes the admin password on a process command line [`RSD-superset-dd2b9075c6`] (carried from `6.1.0-CE-ubuntu24.04-r1`, recorded there as `RSD-superset-b46891def3`)

## Defects fixed

- 10 problems found before release and fixed before it shipped (10 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/superset:6.1.0-CE-ubuntu24.04-r9
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

