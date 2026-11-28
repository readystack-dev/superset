# Provenance — Apache Superset (`6.1.0-CE-ubuntu24.04-r9`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/apache/superset
- Upstream release: `6.1.0` (commit `c83fb2bb1dcfac41ac51bcebd82471f4a7180d18`), the source revision of the release artifact this image is built from
- Release artifact: https://pypi.org/project/apache-superset/6.1.0/; the build installs it
- Source tree: `33f51912dbfeb76ed01a8c9bf599cc0c10ff67821868c648e64c0fdf32737ae9` over 7493 files [`docs/provenance/SOURCE_TREE_HASH.json`] — upstream's tree at that revision, cloned for the licence and Community Edition audit; the image is not built from it
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-python`; base image `ubuntu:24.04`
- Compiled with `--network=none` from the vendored upstream release artifact, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795644313` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/superset:6.1.0-CE-ubuntu24.04-r9` — index digest `sha256:ca553ab5e99ff39d9548e99b0f2b5a7ec0083d46d62583d54a6c53060ff0a528` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:b665af892ef3fbbcad19298f805fdce0d6783ed1eac1809908d7e62fff8f1007` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/superset:6.1.0-CE-ubuntu24.04-r9`

## Pinned inputs, and why

- 202 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 3, base and build images 1, image digests 1, language runtimes and toolchains 1, dependency versions readystack sets 187, pins in the kit's dockerfiles 3, readystack's build engine 2, dependencies upstream chose 2, services the release checks run beside 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-superset-6.1.0-CE-ubuntu24.04-r9.trail.json`, published beside this archive and signed with the release key (`ReadyStack-superset-6.1.0-CE-ubuntu24.04-r9.trail.json.sigstore`), and readable at https://readystack.dev/products/superset/trail/6.1.0-CE-ubuntu24.04-r9.

