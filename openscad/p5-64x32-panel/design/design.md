# HUB75 P5 64 × 32 panel — OpenSCAD design

<!-- scad-render-defaults
engine: openscad
source: hub75_p5_64x32_panel_render.scad
module: hub75_p5_64x32_panel_design
vpr: [68, 0, 32]
-->

## Purpose

This document explains **how the physical panel model is built**.

You do not need to know OpenSCAD to follow the construction. The images and
plain-language explanation come first; source code is included afterwards so
we can trace a visible problem back to the model when needed.

The basic reading order is:

```text
physical feature
→ what it does / where it is
→ geometric change
→ image
→ relevant OpenSCAD code
```

For construction images:

```text
gray = geometry that already exists before the current step
red  = the addition, cutter or feature being discussed now
```

A completed result returns to a neutral color. Red is not used merely to mean
"this is the newest complete state".

Small details use close-up views, protruding rear features should be viewed
from the rear, and depth/profile questions should use a real section or profile
view.

Design images are generated at **1600 × 1200 px**.

## Panel overview

Before looking at dimensions or construction steps, first look at the complete
panel from both sides.

### Front — LED side

This is the flat visible side of the panel. In this model the panel is shown in
portrait orientation: roughly 160 mm wide and 320 mm high.

<!-- scad-render
view: front
vpr: [90, 0, 0]
-->

### Rear — mounting and connector side

Most construction detail is on the rear. This side contains the open bays,
rear frame, mounting geometry, locator pins and connector reference geometry.

Later detail images should be read in relation to this overview.

<!-- scad-render
view: rear
vpr: [90, 0, 180]
-->

## Orientation

The model uses three directions:

```text
X = left ↔ right across the short side
Y = front ↔ rear through the panel depth
Z = bottom ↔ top along the long side
```

The axis names are only reference language for later measurements; you do not
need to know OpenSCAD coordinates to understand the construction.

## Physical size versus placement size

The real panel body is slightly smaller than the nominal grid cell used when
panels are placed next to each other:

```text
                         width       height
physical panel          159.70 mm   319.71 mm
nominal placement cell  160.00 mm   320.00 mm
difference                0.30 mm     0.29 mm
```

That tiny difference matters when multiple panels are assembled.

### Physical panel body

This image establishes only the **real outside size of the panel body**.

<!-- scad-render
view: physical-envelope
vpr: [90, 0, 0]
-->

### Nominal 160 × 320 mm placement cell

The nominal cell is the space allocated to one panel in an array. The red
outline/area represents the difference between that nominal cell and the real
body. It is not another physical part of the panel.

<!-- scad-render
view: nominal-envelope
vpr: [90, 0, 0]
-->

### Horizontal placement clearance

The physical panel is 159.70 mm wide inside a nominal 160.00 mm grid cell:

```text
160.00 - 159.70 = 0.30 mm total difference
```

When centred, that leaves approximately **0.15 mm per side**.

The red area in the image visualises this small placement allowance. It is
space, not printable material.

<!-- scad-render
view: grid-gap-x
vpr: [90, 0, 0]
vpt: [-79.85, 14.5, 0]
vpd: 18
-->

The model calculates that total difference with:

```scad
hub75_p5_64x32_panel_grid_gap_x(panel);
```

In plain language: **how much narrower is the real panel than its nominal
160 mm placement width?**

### Vertical placement clearance

Along the long side:

```text
320.00 - 319.71 = 0.29 mm total difference
```

When centred, that leaves approximately **0.145 mm at each end**.

<!-- scad-render
view: grid-gap-z
vpr: [90, 0, 0]
vpt: [0, 14.5, -159.855]
vpd: 18
-->

The corresponding calculation is:

```scad
hub75_p5_64x32_panel_grid_gap_z(panel);
```

In plain language: **how much shorter is the real panel than its nominal
320 mm placement height?**

## Construction walkthrough

With the complete object, orientation and basic dimensions established, the
walkthrough can now start building the model from the front toward the rear.

