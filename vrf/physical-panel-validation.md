# Physical HUB75 panel validation plan

## Goal

The current P5 64 × 32 model is coherent against the supplied dimensional
drawing, STEP model and rear photograph, but it has not yet been systematically
checked against a physical panel.

This document is an **operator procedure**. It should be possible to perform the
checks with the real panel, normal measuring tools and the named printed helper
without first reading the OpenSCAD source.

The first rule is deliberately simple:

> Do not start by trying to verify the whole panel. Start with one recognizable
> physical corner, understand every feature there, and only then repeat or extend
> the method.

## Before you start

For the first verification session you need:

- one physical P5 64 × 32 HUB75 panel;
- one printed **TL1 v0.2** profile comb;
- one printed **SQ1 v0.1** alignment guide so TL1 can be held repeatably square;
- a digital caliper;
- a usable depth/step measurement method for the 0.5 mm tube protrusion and the
  reinforcement recess;
- preferably suitable small pin/plug gauges for the 3.0 mm and 2.5 mm holes;
- a phone/camera for side/profile evidence when something does not agree;
- a sample identifier, initially for example `P5-64X32-001`.

Do **not** change the CAD model while taking the first readings. Record a
mismatch as `investigate` first. Also do not start with the long 144/152 mm
spacing gauges; Stage 1 deliberately proves one understandable physical corner
before moving across the whole panel.

---

# Stage 1 — upper-left corner, viewed from the rear

This is the first verification area.

<img src="../../../raw/prod/verification/plan/top-left-location.png" alt="Rear view with upper-left verification area marked" width="55%">

Hold the real panel with the **rear/electronics side toward you** and the long
320 mm direction vertical. The area outlined in the image is the upper-left
corner used in this procedure.

Do not rotate the procedure mentally to another corner. The reinforcement feature
is asymmetric relative to the screw position, so this first procedure is tied to
this exact corner.

## What we want to prove here

One small corner already tests several independent parts of the model:

1. the physical top and left edge datums;
2. the continuous front-to-rear taper at the top outer edge;
3. the upper-left mounting-hole/tube centre in X and Z;
4. mounting-tube outer diameter and screw-hole diameter;
5. mounting-tube rear protrusion;
6. the position of the separate reinforcement feature below the screw;
7. reinforcement outer diameter, recess and blind hole.

That is enough for the first physical session. The 144 mm / 152 mm spacing bars
are useful later, but they are not the first thing the operator needs to
understand.

## Feature map

<img src="../../../raw/prod/verification/plan/top-left-feature-map.png" alt="Upper-left rear feature map" width="72%">

In the generated feature map:

- **yellow** = physical top and left edge datums;
- **red** = upper-left mounting tube / screw centre;
- **blue** = separate reinforcement feature.

The coloured geometry is explanatory overlay only. The gray/normal geometry is
the actual library panel model.

## Current model targets

These are the values the physical observations will be compared against. They
are not measurements of the real sample yet.

| ID | Feature | Current model target | Source/API |
| --- | --- | ---: | --- |
| TL-01 | mounting centre from left physical edge | 7.850 mm | `hub75_p5_64x32_panel_hole_x_positions()` |
| TL-02 | mounting centre from top physical edge | 7.855 mm | panel height + `hub75_p5_64x32_panel_hole_z_positions()` |
| TL-03 | mounting tube outer diameter | 8.500 mm | `hub75_p5_64x32_panel_mounting_tube_outer_diameter()` |
| TL-04 | screw hole diameter | 3.000 mm | `hub75_p5_64x32_panel_hole_diameter()` |
| TL-05 | mounting tube protrusion behind mounting plane | 0.500 mm | `hub75_p5_64x32_panel_mounting_tube_protrusion()` |
| TL-06 | reinforcement centre below screw centre | 11.000 mm | `hub75_p5_64x32_panel_reinforcement_bushing_offset()` |
| TL-07 | reinforcement centre from top edge | 18.855 mm | TL-02 + TL-06 |
| TL-08 | reinforcement outer diameter | 14.000 mm | `hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter()` |
| TL-09 | reinforcement recess diameter | 10.000 mm | `hub75_p5_64x32_panel_reinforcement_bushing_recess_diameter()` |
| TL-10 | reinforcement recess depth | 2.500 mm | `hub75_p5_64x32_panel_reinforcement_bushing_recess_depth()` |
| TL-11 | reinforcement blind-hole diameter | 2.500 mm | `hub75_p5_64x32_panel_reinforcement_bushing_hole_diameter()` |
| TL-12 | reinforcement blind-hole depth | 10.000 mm | `hub75_p5_64x32_panel_reinforcement_bushing_hole_depth()` |
| TL-13 | rear mounting plane | 14.500 mm from front datum | `hub75_p5_64x32_panel_depth()` |
| TL-14 | rear top-edge inset | about 1.25 mm | `hub75_p5_64x32_panel_rear_outer_inset_z()` |
| TL-15 | start of rear taper | 2.000 mm from front datum | `hub75_rear_taper_start_y()` |

