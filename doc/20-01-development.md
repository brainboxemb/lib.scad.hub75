# lib.scad.hub75 development manual

## Start

1. read [../AGENTS.md](../AGENTS.md);
2. read [10-00-plan.md](10-00-plan.md);
3. use [README.md](README.md) to route to specification, design and verification;
4. read the affected component-local design before changing non-trivial geometry;
5. read [50-00-verification.md](50-00-verification.md) before changing verification meaning or evidence.

## Repository entrypoints

Managed root entrypoints are:

```text
bootstrap.ps1 / bootstrap.sh
update.ps1 / update.sh
```

Repository-owned workflows are:

```text
.github/workflows/self-ci.yml
.github/workflows/self-release.yml
.github/workflows/self-pr-cleanup.yml
```

These delegate shared orchestration to released reusable workflows.

## Edit and verify

Keep the public panel model/object API in
`openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad`. Presentation/design
adapters may change cameras/colors but must reuse production geometry.

Functional verification runs through `scripts/run-verification.sh`; the
physical workbench index is assembled by `scripts/build-verification-index.sh`.
Generated evidence belongs below `vrf/out`.

## Physical evidence

Do not treat a generated fixture as dimensional proof. Physical observations,
model targets and accepted values stay separate until reviewed.

## Release

Release only an exact qualified main commit via `self-release.yml`; inspect
exact-main CI plus `prod/bld` / `prod/vrf` provenance before creating the
release request.