## Front stack

The model starts at the visible front and builds toward the rear.

The front is represented by two thin physical layers: the front-facing
LED/mask layer and the PCB immediately behind it. Keeping those separate makes
it clear where the deeper rear housing begins.

### Front mask

```scad
module front_mask_shape() {
    cube([width, front_mask_depth_value, height]);
}
```

<!-- scad-render
view: front-mask
-->


### Front-mask depth plane

The red plane marks the back of the front mask.

<!-- scad-render
view: front-mask-depth
vpr: [90, 0, 90]
vpt: [0, 7.25, 0]
vpd: 55
-->


### PCB layer

```scad
module pcb_layer_shape() {
    translate([0, front_mask_depth_value, 0])
        cube([width, pcb_thickness_value, height]);
}
```

<!-- scad-render
view: pcb-layer
-->


### PCB rear plane

The rear housing starts at `front_mask_depth + pcb_thickness`.

<!-- scad-render
view: pcb-back-plane
vpr: [90, 0, 90]
vpt: [0, 7.25, 0]
vpd: 55
-->


### Completed front stack

Gray is the mask; red is the PCB added by the second construction step.

<!-- scad-render
view: front-stack
-->


## Rear housing envelope and taper

The STEP-derived housing begins behind the PCB and tapers continuously to the
rear mounting plane.

### Rear-housing start plane

<!-- scad-render
view: rear-start-plane
vpr: [90, 0, 90]
vpt: [0, 7.25, 0]
vpd: 65
-->


### Rear depth

This is a **local side view**, not a whole-panel view. The two planes are:

1. the PCB rear face at `Y = front_mask_depth + pcb_thickness = 2.0 mm`;
2. the nominal rear mounting plane at `Y = 14.50 mm`.

The distance between them is the depth available to the tapered rear housing.
The zoom is intentional: in the previous build auto-fit turned this relation
into two almost invisible lines.

<!-- scad-render
view: rear-depth
vpr: [90, 0, 90]
vpt: [0, 7.25, 0]
vpd: 90
-->


### Front footprint of the taper

<!-- scad-render
view: taper-front-footprint
vpr: [90, 0, 0]
-->


### Rear footprint of the taper

<!-- scad-render
view: taper-rear-footprint
vpr: [90, 0, 0]
-->


### Tapered outer blank

The actual blank is created by:

```scad
tapered_outer_blank(
    rear_frame_start_y,
    mounting_plane_y_value,
    0,
    rear_outer_inset_actual
);
```

<!-- scad-render
view: taper-body
-->


### Rear inset in X

<!-- scad-render
view: taper-inset-x
vpr: [90, 0, 0]
vpt: [-79.15, 14.5, 0]
vpd: 28
-->


### Rear inset in Z

<!-- scad-render
view: taper-inset-z
vpr: [90, 0, 0]
vpt: [0, 14.5, -159.155]
vpd: 28
-->


## Basic rear-frame dimensions

Before openings are cut, the object derives the widths that define the material
**left behind after the bay cutters are removed**.

The side/end/crossbar width images are local views of one representative rail.
The following `crossbar-positions` image returns to an overview because there
the repeated positions along the full 320 mm panel are the point.

### Side rail width

<!-- scad-render
view: side-rail-width
vpr: [90, 0, 0]
vpt: [-73.612, 14.5, 0]
vpd: 90
-->


### End rail width

<!-- scad-render
view: end-rail-width
vpr: [90, 0, 0]
vpt: [0, 14.5, -154.485]
vpd: 120
-->


### Crossbar width

<!-- scad-render
view: crossbar-width
vpr: [90, 0, 0]
vpt: [0, 14.5, 0]
vpd: 120
-->


### Three crossbar positions

```scad
rear_crossbar_z = [
    scale_z(rear_crossbar_1_ref),
    scale_z(rear_crossbar_2_ref),
    scale_z(rear_crossbar_3_ref)
];
```

