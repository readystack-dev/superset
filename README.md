# Apache Superset: ReadyStack build kit

The offline build kit for the Docker image `readystack/superset:6.1.0-CE-ubuntu24.04-r8`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [6.1.0-CE-ubuntu24.04-r8](https://github.com/readystack-dev/superset/releases/tag/6.1.0-CE-ubuntu24.04-r8)
- Image: [`docker.io/readystack/superset:6.1.0-CE-ubuntu24.04-r8`](https://hub.docker.com/r/readystack/superset/tags), manifest digest `sha256:5f1c49705b9a126176932250c627120385196198b53fd25d6ccd4cd3903e32c9`
- Product page: https://readystack.dev/products/superset
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=superset

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

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/superset/recipe. The complete kit is the release download. Each release is a tag here.
