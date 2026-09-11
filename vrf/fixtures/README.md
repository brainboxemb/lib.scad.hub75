# Printable physical-verification fixtures

These fixtures are measurement and fit aids for a real HUB75 P5 64 × 32 panel.
They are not replacements for calibrated measurement tools.

Design rule: each fixture should answer one small question and be printable on a
normal FDM machine without needing a full-panel print.

## 1. Corner datum / mounting-boss gauge

Approximate print envelope: 35 × 35 × 4 mm.

Purpose:

- reference two perpendicular physical panel edges;
- check the nearby mounting-hole/boss centre offset from both edges;
- check the 8.5 mm mounting-tube OD locally;
- make an edge-datum error visible without measuring from an arbitrary point.

Construction:

- L-shaped datum faces touch the two panel edges;
- the inside corner gets clearance so the gauge does not accidentally measure an
  unknown outer corner radius;
- a circular boss opening is positioned from
  `hub75_p5_64x32_panel_hole_x_positions()` and
  `hub75_p5_64x32_panel_hole_z_positions()`;
- provide a small, known clearance around the boss rather than relying on a
  zero-clearance FDM hole.

This is the first fixture to print because it checks both datum interpretation
and the local mounting geometry.

## 2. Horizontal mounting-spacing gauge

Approximate print envelope: 164 × 22 × 4 mm.

Current model centre spacing: 144 mm.

A light bar spans the two mounting columns. Two openings fit over the rear
mounting tubes. The gauge should use the public hole-position and boss-diameter
accessors so it is also a consumer-API test.

Keep boss-diameter fit and centre-spacing fit distinguishable. The final version
should therefore include either a known radial clearance or one datum opening +
a small spacing indicator at the second opening rather than two intentionally
snug holes.

## 3. Vertical adjacent-row spacing gauge

Approximate print envelope: 172 × 22 × 4 mm.

Current model adjacent row spacing: 152 mm.

The same gauge can be used on bottom↔middle and middle↔top. This avoids a 304 mm
full-height print while still testing both intervals independently.

## 4. Rear-width comb

Small comb with separate labelled slots for the rear geometry at the mounting
plane:

- side rail width;
- normal end rail width;
- narrow end rail width;
- crossbar width.

The nominal slot sizes must come only from the public accessors. Add deliberate
clearance variants around the model value when needed, for example nominal,
nominal +0.2 mm and nominal +0.4 mm. The aim is to identify the fit band, not to
pretend the printer produces metrology-grade slot widths.

This fixture directly tests whether the public mating API exposes useful values
for real consumer geometry.

## 5. Radius comparator

A generic two-sided comparator around the expected rear-opening radius.

Initial radii:

```text
4.0, 4.5, 5.0, 5.5, 6.0 mm
```

Provide:

- concave notches for convex outer corners;
- convex noses for concave/inside corners.

The current model rear-opening radius is about 4.99 mm, but the neighbouring
sizes are just as important: they make it possible to see whether 5 mm is really
the best match instead of merely confirming the model value.

Record the printed comparator's own measured dimensions when using it as evidence.

## 6. Public-API mating coupon

This is the most important *architecture* fixture.

It must import the library through `use <...>` and construct a small mating
feature using public accessors only. It must not read `panel.foo` fields or copy
private constants.

The first coupon should combine only a local set of fit-critical concepts:

- one physical edge datum;
- side/end rail width at the rear mounting plane;
- one mounting boss;
- the nearby bay corner radius where practical.

A second coupon can target a crossbar + reinforcement/bushing interface.

If a useful coupon cannot be expressed through the public API, do not reach into
private state just to finish the fixture. Record the missing datum as an API gap.

## 7. Continuous-taper profile fixture

A small negative profile that slides against a clear section of the panel's
outer rear wall would be a strong test of the STEP-derived continuous taper.

Do not implement this by copying the private taper formula into verification.
First decide whether consumers genuinely need a public `...at_y()` style
accessor/profile helper. If yes, add that API deliberately and test it. If not,
keep taper verification as direct physical measurement/profile evidence rather
than expanding the public API unnecessarily.

## Print discipline

For all dimensional fixtures record at least:

- printer;
- material;
- nozzle/layer profile;
- print orientation;
- measured calibration feature(s) on the finished print.

Prefer base-down parts, generous local stiffness, and no supports where possible.
Do not tune a library dimension merely to compensate for a known printer offset.

Generated fixture STLs/evidence belong below `vrf/out/`; only the fixture source
and verification documentation belong on `main`.