<!-- scad-render
view: crossbar-positions
vpr: [90, 0, 0]
-->


## Four electronics bay openings

The frame is not constructed by adding individual rails. Instead a tapered
outer solid is created first and the four bay volumes are subtracted.

The reusable cutter is:

```scad
module rear_opening_2d(i, include_reliefs=true) {
    rounded_rect_2d(...);

    if(include_reliefs) {
        bay_end_relief_2d(z0, -1);
        bay_end_relief_2d(z1,  1);
    }
}
```

The `opening_z_min`/`opening_z_max` arrays are ordered from the **bottom
of the portrait model upward**. Each bay image is zoomed to the cutter and its
surrounding rails.

### Bay 1 basic rounded opening

<!-- scad-render
view: bay-1
vpr: [90, 0, 0]
vpt: [0, 14.5, -119.517]
vpd: 430
-->


### Bay 2

<!-- scad-render
view: bay-2
vpr: [90, 0, 0]
vpt: [0, 14.5, -39.964]
vpd: 430
-->


### Bay 3

<!-- scad-render
view: bay-3
vpr: [90, 0, 0]
vpt: [0, 14.5, 39.964]
vpd: 430
-->


### Bay 4

<!-- scad-render
view: bay-4
vpr: [90, 0, 0]
vpt: [0, 14.5, 119.517]
vpd: 430
-->


### Rounded-corner geometry

This close-up moves to one lower corner of the first bay. Red is the actual
`rounded_rect_2d()` cutter. The radius belongs to the opening cutter; after the
Boolean subtraction the surrounding gray rail gets the complementary rounded
inside corner.

<!-- scad-render
view: bay-rounded-corner
vpr: [90, 0, 0]
vpt: [-62.873, 14.5, -144.615]
vpd: 70
-->


### Bottom edge relief

The normal end rail is too wide in the centre according to the STEP reference.
The red relief extends the bay cutter into that rail.

Removing it changes the rail locally from the normal 10.75 mm width to the
7.75 mm narrow width.

<!-- scad-render
view: bay-bottom-relief
vpr: [90, 0, 0]
vpt: [0, 14.5, -149.115]
vpd: 150
-->


### Top edge relief

The same helper is mirrored by the `direction` argument.

<!-- scad-render
view: bay-top-relief
vpr: [90, 0, 0]
vpt: [0, 14.5, -89.918]
vpd: 150
-->


### Combined four-bay cutter

```scad
module rear_openings_2d() {
    for(i=[0:3])
        rear_opening_2d(i);
}
```

<!-- scad-render
view: rear-openings
vpr: [90, 0, 0]
-->


## From solid web to rear frame

### Solid rear web before bay subtraction

<!-- scad-render
view: rear-web-solid
vpr: [90, 0, 0]
-->


### 2D frame web after subtraction

```scad
difference() {
    square([width, height]);
    rear_openings_2d();
}
```

<!-- scad-render
view: rear-web-cut
vpr: [90, 0, 0]
-->


### 3D tapered frame core

The outer wall tapers, but the bay walls remain vertical:

```scad
difference() {
    tapered_outer_blank(...);
    rear_extrude_from_to(...)
        rear_openings_2d();
}
```

<!-- scad-render
view: rear-frame-core
-->


## Narrow stepped end-rail profile

The STEP reference shows that each bay edge is not a constant straight rail.
The production cutter is now decomposed into the same semantic pieces shown in
the design sequence:

```text
left 45° transition
        +
central narrow relief
        +
right 45° transition
        =
complete bay-end relief
```

The camera remains on one bay edge so the 3 mm step is visible.

```text
normal end rail   10.75 mm
narrow section     7.75 mm
difference          3.00 mm
```

### Narrow width

<!-- scad-render
view: narrow-end-width
vpr: [90, 0, 0]
vpt: [0, 14.5, -149.115]
vpd: 150
-->


### Narrow-section length

