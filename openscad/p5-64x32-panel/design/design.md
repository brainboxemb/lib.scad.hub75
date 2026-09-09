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
vpr: [90, 0, 0]
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
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 130
-->

The protected circular areas are important because later reinforcement features
depend on that unrecessed material.

The production state is made by subtracting the composed recess cutter from the
rear-frame base:

```scad
module rear_frame_after_recess() {
    difference() {
        rear_frame_base();

        rear_extrude_from_to(...)
            rear_recess_2d();
    }
}
```

The important part is the `difference()`: the already-built frame is the
starting solid, and `rear_recess_2d()` describes the shallow material that is
removed.

## 4. Mounting system

The drawing defines six mounting centres: two columns by three rows.

### Six repeated mounting positions

Rather than showing abstract centre markers, this overview shows the actual
mounting tubes repeated at the six drawing-derived positions.

**View:** `mounting-tubes`

<!-- scad-render
view: mounting-tubes
vpr: [68, 0, 212]
-->

At every position the model performs three related operations:

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

The repetition is literal in the production code:

```scad
for(x = hole_x_positions)
    for(z = hole_z_positions)
        mounting_tube(x, z);
```

`hole_x_positions` supplies the two columns and `hole_z_positions` the three
rows. Combining both loops creates the six physical mounting locations.

### Screw hole through the mounting position

The red cylinder is the material removed for the screw path.

The tube itself is constructed as a hollow cylinder: an outer cylinder is made,
then the Ø3 mm screw path is subtracted from it.

```scad
module mounting_tube(x, z) {
    difference() {
        translate([x, rear_frame_start_y, z])
            rotate([-90, 0, 0])
                cylinder(
                    h = mounting_plane_y_value
                        - rear_frame_start_y
                        + mounting_tube_protrusion_value,
                    d = mounting_tube_outer_diameter_value
                );

        translate([x, -0.5, z])
            rotate([-90, 0, 0])
                cylinder(
                    h = max_depth_value + 1.0,
                    d = hole_diameter_value
                );
    }
}
```

So physically: **make the Ø8.50 tube, then bore the Ø3 screw hole through it**.

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

The solid reinforcement geometry is generated at each configured position:

```scad
for(pos = reinforcement_bushing_positions)
    translate([
        pos[0],
        mounting_plane_y_value - reinforcement_bushing_inner_depth,
        pos[1]
    ])
        rotate([-90, 0, 0])
            cylinder(
                h = reinforcement_bushing_inner_depth,
                d = reinforcement_bushing_outer_diameter_value
            );
```

That is the Ø14 reinforcement volume before its inner cuts are made.

One extra geometric rule matters here: the reinforcement may remain round on
the **inside/bay side**, but it must not bulge through the outside wall. The
production code therefore clips the cylinders with the same tapered outer
housing envelope:

```scad
intersection() {
    union()
        for(pos = reinforcement_bushing_positions)
            reinforcement_bushing_cylinder(pos);

    tapered_outer_blank(
        rear_frame_start_y,
        mounting_plane_y_value,
        0,
        rear_outer_inset_actual
    );
}
```

So the inside keeps the circular reinforcement shape, while the outside follows
the continuous tapered panel wall exactly.

**View:** `reinforcement-solids`

<!-- scad-render
view: reinforcement-solids
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->

### Inner recess

A Ø10 recess is then removed from that reinforcement feature.

```scad
module reinforcement_bushing_inner_recess_cuts() {
    for(pos = reinforcement_bushing_positions)
        translate([
            pos[0],
            mounting_plane_y_value
                - reinforcement_bushing_inner_recess_value,
            pos[1]
        ])
            rotate([-90, 0, 0])
                cylinder(
                    h = reinforcement_bushing_inner_recess_value + 0.02,
                    d = reinforcement_bushing_inner_diameter_value
                );
}
```

This cutter starts at the rear mounting face and removes only the shallow Ø10
part.

**View:** `reinforcement-inner-recess`

<!-- scad-render
view: reinforcement-inner-recess
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->

### Blind hole

A smaller Ø2.5 blind hole continues deeper into the feature.

```scad
module reinforcement_bushing_blind_hole_cuts() {
    for(pos = reinforcement_bushing_positions)
        translate([
            pos[0],
            mounting_plane_y_value
                - reinforcement_bushing_inner_recess_value
                - reinforcement_bushing_hole_depth_value,
            pos[1]
        ])
            rotate([-90, 0, 0])
                cylinder(
                    h = reinforcement_bushing_hole_depth_value + 0.02,
                    d = reinforcement_bushing_hole_diameter_value
                );
}
```

The position starts below the Ø10 recess floor, which is why this becomes a
blind hole rather than another through-opening.

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

The production helper is intentionally simple:

```scad
module locator_pin(x, z) {
    translate([x, mounting_plane_y_value, z])
        rotate([-90, 0, 0])
            cylinder(
                h = locator_pin_protrusion_value,
                d = locator_pin_diameter_value
            );
}
```

In other words: place a Ø3 cylinder on the rear mounting plane and let it
project 3 mm outward.

**View:** `locator-upper-left`

<!-- scad-render
view: locator-upper-left
vpr: [68, 0, 212]
vpt: [-75, 10, 110]
vpd: 95
-->

### Second locator position

The second locator pin is on the opposite diagonal side of the rear. The full
panel overview at the start already shows their relationship, so a second
full-panel locator render is not repeated here.

## 7. Connector reference geometry

The connector shapes are **clearance/reference volumes**. They are not detailed
electrical connector CAD.

That distinction matters when this panel model is later used to design an
enclosure or coupler: the space occupied by a connector matters more than its
small cosmetic details.

### One HUB75 data connector

The connector is modelled as a simple clearance box:

```scad
translate([
    data_connector_x - data_connector_width / 2,
    data_connector_front_y_value,
    z - data_connector_height / 2
])
    cube([
        data_connector_width,
        data_connector_depth_value,
        data_connector_height
    ]);
```

The box is intentionally simpler than the real connector; its job is to reserve
the mechanical space that an enclosure must keep clear.

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

It uses the same principle as the data connector: a simple box is placed at the
approximate measured/reference position.

```scad
translate([
    power_connector_x - power_connector_width_value / 2,
    pcb_back_y + 1.0,
    power_connector_z - power_connector_height_value / 2
])
    cube([
        power_connector_width_value,
        power_connector_depth_value,
        power_connector_height_value
    ]);
```

**View:** `power-connector`

<!-- scad-render
view: power-connector
vpr: [68, 0, 212]
vpt: [-26.949, 10, -31.971]
vpd: 130
-->

## 8. Return to the complete rear

At this point, return to the **Rear** overview at the start of the document.

The purpose is comparison: after following the construction steps, the four
bays, mounting tubes, reinforcement areas, locator pins and connector locations
should now be recognisable as parts of one physical object.

A second "final rear" render is intentionally not repeated here. In the earlier
documentation it added another nearly identical image without adding new
understanding.

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
render-view selector are documented in the source file
`openscad/p5-64x32-panel/manual.md`.

The generated build currently publishes the design walkthrough itself, not that
separate source manual, so this text deliberately does not create a broken
relative link from the generated build branch.