For the default model the rear taper therefore runs for about 12.5 mm, from the
rear of the front-mask/PCB stack to the 14.5 mm mounting plane. The printed comb
uses the same public values rather than copying a second independent set of
numbers.

---

# The first printed helper: `TL1 v0.2`

The first helper is intentionally small. Its nominal envelope is about
**20.8 × 35 × 2.0 mm** and it is used next to the upper-left mounting column.

<img src="../../../raw/prod/verification/fixtures/hub75-p5-64x32-top-left-profile-comb.png" alt="TL1 v0.2 top-left profile comb" width="72%">

The helper is marked **`TL1 v0.2`** on the part itself. Always record that
identifier/version with the measurement results. If the fixture geometry changes,
its version must change too.

The comb is **not** a precision substitute for a caliper and it does not fit over
the mounting features. It stands beside them. Its job is to make the spatial
relationships easy to inspect:

- its long contact edge follows the expected top outer profile/taper;
- its rear blade hangs behind the panel;
- the upper witness hole/arm, raised **S**, marks the expected screw centre
  height;
- the lower witness hole/arm, raised **R**, marks the reinforcement centre
  height;
- the front edge of the witness arm represents the rear mounting plane;
- the raised line on the upper arm marks the expected 0.5 mm screw-tube tip.

The round witness holes are centre indicators only. Do **not** use their printed
diameter to accept or reject the physical screw or reinforcement diameter.

## Print the helper

Print it flat on its broad face:

- nominal thickness: 2.0 mm;
- no supports;
- normal dimensional print profile;
- do not scale the STL in the slicer.

The combined STL works for a normal one-colour print. For an AMS print, the
verification branch also provides an exactly aligned base STL and raised-markings
STL; import those as one multipart object and assign the markings a contrasting
filament.

Before using it, record printer/material/profile and check that the printed part
is flat. Measure its 2 mm thickness at a few places. If the part is visibly
warped, do not use it for the taper check.

---

# How to place `TL1`

<img src="../../../raw/prod/verification/plan/top-left-comb-square-use.png" alt="TL1 comb and SQ1 alignment guide positioned on upper-left model corner" width="82%">

The comb is used **perpendicular to the rear face**, not laid flat over the rear
of the panel. `SQ1 v0.1` is deliberately a separate orientation aid so printer
fit in SQ1 cannot silently become part of the dimensional measurement.

1. Put the panel rear side toward you.
2. Slide SQ1 over TL1 and move SQ1 to the straight front-most part of the top edge.
3. Put the long lower profile of TL1 on the physical **top edge**.
4. Let SQ1 sit naturally on the top edge so TL1 is held repeatably square across
   the panel width.
5. Position the comb a few millimetres to the side of the upper-left mounting
   tube so it does not collide with the tube itself.
6. Let the rear witness blade hang behind the panel next to the mounting tube and
   reinforcement feature.
7. Do not force either helper down. A forced fit hides exactly the discrepancy we
   are trying to see.

The strict side view below shows the intended relationship more clearly.