<!-- scad-render
view: narrow-end-length
vpr: [90, 0, 0]
vpt: [0, 14.5, -149.115]
vpd: 150
-->


### First 45° transition

`bay_end_transition_relief_2d(..., "left")` makes the left triangular cutter.
Its horizontal run equals the 3 mm width change, giving the required 45° edge.

<!-- scad-render
view: narrow-transition-left
vpr: [90, 0, 0]
vpt: [0, 14.5, -149.115]
vpd: 150
-->


### Mirrored transition

This is the separate right-hand production helper. In the previous build both
transition images effectively showed the same complete trapezoid; they now
show different geometry.

<!-- scad-render
view: narrow-transition-right
vpr: [90, 0, 0]
vpt: [0, 14.5, -149.115]
vpd: 150
-->


### Completed stepped profile

<!-- scad-render
view: narrow-profile-complete
vpr: [90, 0, 0]
vpt: [0, 14.5, -149.115]
vpd: 150
-->



## Rear-frame construction states

The rear-frame implementation now exposes real intermediate production states:

```text
rear_frame_base()
        ↓  subtract rear-face recess
rear_frame_after_recess()
        ↓  subtract mounting-tube reliefs
rear_frame_after_mounting_reliefs()
        ↓  add Ø8.50 mounting tubes
rear_frame_with_mounting_tubes()
        ↓  cut reinforcement recesses + blind holes
rear_frame_after_reinforcement_cuts()
        ↓  add locator pins
rear_frame_structure()
```

For each design step, **gray is the state immediately before the current
operation**. Red is only the volume introduced or removed by that operation.
This corrects an important problem in the previous build: several features were
already present in the completed gray context underneath their red highlight.

## Rear-face recess

The rear rail face is recessed by `rear_recess_depth`. This is **not one large
rectangular pocket**. The cutter is composed from:

```text
left + right side strips
top + bottom end strips
three crossbar strips that follow the stepped web contour
minus six protected reinforcement footprints
```

The first images are local details. `rear-recess-2d` later shows the complete
composed cutter.

### Left side recess

```scad
rear_side_recess_2d("left");
```

<!-- scad-render
view: recess-side-left
vpr: [90, 0, 0]
vpt: [-73.612, 14.5, 0]
vpd: 140
-->


### Right side recess

<!-- scad-render
view: recess-side-right
vpr: [90, 0, 0]
vpt: [73.612, 14.5, 0]
vpd: 140
-->


### Bottom end recess

```scad
rear_end_recess_2d("bottom");
```

<!-- scad-render
view: recess-bottom
vpr: [90, 0, 0]
vpt: [0, 14.5, -154.485]
vpd: 150
-->


### Top end recess

<!-- scad-render
view: recess-top
vpr: [90, 0, 0]
vpt: [0, 14.5, 154.485]
vpd: 150
-->


### Crossbar 1 recess

The crossbar recess is intersected with the **actual stepped web**, not a
straight rectangle.

<!-- scad-render
view: recess-crossbar-1
vpr: [90, 0, 0]
vpt: [0, 14.5, -79.927]
vpd: 210
-->


### Crossbar 2 recess

<!-- scad-render
view: recess-crossbar-2
vpr: [90, 0, 0]
vpt: [0, 14.5, 0]
vpd: 210
-->


### Crossbar 3 recess

<!-- scad-render
view: recess-crossbar-3
vpr: [90, 0, 0]
vpt: [0, 14.5, 79.927]
vpd: 210
-->


### Reinforcement footprints protected from the recess

This close-up is centred on one Ø14 reinforcement footprint. The circle denotes
material that must remain at the original mounting-plane level.

It is therefore subtracted from the **recess cutter**, not from the panel. The
same protection is repeated at all six positions:

```scad
difference() {
    rear_recess_raw_2d();
    reinforcement_bushing_footprints_2d();
}
```

<!-- scad-render
view: recess-bushing-protection
vpr: [90, 0, 0]
vpt: [-72.0, 14.5, -141.0]
vpd: 100
-->


