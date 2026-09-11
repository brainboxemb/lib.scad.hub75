# Changelog

Functional changes to released `lib.scad.hub75` versions.

## Unreleased

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
