# HUB75 panel verification

Functional verification builds the default panel through the public
`hub75_p5_64x32_panel_create()` / `hub75_p5_64x32_panel_build()` object API and
checks key derived dimensions.

## Printable physical-verification fixtures

These are fit/datum aids derived only from public library accessors. They are not
calibrated metrology instruments; measure the finished print when using it as
physical evidence.

- [Corner datum gauge STL](fixtures/hub75-p5-64x32-corner-datum-gauge.stl) · [preview](fixtures/hub75-p5-64x32-corner-datum-gauge.png)
- [144 mm X mounting-spacing gauge STL](fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.stl) · [preview](fixtures/hub75-p5-64x32-mounting-spacing-x-gauge.png)
- [152 mm adjacent-row Z mounting-spacing gauge STL](fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.stl) · [preview](fixtures/hub75-p5-64x32-mounting-spacing-z-gauge.png)

The spacing gauges clear the reinforcement rings so they primarily test centre
spacing. Boss diameter/fit is intentionally a separate measurement question.

Generated verification output belongs on the `verification` branch.
