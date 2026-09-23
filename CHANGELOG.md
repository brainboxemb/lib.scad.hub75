# Changelog

## Unreleased

## v0.1.8

### Changed

- Adopt the Migration-011 repository baseline: tool.git-project v0.2.14, tool.scad-project v0.15.11, managed bootstrap/update launchers, self-scoped workflow entrypoints and the shared numbered documentation families, without changing HUB75 panel geometry, public API or physical-verification semantics.

- Align repository documentation and agent routing with Migration 010: add numbered plan/specification/design/verification sources above the existing component-local design/manual, route shared working guidance through `brainboxemb.meta`, publish the verification strategy with `prod/vrf`, and correct active physical-verification image links from the historical `prod/verification` namespace to `prod/vrf`.

- Preserve executable mode on `update-repo.sh`; the Migration 009 wrapper refresh keeps the canonical v0.15.6 content and remains directly invokable on Unix-like systems.

- Refresh root `update-repo.sh` and `update-repo.ps1` to the canonical `tool.scad-project v0.15.6` consumer wrappers so future repository updates use the released Migration 009 path.

- Advance Migration 009 to released `tool.scad-project v0.15.7` with exact tool gitlink `bfaac9f6916c09bc6525abddf64c87238fe59103`, retaining production-run serialization and restoring the qualified read-only `update-repo status` contract while leaving HUB75 geometry, public API and physical-verification content unchanged.
- Requalify exact main `9ccf0d0120d4e9b49624aa0fca9dd6113bd6dc99` through production run `35729158403`; both `prod/bld` and `prod/vrf` identify the v0.15.6 stack.

Functional changes to released `lib.scad.hub75` versions.

## v0.1.7

### Changed

- Align the final Migration-005 namespace-correction baseline to released `tool.scad-project v0.14.9` with exact tool gitlink `a140b22858ac1899e7f2fa71b679639a70d819c3`.
- Normalize persistent generated-output publication to the canonical technical `bld` / `vrf` namespaces: `dev/pr-N/{bld,vrf}`, `prod/{bld,vrf}` and `rel/vX.Y.Z/{bld,vrf}` while retaining human-facing Build/Verification terminology.
- Requalify the SCons-backed OpenSCAD-only consumer on affected PR run `35126450152` and merged-main run `35126654658`: normal SCons cache restore/save stays active while command-only Verification does not require Verification-SCons cache transport.
- Keep HUB75 geometry, public API, physical-verification procedures/fixtures and SCons configuration unchanged.

## v0.1.6

### Changed

- Align the final Migration-005 consumer baseline to released `tool.scad-project v0.14.8` with exact tool gitlink `85781a6b21a0f6a06d37be154fd9eb475ecaa2a4`.
- Use semantic `v0.14.8` Production and thin split Release callers while retaining the focused OpenSCAD runtime and configured SCons build policy.
- Requalify the affected PR (`35101188447`), merged main (`35101638473`) and README-only zero-runtime (`35101927430`) paths without changing HUB75 geometry, public API, physical-verification content or SCons configuration.

## v0.1.5

### Changed

- Migrate the library to released `tool.git-project v0.2.8`, `tool.scad-project v0.14.3` and the SCAD toolchain v0.5.0 runtime family.
- Replace the consumer-authored Migration-004 Moon lifecycle graph with inherited `scad.docs`, `scad.build` and `scad.verify` capabilities plus HUB75-specific source-impact inputs.
- Preserve the OpenSCAD-only `build_engine.engine: scons` configuration so HUB75 qualifies the focused runtime and scoped SCons reuse path independently from the parallel clamps direct/full-runtime canary.
- Use the Migration-005 thin production caller and generic v0.2.8 PR-preview cleanup; normal CI retains compact orchestration evidence instead of duplicate complete output artifacts.
- Keep functional/physical verification focused on the panel API, fixtures and operator evidence, while shared planner/workflow CI evidence qualifies foundation pins, inherited capabilities, focused-runtime selection and SCons transport.
- Keep the physical verification procedures, fixture geometry and SQ testcase content unchanged; this migration changes execution/orchestration only.

## v0.1.4

### Changed

- Upgrade repository tooling to released `tool.scad-project v0.13.1` and align the tool gitlink plus Production/Release/PR-cleanup reusable workflow pins to its exact source commit.
- Replace separate normal Build and Verify heavy workflows with the common Moon-gated single-host SCAD production lifecycle: lightweight host preflight, at most one explicit SCAD Docker process, host-side validation/staging and same-job Build/Verification publication after the container exits.
- Add a HUB75-specific Moon graph with real independent `scad.build`, `scad.docs` and `scad.verify` producer domains while keeping current presentation renders, generated design documentation, API verification and physical-verification output responsibilities intact.
- Keep the physical verification procedures and SQ testcase content unchanged; this migration changes repository execution/orchestration only.

## v0.1.3

### Changed

- Complete the repository tooling migration from the v0.9.12-era `tool.scad-project` contract to released `v0.12.0`.
- Pin `project.yml`, the `tools/tool.scad-project` gitlink, and Build/Verify/Release/PR-cleanup reusable workflows to the exact v0.12.0 source commit.
- Keep pull-request previews isolated under `dev/pr-<number>/build` and `dev/pr-<number>/verification`, with cleanup after PR close.
- Continue to run normal Build/Verify workflows on pull requests and `main` pushes, avoiding duplicate feature-branch push builds.
- Preserve the current panel API, SCons build configuration and main-branch verification behaviour; ongoing physical-verification work in PR #19 remains a separate development stream.

## v0.1.2

### Changed

- Move both right-pointing rear PCB orientation arrows inward using one consistent 12 mm visible clearance from the bay side rail, derived from the scaled rail width and arrow size; keep the downward markers and mechanical panel geometry unchanged.

## v0.1.1

### Added

- Add dedicated front/rear angled standalone panel preview builds and expose them from the root README.
- Group panel-specific design/render support files below the public panel component while keeping the public consumer entrypoint unchanged.

### Fixed

- Join each stepped bay-end relief to its rounded bay opening with a small internal cutter overlap, preventing stale vertical walls across the horizontal-crossbar reliefs without changing the visible STEP-derived contour.

### Changed

- Place the rear PCB orientation arrows directly on the PCB as a 0.10 mm white coating instead of 0.35 mm markers at the rear mounting plane.
- Render standalone panel previews on portrait 1000 × 1600 canvases with level, reduced side angles suited to side-by-side documentation.
- Discover standalone previews through the component-local render directory and `render.yml` instead of root-level explicit `builds:` entries.
- Upgrade repository tooling to `tool.scad-project` v0.9.10, enable the SCons dependency-selective backend and use layout-independent generated-design cache inputs.
- Reduce the normal design-documentation canvas to 640 × 480, with 480 × 360 overrides for focused detail views.

## v0.1.0

### Added

- Establish the first immutable library release for the reusable HUB75 P5 64 × 32 panel reference model.
- Publish the object-based OpenSCAD API, mechanical mating accessors, generated design documentation and functional verification as release evidence.
- Add coordinated versioned release publication with immutable `rel/vX.Y.Z/build` and `rel/vX.Y.Z/verification` snapshots, release bundles and SHA-256 checksums.

### Changed

- Upgrade repository tooling from `tool.scad-project` v0.7.2 to v0.9.8.
- Pin Build, Verify and Release reusable workflows to the exact commit behind v0.9.8.
- Move mutable production output from legacy `build` / `verification` branches to `prod/build` / `prod/verification`; development output remains under `dev/*`.
- Treat `project.yml`, the tool gitlink and workflow commit pins as the authoritative dependency alignment.
