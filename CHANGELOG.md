# Changelog

Functional changes to released `lib.scad.hub75` versions.

## Unreleased

### Changed

- Place the rear PCB orientation arrows directly on the PCB as a 0.10 mm white coating instead of 0.35 mm markers at the rear mounting plane.

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
