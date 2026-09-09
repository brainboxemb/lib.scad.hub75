# HUB75 P5 64 × 32 panel — design

<!-- scad-render-defaults
engine: openscad
source: hub75_p5_64x32_panel_render.scad
module: hub75_p5_64x32_panel_design
vpr: [68, 0, 32]
-->

## Purpose

This document explains how the **physical model is constructed**.

It is written for a reader who does not need to know OpenSCAD. The order is
deliberate:

```text
physical part
→ what it does
→ what changes geometrically
→ a useful image
→ the relevant code
```

A render only belongs in this document when it helps explain the construction.
The renderer itself contains additional diagnostic views for development; those
do not all need to appear here.

For construction images:

```text
gray = geometry that already exists before the step
red  = the addition, cutter or feature being discussed
```

A completed state returns to a neutral colour.

## First orient yourself

The panel is shown in portrait orientation in this library.

### Front

The front is the flat LED side. There is intentionally little mechanical detail
here; most of the model complexity is on the rear.

**View:** `front`

<!-- scad-render
view: front
vpr: [90, 0, 0]
-->

### Rear

The rear overview is the reference image for the rest of this document. It
shows the four large electronics bays, the frame around them, mounting
locations and connector reference geometry.

When a later close-up becomes hard to place, return to this image first.

**View:** `rear`

<!-- scad-render
view: rear
vpr: [90, 0, 180]
-->

## 1. Front body

The front of the model is simple compared with the rear. It is represented by
two thin layers:

```text
front mask / LED-side body
        +
PCB layer immediately behind it
```

The important design decision is not the exact OpenSCAD operation, but that the
rear housing starts **behind both layers** rather than at the visible front
surface.

The production helpers are:

```scad
front_mask_shape();
pcb_layer_shape();
```

There is no separate render here for a "depth plane". A plane marking an
internal coordinate is useful for debugging but does not make this physical
construction easier to understand.

## 2. Rear frame

The rear housing starts as a tapered outer body. Four large openings are then
removed from it, leaving the outer rails and three crossbars.

Conceptually:

```text
tapered rear body
    ↓ remove four electronics bays
outer side rails + end rails + three crossbars
```

### Rear frame after the four bay openings

This image shows the resulting structural frame before the later recesses,
mounting features and locator pins are added.

**View:** `rear-frame-core`

<!-- scad-render
view: rear-frame-core
vpr: [68, 0, 32]
-->

The production construction is a Boolean subtraction:

```scad
difference() {
    tapered_outer_blank(...);
    rear_extrude_from_to(...)
        rear_openings_2d();
}
```

In plain language: make the full rear body first, then cut the four large
electronics spaces out of it.

### Stepped bay edges

The top and bottom edge of a bay is not a constant-width straight rail. The STEP
reference shows a narrower centre section with a short transition at each side.

```text
normal rail width   10.75 mm
narrow section       7.75 mm
difference            3.00 mm
```

The code constructs that local shape from three pieces:

```text
left transition + central narrow relief + right transition
```

The renderer still exposes the individual transition views for debugging, but
they are intentionally not shown here: in the previous documentation they
looked like isolated grey fragments and added more confusion than explanation.

## 3. Rear-face recess

The rear-facing surface of the frame is not all at one level. A shallow recess
is removed from much of the rail surface.

The recess follows:

- both long side rails;
- the top and bottom rails;
- all three crossbars.

Six circular reinforcement areas are deliberately protected so they remain at
the original mounting-plane height.

### Completed frame after the recess

This is the useful construction result: the main frame already exists and the
shallow rear-face recess has been removed.

**View:** `rear-after-recess`

<!-- scad-render
view: rear-after-recess
vpr: [68, 0, 32]
-->

The protected circular areas are important because later reinforcement features
depend on that unrecessed material.

## 4. Mounting system

The drawing defines six mounting centres: two columns by three rows.

### Position of the six mounting centres

This overview exists only to answer **where are the six mounting points?**

**View:** `mounting-centres`

<!-- scad-render
view: mounting-centres
vpr: [90, 0, 0]
-->