### Final 2D recess cutter

<!-- scad-render
view: rear-recess-2d
vpr: [90, 0, 0]
-->


### Recess cutter extruded into 3D

<!-- scad-render
view: rear-recess-3d
vpr: [65, 0, 35]
vpt: [0, 10, 0]
vpd: 260
-->


### Rear frame after recess

<!-- scad-render
view: rear-after-recess
-->


## Drawing-derived mounting layout

The six mounting centres come directly from the drawing. They are deliberately
not scaled with the STEP-derived structural geometry.

### Left column

<!-- scad-render
view: mounting-column-left
vpr: [90, 0, 0]
-->


### Right column

<!-- scad-render
view: mounting-column-right
vpr: [90, 0, 0]
-->


### Bottom row

<!-- scad-render
view: mounting-row-bottom
vpr: [90, 0, 0]
vpt: [0, 14.5, -152.0]
vpd: 450
-->


### Middle row

<!-- scad-render
view: mounting-row-middle
vpr: [90, 0, 0]
vpt: [0, 14.5, 0]
vpd: 450
-->


### Top row

<!-- scad-render
view: mounting-row-top
vpr: [90, 0, 0]
vpt: [0, 14.5, 152.0]
vpd: 450
-->


### All six centres

```scad
for(x=hole_x_positions)
    for(z=hole_z_positions)
        ...
```

<!-- scad-render
view: mounting-centres
vpr: [90, 0, 0]
-->


## Mounting tubes, reliefs and screw cuts

The gray state deliberately changes through this sequence:

```text
mounting relief
    gray = frame after rear recess

mounting tube
    gray = frame after mounting reliefs

mounting hole
    gray = assembled panel before the final through-hole cut
```


The three `single` images stay on the lower-left mounting centre and explain
three separate operations:

```text
shallow circular rail relief
        ↓
Ø8.50 cylindrical tube
        ↓
Ø3 through-hole cutter
```

The circular relief prevents the tube from visually merging into the flat rail.
The later overview images show that this same construction is repeated at six
drawing-derived centres.

### One Ø8.50 mounting tube

```scad
mounting_tube(x, z);
```

<!-- scad-render
view: mounting-tube-single
vpr: [68, 0, 212]
vpt: [-72.0, 10, -152.0]
vpd: 90
-->


### All mounting tubes

<!-- scad-render
view: mounting-tubes
vpr: [68, 0, 212]
-->


### One circular rail relief

The local rail is recessed around the tube before the tube is added back.

<!-- scad-render
view: mounting-relief-single
vpr: [90, 0, 0]
vpt: [-72.0, 14.5, -152.0]
vpd: 78
-->


### All six rail reliefs

<!-- scad-render
view: mounting-reliefs
-->


### One Ø3 mounting-hole cutter

<!-- scad-render
view: mounting-hole-single
vpr: [65, 0, 35]
vpt: [-72.0, 10, -152.0]
vpd: 85
-->


### Six through-hole cutters

The final through holes are one Boolean operation through the complete panel:

```scad
difference() {
    panel_solid_before_mounting_holes();
    mounting_hole_cutters();
}
```

<!-- scad-render
view: mounting-holes
-->


## Reinforcement bushing positions

These Ø14 features are separate from the Ø8.50 mounting tubes. Their placement
is intentionally asymmetric in the middle pair.

### Bottom-left

<!-- scad-render
view: reinforcement-bottom-left
vpr: [68, 0, 212]
vpt: [-72.0, 14.5, -141.0]
vpd: 95
-->


### Bottom-right

<!-- scad-render
view: reinforcement-bottom-right
vpr: [68, 0, 212]
vpt: [72.0, 14.5, -141.0]
vpd: 95
-->


### Middle-left

<!-- scad-render
view: reinforcement-middle-left
vpr: [68, 0, 212]
vpt: [-72.0, 14.5, 11]
vpd: 95
-->


### Middle-right