<img src="../../../raw/prod/verification/plan/top-left-comb-side.png" alt="Side view of TL1 comb on panel" width="82%">

---

# Check A — top outer profile / taper

With the comb resting on the top edge, inspect the contact from front to rear.

The expected sequence is:

```text
front physical top edge
        ↓ straight through front/PCB stack
rear taper starts at about Y=2.0 mm
        ↓ continuous slope
rear outer top edge is about 1.25 mm inward/down
at the Y=14.5 mm mounting plane
```

Look for:

- rocking of the comb;
- a visible gap at the front section;
- a visible gap along the sloped section;
- contact at the front but not the rear, or vice versa;
- an obvious short chamfer/step where the model expects a continuous slope.

Record the result as `agrees`, `investigate`, or `not checked`. If it does not
agree, photograph the comb and panel from the side before changing any model
value.

This is a **profile comparison**, not a measurement of a single magic angle.
If a discrepancy exists we can then measure the relevant Y/Z points separately.

---

# Check B — screw centre height from the top edge

Keep the comb seated on the top edge. View the upper witness hole/arm next to the
real mounting tube.

The real screw/tube centre should visually line up with the witness centre at:

```text
7.855 mm below the physical top edge
```

This is the Z-position check for TL-02.

Do not decide based on a photograph with strong perspective. Look approximately
square to the side of the witness blade, or photograph with the camera far enough
away to reduce perspective error.

For a numerical cross-check, measure the mounting tube OD first. If the tube is
8.50 mm, the expected distance from the physical top edge to the **nearest tube
tangent** is approximately:

```text
7.855 - 8.50/2 = 3.605 mm
```

That tangent measurement is a cross-check; the recorded model datum remains the
centre position.

---

# Check C — screw centre position from the left edge

The profile comb does not try to measure X and Z at the same time. That would
make one small printed part unnecessarily sensitive to printer fit error.

Measure the upper-left mounting tube position directly from the **left physical
panel edge**.

Expected centre position:

```text
7.850 mm from the left physical edge
```

Again, if the measured tube OD is 8.50 mm, a useful tangent cross-check is:

```text
7.850 - 8.50/2 = 3.600 mm
```

Record both the measured tube OD and the edge/tangent reading so the inferred
centre is reproducible.

---

# Check D — mounting tube and screw hole

Measure separately; do not let one printed fit decide all of these values.

Expected values:

```text
mounting tube OD        8.50 mm
through screw hole      3.00 mm
rear protrusion         0.50 mm
```

For OD, take at least two readings at roughly perpendicular jaw orientations.
For the hole, use the best available method: suitable pin/plug gauges are better
than trying to infer a small bore accurately from normal caliper jaws.

For rear protrusion, use the comb as a visual reference first. The front edge of
the upper witness arm corresponds to the 14.5 mm rear mounting plane; the raised
line marks the modelled tube end 0.5 mm farther rearward. Confirm numerically with
a depth/step method if the visual result is questionable.

---

# Check E — reinforcement position

The separate reinforcement feature below the screw is deliberately checked in
the same session because its relationship to the screw is important to mating
parts.

Expected centre relationship:

```text
same X centre as the upper-left screw
11.000 mm downward/inward from the screw centre
18.855 mm from the physical top edge
```

With `TL1` seated, the real reinforcement centre should line up with the lower
witness hole/arm.

This is a stronger first check than trying to infer its absolute position from a
large full-panel measurement.

---

# Check F — reinforcement sizes

Expected local dimensions:

```text
outer retained reinforcement region   Ø14.0 mm
rear recess                            Ø10.0 mm × 2.5 mm deep
blind hole                              Ø2.5 mm × 10.0 mm deep
```

At the upper-left corner the Ø14 outer feature approaches the tapered outside
wall. Do not assume its horizontal visible outline must be a perfect complete
circle: the model deliberately keeps the outside panel wall continuous. Prefer
the unobstructed vertical diameter and the recess/hole dimensions for direct
measurement.

Record the centre relation separately from the diameters/depths. A correct
centre does not prove a correct diameter, and vice versa.