At every centre the model then performs three related operations:

```text
local rail relief
      ↓
Ø8.50 mounting tube
      ↓
Ø3 screw hole
```

### One mounting tube

This close-up is the representative mounting position. The existing frame is
gray; the Ø8.50 tube being added is red.

**View:** `mounting-tube-single`

<!-- scad-render
view: mounting-tube-single
vpr: [68, 0, 212]
vpt: [-72.0, 10, -152.0]
vpd: 90
-->

The same tube construction is repeated at all six drawing-derived centres.

### Screw hole through the mounting position

The red cylinder is the material removed for the screw path.

**View:** `mounting-hole-single`

<!-- scad-render
view: mounting-hole-single
vpr: [65, 0, 35]
vpt: [-72.0, 10, -152.0]
vpd: 85
-->

## 5. Reinforcement beside the mounting points

The Ø14 reinforcement feature is **not the same thing as the Ø8.50 mounting
tube**. It is nearby and supplies extra material around the mounting area.

Its construction is easier to understand as one representative feature rather
than six nearly identical position images.

### Reinforcement material

The red geometry is the Ø14 reinforcement material added to the already-built
rear frame.

**View:** `reinforcement-solids`

<!-- scad-render
view: reinforcement-solids
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->

### Inner recess

A Ø10 recess is then removed from that reinforcement feature.

**View:** `reinforcement-inner-recess`

<!-- scad-render
view: reinforcement-inner-recess
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->

### Blind hole

A smaller Ø2.5 blind hole continues deeper into the feature.

**View:** `reinforcement-blind-hole`

<!-- scad-render
view: reinforcement-blind-hole
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->

The important geometry to check here is the relationship between the
reinforcement feature and the neighbouring mounting tube.

## 6. Locator pins

Two small Ø3 × 3 mm pins project from the rear. They are explicit physical
features from the drawing, not visual markers.

### One locator pin

This close-up shows the actual pin protruding from the rear surface.

**View:** `locator-upper-left`

<!-- scad-render
view: locator-upper-left
vpr: [68, 0, 212]
vpt: [-75, 10, 110]
vpd: 95
-->

### Both locator positions

The overview makes their diagonal relationship visible.

**View:** `locator-pins`

<!-- scad-render
view: locator-pins
vpr: [68, 0, 212]
-->

## 7. Connector reference geometry

The connector shapes are **clearance/reference volumes**. They are not detailed
electrical connector CAD.

That distinction matters when this panel model is later used to design an
enclosure or coupler: the space occupied by a connector matters more than its
small cosmetic details.

### One HUB75 data connector

**View:** `data-connector-bottom`

<!-- scad-render
view: data-connector-bottom
vpr: [68, 0, 212]
vpt: [0, 10, -113.5]
vpd: 135
-->

### Both data connector positions

**View:** `data-connectors`

<!-- scad-render
view: data-connectors
vpr: [68, 0, 212]
-->

### Power connector reference

The power connector position remains approximate because the dimensional
drawing does not locate it authoritatively.

**View:** `power-connector`

<!-- scad-render
view: power-connector
vpr: [68, 0, 212]
vpt: [-26.949, 10, -31.971]
vpd: 130
-->

## 8. Completed rear

At this point the reader has seen the major physical operations that create the
rear structure.

**View:** `final-rear`

<!-- scad-render
view: final-rear
vpr: [90, 0, 180]
-->

The purpose of this final image is comparison: after following the construction
steps, the completed rear should now be recognisable rather than appearing as
an unexplained collection of details.

## What is deliberately not in this document?

Several renderer views remain available in the OpenSCAD Customizer for
debugging, including:

- individual X/Z placement-gap visualisations;
- internal depth planes;
- every individual bay cutter;
- every individual reinforcement position;
- drawing-verification overlays;
- experimental profile/section views.

They are useful tools, but they do not automatically belong in the design
narrative.

Usage, nominal placement dimensions, coordinate conventions and the interactive
render-view selector belong in [../manual.md](../manual.md).