<!-- scad-render
view: reinforcement-middle-right
vpr: [68, 0, 212]
vpt: [72.0, 14.5, -11]
vpd: 95
-->


### Top-left

<!-- scad-render
view: reinforcement-top-left
vpr: [68, 0, 212]
vpt: [-72.0, 14.5, 141.0]
vpd: 95
-->


### Top-right

<!-- scad-render
view: reinforcement-top-right
vpr: [68, 0, 212]
vpt: [72.0, 14.5, 141.0]
vpd: 95
-->


## Reinforcement bushing construction

For the Ø10 recess and Ø2.5 blind-hole views, the gray state contains the Ø14
reinforcement material and mounting tubes but **does not already contain those
cuts**.


These four images are close-ups of one representative feature:

```text
Ø14 retained/added material
        ↓
Ø10 recess, 2.5 mm deep
        ↓
Ø2.5 blind hole, 10 mm deeper
        ↓
flush Ø14 rear land remains
```

This is deliberately separate from the Ø8.50 mounting tube.

### Solid Ø14 retained material

The bushing solids are added before recess/cut operations so bay subtraction
does not destroy them.

<!-- scad-render
view: reinforcement-solids
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->


### Ø10 inner recess

<!-- scad-render
view: reinforcement-inner-recess
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->


### Ø2.5 blind hole

<!-- scad-render
view: reinforcement-blind-hole
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->


### Finished reinforcement geometry

The rear face remains flush with the mounting plane.

<!-- scad-render
view: reinforcement-finished
vpr: [65, 0, 35]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->


## Locator pins

The two Ø3 × 3 mm locator pins come from explicit drawing dimensions. The first
two renders are close-ups so the pin itself is visible; the third returns to an
overview to show their diagonal relationship.

### Upper-left locator

<!-- scad-render
view: locator-upper-left
vpr: [68, 0, 212]
vpt: [-75, 10, 110]
vpd: 95
-->


### Lower-right locator

<!-- scad-render
view: locator-lower-right
vpr: [68, 0, 212]
vpt: [75, 10, -110]
vpd: 95
-->


### Both locator pins

```scad
for(pos=locator_pin_positions)
    locator_pin(pos[0], pos[1]);
```

<!-- scad-render
view: locator-pins
vpr: [68, 0, 212]
-->


## Connector reference volumes

The connector models are clearance/reference volumes rather than detailed
electrical CAD. Individual connectors are shown close-up first; the overview
then explains their placement in the complete panel.

### Bottom HUB75 data connector

<!-- scad-render
view: data-connector-bottom
vpr: [68, 0, 212]
vpt: [0, 10, -113.5]
vpd: 135
-->


### Top HUB75 data connector

<!-- scad-render
view: data-connector-top
vpr: [68, 0, 212]
vpt: [0, 10, 113.5]
vpd: 135
-->


### Data connector pair

<!-- scad-render
view: data-connectors
vpr: [68, 0, 212]
-->


### Power connector

The power connector remains explicitly approximate because the dimensional
drawing does not locate it.

<!-- scad-render
view: power-connector
vpr: [68, 0, 212]
vpt: [-26.949, 10, -31.971]
vpd: 130
-->


## Orientation markers

The PCB arrows are visual/orientation references, not mechanical dimensions.

### Bay 1 down arrow

<!-- scad-render
view: orientation-bay-1
vpr: [68, 0, 212]
vpt: [38, 14.5, 113.5]
vpd: 160
-->


### Bay 2 right arrow

<!-- scad-render
view: orientation-bay-2
vpr: [68, 0, 212]
vpt: [-60, 14.5, 39.964]
vpd: 160
-->


### Bay 4 down + right arrows

<!-- scad-render
view: orientation-bay-4
vpr: [68, 0, 212]
vpt: [0, 14.5, -119.517]
vpd: 190
-->


### Complete orientation layout

<!-- scad-render
view: orientation-all
vpr: [68, 0, 212]
-->


