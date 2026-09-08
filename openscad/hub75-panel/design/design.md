# HUB75 P5 panel reference model

The `hub75-panel` component is a reusable mechanical reference model for the
HUB75 P5 64 × 32 LED matrix panel represented by the supplied source model.

The source model records three geometry references:

- `Hub75 P5 Matrix Panel.step`;
- `2277_P5_320x160mm_64x32+pixel.pdf`;
- a rear-panel photograph used as a secondary visual reference.

The library does not claim additional measurements beyond those already
recorded in the supplied OpenSCAD source.

<!-- scad-render-defaults
engine: openscad
source: hub75_panel_render.scad
module: hub75_panel_design
vpr: [68, 0, 32]
-->

## Coordinate system

The component uses the portrait orientation required by the original project:

```text
X
    panel width, centred at X = 0

Y
    front to rear, front face at Y = 0

Z
    panel height, centred at Z = 0
```

The drawing-derived dimensions remain convenient internally as lower-left
coordinates, while the complete component is translated to a centred external
coordinate system.

<!-- scad-render
view: final
-->

## Public specification object

Mechanical data belongs to one OpenSCAD object:

```scad
panel = hub75_panel_create();

hub75_panel_build(panel);
```

Consumers should pass the panel object through assemblies and mating-component
calculations rather than copying HUB75 dimensions into project configuration.

Important default physical values are:

| Property | Default |
| --- | ---: |
| physical width | 159.70 mm |
| physical height | 319.71 mm |
| nominal placement cell | 160 × 320 mm |
| overall depth | 14.50 mm |
| rear housing taper inset | 1.25 mm per side |
| mounting hole | Ø3.00 mm |
| mounting tube | Ø8.50 mm |
| locator pin | Ø3 × 3 mm |

Derived geometry such as centred screw positions, grid margins and effective
rear rail widths is calculated from the object.

## Front envelope

The front envelope follows the supplied source dimensions. The model records a
1.00 mm front mask and 1.00 mm PCB layer before the rear structural housing.

<!-- scad-render
view: front
vpr: [90, 0, 0]
-->

The nominal placement cell remains 160 × 320 mm while the physical panel is
slightly undersize. This distinction is important for panel-to-panel seams and
must not be replaced with a single nominal width/height value.

## Rear structural housing

The rear housing starts behind the front/PCB layers and tapers toward the
14.50 mm rear mounting plane. The outer housing taper follows the 1.25 mm
reference inset recorded from the STEP geometry.

Four electronics bays are separated by three middle ribs. The bay edge uses
the recorded stepped profile: a normal 10.75 mm rail that narrows locally to
7.75 mm through 45-degree transitions.

<!-- scad-render
view: structure
vpr: [90, 0, 0]
-->

The rear recess is deliberately shallow and simple. It exists to represent the
mechanically relevant rail face rather than decorative texture.

## Mounting and locating geometry

The six Ø3 mm mounting holes use the drawing-derived positions stored in the
panel object. Each screw hole sits in an Ø8.50 mm cylindrical mounting tube.

The separate Ø14 mm reinforcement bushings are distinct features and are not
modelled concentrically with the mounting tubes. The two diagonal Ø3 mm
locating pins are also retained as separate PDF-dimensioned geometry.

The object exposes centred mounting coordinates and panel-grid margins for
mating parts such as couplers.

## Connectors and orientation

Two HUB75 IDC connectors and the power connector are retained as reference
geometry. The source notes that the power connector position is a visual
approximation because the dimensional drawing does not locate it.

<!-- scad-render
view: connectors
vpr: [90, 0, 0]
-->

Rear PCB arrows are orientation markers only. They help preserve the portrait
mapping used by the original project but are not dimensional geometry.

## Drawing verification

The model includes a red verification overlay based only on dimensions recorded
as explicit PDF/drawing geometry: physical envelope, mounting centre lines and
the two locating-pin centres.

<!-- scad-render
view: verification
vpr: [90, 0, 0]
-->

STEP-only rear-frame approximations are intentionally not encoded into this
drawing-verification overlay.

## Profile and mating plane

The rear mounting plane is at the physical panel depth. Mating components should
use the object-derived taper and rear rail dimensions rather than assuming the
front envelope continues vertically to the rear face.

<!-- scad-render
view: profile
vpr: [90, 0, 90]
-->

The reusable object API therefore separates:

```text
nominal placement dimensions
physical front/body dimensions
rear mounting-plane dimensions
```

That separation is central to reliable coupler and enclosure fit.
