[![ReadyStack](https://readystack.dev/logo.svg)](https://readystack.dev)

**Stable, Open-source Releases, Automated** · [readystack.dev](https://readystack.dev)

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-readystack%2Fsuperset-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/readystack/superset) [![Docker pulls](https://img.shields.io/docker/pulls/readystack/superset)](https://hub.docker.com/r/readystack/superset) [![Grade at release](https://img.shields.io/badge/grade%20at%20release-A%20%2894%25%29-2ea44f)](https://readystack.dev/products/superset) [![Signed: cosign](https://img.shields.io/badge/signed-cosign-2ea44f)](https://readystack.dev/keys/cosign.pub) ![SBOM: SPDX](https://img.shields.io/badge/SBOM-SPDX-2ea44f) ![Provenance: SLSA v1](https://img.shields.io/badge/provenance-SLSA%20v1-2ea44f) ![Offline rebuild: verified](https://img.shields.io/badge/offline%20rebuild-verified-2ea44f)

# Apache Superset: ReadyStack build kit

The offline build kit for the Docker image `readystack/superset:6.1.0-CE-ubuntu24.04-r8`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [6.1.0-CE-ubuntu24.04-r8](https://github.com/readystack-dev/superset/releases/tag/6.1.0-CE-ubuntu24.04-r8)
- Image: [`docker.io/readystack/superset:6.1.0-CE-ubuntu24.04-r8`](https://hub.docker.com/r/readystack/superset/tags), manifest digest `sha256:5f1c49705b9a126176932250c627120385196198b53fd25d6ccd4cd3903e32c9`
- Product page: https://readystack.dev/products/superset
- Source and build recipe: https://readystack.dev/products/superset/recipe
- Build trail: https://readystack.dev/products/superset/trail/6.1.0-CE-ubuntu24.04-r8
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=superset

## The image

ONE container running Superset's web server (gunicorn, non-root user superset, port 8088) PLUS a PostgreSQL database you provide for Superset's own metadata (users, dashboards, charts, saved queries). The image has no database server, no Redis and no Celery worker: caching is off (NullCache) and async queries, alerts, reports and thumbnails stay disabled unless you add Redis and a worker yourself. Every start runs `superset db upgrade` and `superset init` before the server listens.

## Who uses Apache Superset and why

Data teams and business users who explore data and build dashboards on top of their SQL databases.

Apache Superset is an open-source data exploration and visualisation platform: a no-code chart builder, a web-based SQL editor, a light semantic layer, and support for nearly any SQL database.

A typical use: A data team's warehouse holds sales and marketing data that managers want to see daily. Analysts define the shared metrics once in Superset, managers build their own charts with the no-code interface, and analysts dig deeper with the SQL editor when a number looks wrong.

From the upstream project's own description: https://github.com/apache/superset.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-24 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 102 packages with copyleft licences (GPL, LGPL, MPL), 101 of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`superset`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-24; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/superset.

Apache Superset is distributed under its upstream licence (Apache-2.0); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [6.1.0-CE-ubuntu24.04-r8 release](https://github.com/readystack-dev/superset/releases/tag/6.1.0-CE-ubuntu24.04-r8): `ReadyStack-superset-6.1.0-CE-ubuntu24.04-r8.tar.gz` (794.2 MB), SHA-256 `543168d0cd63f0ec478f892c4bfa34ad8e41ca2d0a3f14b3318b0a34b09579ef`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-superset-6.1.0-CE-ubuntu24.04-r8.rebuild.json.sigstore ReadyStack-superset-6.1.0-CE-ubuntu24.04-r8.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-superset-6.1.0-CE-ubuntu24.04-r8.tar.gz
cd 6.1.0-CE-ubuntu24.04-r8
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-superset-6.1.0-CE-ubuntu24.04-r8.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/superset/recipe. The complete kit is the release download. Each release is a tag here. How to report a vulnerability: [SECURITY.md](SECURITY.md).

## About ReadyStack

**Stable, Open-source Releases, Automated.** ReadyStack releases popular open-source apps every week with every available critical and high security fix applied, plus full documentation, reference data, tests and a build recipe that recreates each release bit-for-bit. Each release is rebuilt from its pinned inputs with the network off, checked against its published digest, signed, and scanned and graded again every day. The images and build kits are free, and ReadyStack is soon to be a nonprofit.

[readystack.dev](https://readystack.dev) · [All products](https://readystack.dev/products.html) · [Build kits on GitHub](https://github.com/readystack-dev) · [Defect log](https://readystack.dev/defects.html) · contact@readystack.dev

— ReadyStack · https://readystack.dev
