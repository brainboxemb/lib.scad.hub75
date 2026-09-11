# Printable physical-verification fixtures

These fixtures are aids for comparing the library model with a real HUB75 P5
64 × 32 panel. They are not replacements for calibrated measurement tools.

The first rule is: **one recognizable area, one clear placement, one limited set
of questions**. Do not hand an operator a collection of unexplained STLs and call
that a verification plan.

## TL1 — upper-left profile comb — first procedure

Fixture marking: **`TL1 v0.1`**.

Nominal thickness: 2.0 mm.

This is the first helper to print and use. The complete operator procedure,
including generated placement renders, is in
[`../physical-panel-validation.md`](../physical-panel-validation.md).

TL1 is printed flat, then used perpendicular to the rear face at the upper-left
corner. Its lower rail follows the modelled top profile from the front stack
through the continuous rear taper. A rear witness blade hangs behind the panel
next to the upper-left screw/reinforcement column.

It provides visual references for:

- top-edge taper/profile;
- upper-left screw centre height from the top edge;
- reinforcement centre height 11 mm below the screw centre;
- rear mounting plane;
- expected 0.5 mm mounting-tube protrusion.

It deliberately does **not** try to turn printed holes into precision diameter
gauges. Screw-tube OD, screw-hole diameter, reinforcement diameter/recess and X
position from the left edge are measured separately with appropriate tools.

The version is raised on the physical part. When TL1 geometry changes, increment
the fixture version so physical evidence always identifies the exact printed
helper that was used.

## Secondary helpers — later stages

The following helpers already exist but are not the first operator step.

### Corner datum gauge

An early 35 × 35 mm experiment that references two panel edges and a nearby
mounting datum. It remains useful for comparison, but TL1 is the preferred first
procedure because its placement and individual checks are explicitly documented.

### Horizontal mounting-spacing gauge

Approximate envelope: 166 × 22 × 3.2 mm.

Current model centre spacing: 144 mm. The two openings deliberately clear the
reinforcement regions so the main question is centre spacing rather than printed
hole fit.

### Vertical adjacent-row spacing gauge

Approximate envelope: 174 × 22 × 3.2 mm.

Current adjacent-row spacing: 152 mm. The same gauge can be used on
bottom↔middle and middle↔top.

These spacing gauges should be used only after local corner datums have been
physically understood. Otherwise a failed long gauge does not tell the operator
which local feature is wrong.

## Planned later helpers

### Rear-width comb

A small comb with separate labelled references for side rail, normal end rail,
narrow end rail and crossbar width. Clearance variants should make printer fit
separate from the nominal library value.

### Radius comparator

A two-sided comparator around the expected rear-opening radius, initially 4.0,
4.5, 5.0, 5.5 and 6.0 mm, with both concave and convex references.

### Public-API mating coupon

A local mating feature built only from public accessors. If it cannot be made
without private `panel.foo` state, record that as an API finding rather than
reaching into private state.

### Additional taper/profile helpers

Only add these after TL1 has been used on real hardware. Do not copy a private
taper formula into verification merely to prove the model against itself.

## Print discipline

For every dimensional helper record at least:

- fixture ID/version;
- printer;
- material;
- nozzle/layer profile;
- print orientation;
- obvious warping or measured calibration features.

Prefer flat/base-down parts and no supports where possible. Do not tune a library
dimension merely to compensate for a known printer offset.

Generated fixture STLs and previews belong below `vrf/out/` on the configured
verification publication branch; only fixture source and documentation belong on
`main`.