## Drawing verification

The verification sequence deliberately uses only drawing-supported geometry.

### Physical envelope

<!-- scad-render
view: verification-envelope
vpr: [90, 0, 0]
-->


### Six mounting centres

<!-- scad-render
view: verification-mounting
vpr: [90, 0, 0]
-->


### Two locator centres

<!-- scad-render
view: verification-locators
vpr: [90, 0, 0]
-->


## Mating and profile checks

These views are not new construction operations. They make the interfaces used
by future couplers/enclosures explicit after the build sequence is understood.

The previous build collapsed several side views into nearly one-pixel-wide
lines because the whole 320 mm panel was auto-fitted. The taper, rail and final
profile now use a **thin X-section** plus a local side camera so the 14.5 mm
depth stack can actually be read.

### Rear mounting plane

```scad
hub75_p5_64x32_panel_mounting_plane_y(panel);
```

<!-- scad-render
view: rear-mating-plane
vpr: [90, 0, 90]
vpt: [0, 7.25, 0]
vpd: 100
-->


### Taper profile

<!-- scad-render
view: taper-profile
vpr: [90, 0, 90]
vpt: [0, 7.25, 0]
vpd: 110
-->


### Rear rail profile

<!-- scad-render
view: rear-rail-profile
vpr: [90, 0, 90]
vpt: [0, 7.25, 0]
vpd: 120
-->


### Connector clearance profile

<!-- scad-render
view: connector-clearance-profile
vpr: [90, 0, 90]
vpt: [0, 7.25, -113.5]
vpd: 130
-->


### Final rear reference

<!-- scad-render
view: final-rear
vpr: [90, 0, 0]
-->


### Final side/profile reference

<!-- scad-render
view: final-profile
vpr: [90, 0, 90]
vpt: [0, 7.25, 0]
vpd: 120
-->


## Public API

The public consumer remains small:

```scad
use <hub75_p5_64x32_panel.scad>

panel = hub75_p5_64x32_panel_create();

hub75_p5_64x32_panel_build(panel);
```

The design infrastructure does not create a second public model API. It exists
only to expose the construction code in documentation.

The public object remains the single source for dimensions and derived mating
information.

## Design-render architecture

The documentation entry point stays deliberately small:

```scad
module hub75_p5_64x32_panel_design(view = "final") {
    panel = hub75_p5_64x32_panel_create();

    hub75_p5_64x32_panel_render(
        panel,
        view = hub75_p5_64x32_panel_view_id(view)
    );
}
```

The authoritative constants and one name-to-ID conversion function both live
in `hub75_p5_64x32_panel.scad`:

```scad
HUB75_P5_64X32_PANEL_VIEW_FINAL = 0;
HUB75_P5_64X32_PANEL_VIEW_PHYSICAL_ENVELOPE = 101;
HUB75_P5_64X32_PANEL_VIEW_REAR_FRAME_CORE = 131;
HUB75_P5_64X32_PANEL_VIEW_MOUNTING_TUBES = 155;

function hub75_p5_64x32_panel_view_id(view) =
    view == "final" ? HUB75_P5_64X32_PANEL_VIEW_FINAL :
    view == "physical-envelope" ? HUB75_P5_64X32_PANEL_VIEW_PHYSICAL_ENVELOPE :
    view == "rear-frame-core" ? HUB75_P5_64X32_PANEL_VIEW_REAR_FRAME_CORE :
    view == "mounting-tubes" ? HUB75_P5_64X32_PANEL_VIEW_MOUNTING_TUBES :
    ...
    HUB75_P5_64X32_PANEL_VIEW_FINAL;
```

OpenSCAD `use <...>` does not import file-level constants. Keeping the
conversion function in the implementation file avoids both duplicated numeric
IDs and one accessor function per constant.

The repository remains generic (`lib.scad.hub75`), while this component is
explicitly specific to a P5, 64 × 32 pixel, nominal 320 × 160 mm HUB75 panel.
