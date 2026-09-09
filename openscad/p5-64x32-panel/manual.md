# HUB75 P5 64 × 32 panel — manual and reference

This page explains how to **use** the reusable panel model.

For the geometric construction itself, see
[design/design.md](design/design.md).

## Orientation

The library stores the panel in portrait orientation.

```text
X = left ↔ right across the short side
Y = front ↔ rear through the panel depth
Z = bottom ↔ top along the long side
```

The front face is the LED side. Most mechanical features and connectors are on
the rear.

## Physical size and nominal placement size

Two dimensions are intentionally kept separate.

```text
                         width       height
physical panel          159.70 mm   319.71 mm
nominal placement cell  160.00 mm   320.00 mm
difference                0.30 mm     0.29 mm
```

The **physical size** describes the real body.

The **nominal placement size** describes the grid cell used when panels are
arranged next to each other. It is slightly larger than the real body, so the
model does not assume that neighbouring physical panels exactly fill a
160 × 320 mm rectangle.

When centred in that nominal cell, the difference corresponds to approximately:

```text
horizontal: 0.15 mm per side
vertical:   0.145 mm per end
```

These are placement/reference values, not extra printable geometry.

## Basic OpenSCAD use

```scad
use <hub75_p5_64x32_panel.scad>

panel = hub75_p5_64x32_panel_create();

hub75_p5_64x32_panel_build(panel);
```

Mechanical data belongs to the panel object. Consumers should use the object
accessors rather than duplicating dimensions in project code.

Examples:

```scad
hub75_p5_64x32_panel_width(panel);
hub75_p5_64x32_panel_height(panel);
hub75_p5_64x32_panel_mounting_plane_y(panel);
hub75_p5_64x32_panel_grid_gap_x(panel);
hub75_p5_64x32_panel_grid_gap_z(panel);
```

For project-specific mating parts such as brackets and couplers, use the public
mechanical accessors rather than reading panel object fields directly:

```scad
hub75_p5_64x32_panel_rear_side_rail_width_at_mounting_plane(panel);
hub75_p5_64x32_panel_rear_crossbar_width_at_mounting_plane(panel);
hub75_p5_64x32_panel_rear_opening_corner_radius(panel);
hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
hub75_p5_64x32_panel_mounting_tube_protrusion(panel);
hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);
hub75_p5_64x32_panel_reinforcement_bushing_offset(panel);
```

## Interactive render/debug views

Open:

```text
hub75_p5_64x32_panel_render.scad
```

in OpenSCAD.

The Customizer contains a **Render view** selector. Every stable render/debug
view is listed there explicitly, so you can switch between views without
editing OpenSCAD code.

The design document only uses the subset of views that add explanatory value.
The Customizer deliberately contains more views for development and debugging.

Examples include:

```text
front
rear
rear-frame-core
mounting-centres
mounting-tube-single
reinforcement-solids
locator-pins
data-connectors
verification-mounting
final-profile
```

## View table

Internally the model keeps one ordered view table:

```scad
[
    [HUB75_P5_64X32_PANEL_VIEW_FINAL, "final"],
    [HUB75_P5_64X32_PANEL_VIEW_FRONT, "front"],
    [HUB75_P5_64X32_PANEL_VIEW_REAR,  "rear"],
    ...
]
```

The constant value intentionally matches the table index. When a view is
accessed, the model asserts that this relationship still holds. This makes an
accidental table reorder fail visibly instead of silently selecting the wrong
render.

## Geometry authority

The model records three source types:

- the supplied dimensional drawing for authoritative basic envelope and
  mounting dimensions;
- the supplied STEP model for taper and rear mechanical form where documented;
- a rear photograph only as a secondary visual/orientation reference.

An approximate or photo-derived feature should not be treated as if it were a
drawing-derived dimension.

## Experimental/debug views

Some views exist specifically to help diagnose the model. Examples are
placement-gap visualisations, internal construction planes and profile
experiments.

A debug view being available does **not** mean it belongs in the design
walkthrough. The design document is intentionally kept smaller and focused on
understanding the physical construction.