---

# What to record for Stage 1

Use one sample ID, for example `P5-64X32-001`.

| ID | Reading / observation | Repeat | Result | Photo/note |
| --- | --- | --- | --- | --- |
| TL-01 | centre from left edge | ×3 where practical | pending | |
| TL-02 | centre from top edge | ×3 where practical | pending | |
| TL-03 | mounting tube OD | ≥2 orientations | pending | |
| TL-04 | screw hole diameter | method noted | pending | |
| TL-05 | tube protrusion | ≥2 | pending | |
| TL-06/TL-07 | reinforcement centre relation | ≥2 | pending | |
| TL-08 | reinforcement outer size | ≥2 | pending | |
| TL-09/TL-10 | recess diameter/depth | ≥2 | pending | |
| TL-11/TL-12 | blind-hole diameter/depth | method noted | pending | |
| TL-14/TL-15 | top taper/profile | visual + photo | pending | |

For each numerical measurement also record the measuring tool and its useful
resolution. Do not copy the model target into the reading field when a feature
was not actually measured.

## Result words

Use only these simple states during the first pass:

- **agrees** — no meaningful discrepancy is visible/measured with the current
  method;
- **investigate** — the observation differs enough that we should repeat it or
  use a better method before changing geometry;
- **not checked** — the feature could not be measured reliably in this session.

Do not invent a universal ±0.1 mm acceptance tolerance. Hole location, molded
outer surfaces, printed helper fit and small bore measurement do not have the
same uncertainty.

---

# Why the printed helper and caliper are both used

A printed helper is strong at **relationships**: contact profile, relative centre
height, and immediately visible mismatch. A caliper/pin/depth measurement is
stronger for an individual number.

The procedure therefore deliberately combines them:

```text
TL1 comb        shows where features should line up
caliper/pin     measures the actual local dimension
photo           preserves the physical observation
model accessor  gives the value being tested
```

None of those four sources replaces the others.

---

# Stage 2 and later

Only after Stage 1 is understandable and physically usable should the wider
panel checks be performed.

The existing helpers remain useful later:

- 144 mm horizontal mounting-column spacing gauge;
- 152 mm adjacent-row vertical spacing gauge;
- corner/rear datum experiments;
- rear-width comb;
- radius comparator;
- continuous-taper/profile fixtures for additional locations.

The next logical extension after the upper-left corner is to repeat the same
feature logic at another corner, then use the spacing gauges to prove that the
local mounting datums form the expected full pattern.

## Broader verification roadmap

After local corner verification, continue in this order:

1. physical envelope and complete mounting pattern;
2. rear mating rail/end/crossbar widths;
3. bay opening radii and stepped/narrow sections;
4. locator pins and other local mating features;
5. connector keep-outs;
6. visual-only markings last.

---

# Evidence and the future data repository

Keep three concepts separate for every dimension:

```text
specification / source value
        ↓
physical sample observation
        ↓
accepted library value
```

A measurement on one panel is evidence about that sample. It does not silently
replace a drawing-derived nominal value.

Raw measurements, photographs and sample identity should eventually live in the
planned companion repository `lib.scad.hub75.data`. The repository is not needed
until the first real measurement/evidence set exists. The creation decision and
proposed structure are tracked in the library issue for the companion data
repository.

Generated verification renders/STLs remain publication output below
`vrf/out/`; they are not raw physical evidence.

---

# Completion criteria

Do not call the whole P5 64 × 32 model physically verified after one corner.
Stage 1 is complete when:

1. the operator can identify and place `TL1 v0.2` with `SQ1 v0.1` without reading
   source code;
2. every TL-01…TL-15 item that can reasonably be checked has a recorded result;
3. questionable observations are photographed and marked `investigate`;
4. no library dimension has been changed merely to make a printed helper fit;
5. the procedure itself has been corrected if physical use shows that a datum or
   placement instruction is ambiguous.

The complete model is physically verified only after the later envelope,
mounting-pattern and rear-mating stages have equivalent evidence.