# Verification

`test/` and `vrf/` deliberately answer different questions.

- `test/` checks software/API regression: does the library still return and build
  what its source currently specifies?
- `vrf/` checks correspondence with reality: does that specification agree with
  measured HUB75 hardware, and can a consumer build mating geometry from the
  public API?

The physical-panel validation plan is documented in
[`physical-panel-validation.md`](physical-panel-validation.md). The planned
printable measurement and fit helpers are documented in
[`fixtures/README.md`](fixtures/README.md).

The compact verification catalogue in
[`measurement-catalog.yml`](measurement-catalog.yml) records which model
features still need physical confirmation. It is intentionally not a store for
raw measurements or photographs.

Raw vendor/source material, physical sample measurements and supporting photos
should live in a separate companion data repository. The proposed repository is
`lib.scad.hub75.data`; the library should only retain the small accepted
verification baseline and a provenance link/commit to the data that justified
it.

Functional verification is currently generated from
`test/hub75_p5_64x32_panel_api.scad`.

Generated STL/images/evidence are written below `vrf/out/` and are not committed
to `main`.
