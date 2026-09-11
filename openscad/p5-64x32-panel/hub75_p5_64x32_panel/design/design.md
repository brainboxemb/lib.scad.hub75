# HUB75 P5 64 × 32 panel — design

<!-- scad-render-defaults
engine: openscad
source: hub75_p5_64x32_panel_render.scad
module: hub75_p5_64x32_panel_design
vpr: [68, 0, 32]
-->

## Purpose

This document explains **how the model is actually constructed**.

The intended reader does not need to know OpenSCAD in advance. Every meaningful
construction operation is therefore presented in the same order as the model:

```text
existing physical geometry
        ↓
one addition or subtraction
        ↓
image of that operation
        ↓
the production code that performs it
```

This follows the same principle as the tube-clamp design documentation: do not
jump from “rough idea” to “finished result”. Show the intermediate operations
that explain where the shape comes from.

For construction images:

```text
gray = geometry that already exists before the step
red  = geometry being added, or the cutter being subtracted
```

A completed state returns to neutral gray.

## First orient yourself

The library stores the panel in portrait orientation.

### Front

**View:** `front`

<!-- scad-render
view: front
vpr: [85, 0, 40]
-->

The front is the flat LED side.

### Rear

**View:** `rear`

<!-- scad-render
view: rear
vpr: [85, 0, 220]
-->

Keep this overview in mind while following the individual construction steps
below.

## Complete construction order

The rear model is built in this order:

```text
front mask
    ↓
PCB layer
    ↓
tapered rear blank
    ↓
construct one bay opening shape
    ↓
repeat that opening four times
    ↓
subtract all four openings
    ↓
add the six reinforcement solids
    ↓
subtract the shallow rear recess
    ↓
subtract mounting-tube reliefs
    ↓
add six mounting tubes
    ↓
cut reinforcement recesses
    ↓
cut reinforcement blind holes
    ↓
add locator pins
    ↓
add connector reference geometry
    ↓
complete panel
```

The sections below follow this order.

---

## 1. Front mask

The first physical layer is the flat front body.

```scad
module _front_mask_shape() {
    translate([0, 0, 0])
        cube([
            width,
            front_mask_depth_value,
            height
        ]);
}
```

**View:** `front-mask`

<!-- scad-render
view: front-mask
vpr: [68, 0, 32]
-->

Nothing mechanical has been added at the rear yet.

## 2. PCB layer

The PCB is placed directly behind the front mask.

```scad
module _pcb_layer_shape() {
    translate([0, front_mask_depth_value, 0])
        cube([
            width,
            pcb_thickness_value,
            height
        ]);
}
```

**View:** `front-stack`

<!-- scad-render
view: front-stack
vpr: [68, 0, 212]
-->

In this image the existing front mask is gray and the PCB layer being added is
red.

---

# Rear housing

## 3. Start with the complete tapered rear blank

Before any electronics bays are cut, the rear housing is one solid tapered
volume.

The front edge of this rear housing uses the full panel footprint. At the rear
mounting plane the outside perimeter is inset by 1.25 mm per side.

```scad
_tapered_outer_blank(
    rear_frame_start_y,
    mounting_plane_y_value,
    0,
    rear_outer_inset_actual
);
```

Internally that helper creates one polyhedron from the front and rear
rectangular footprints.

**View:** `taper-body`

<!-- scad-render
view: taper-body
vpr: [68, 0, 212]
-->

The important point is that the taper belongs to the **outside wall only**.
The bay walls are created separately by subtraction.

---

# Constructing one electronics-bay opening

The four large holes are not simple rectangles. Each bay cutter is built from a
rounded main rectangle plus local stepped reliefs at its top and bottom edges.

The code for one complete opening is:

```scad
module _rear_opening_2d(i, include_reliefs=true) {
    z0 = opening_z_min[i];
    z1 = opening_z_max[i];
    opening_h = z1 - z0;

    union() {
        _rounded_rect_2d(
            rear_frame_side_width,
            z0,
            width - 2 * rear_frame_side_width,
            opening_h,
            rear_opening_corner_radius
        );

        if(include_reliefs) {
            _bay_end_relief_2d(z0, -1);
            _bay_end_relief_2d(z1,  1);
        }
    }
}
```

The next four steps explain what is inside that union.

## 4. Main rounded bay opening

The basic opening is a rounded rectangle spanning between the two long side
rails.

The call from the bay constructor is:

```scad
_rounded_rect_2d(
    rear_frame_side_width,
    z0,
    width - 2 * rear_frame_side_width,
    opening_h,
    rear_opening_corner_radius
);
```

The rounded rectangle itself is not a magic primitive. It is made by shrinking
a normal square by the corner radius and then expanding it again with
`offset(r=rr)`:

```scad
module _rounded_rect_2d(x, z, w, h, r) {
    rr = min(r, min(w, h) / 2 - 0.01);

    translate([x + rr, z + rr])
        offset(r = rr)
            square([
                max(0.02, w - 2 * rr),
                max(0.02, h - 2 * rr)
            ]);
}
```

So this step is literally:

```text
smaller sharp rectangle
        ↓ offset outward by corner radius
rounded bay-opening rectangle
```

**View:** `bay-rounded-corner`

<!-- scad-render
view: bay-rounded-corner
vpr: [68, 0, 212]
vpt: [-67, 10, -149]
vpd: 58
size: [760, 560]
-->

At this stage there is no stepped/narrow section yet.

## 5. Central narrow relief

At each end of a bay, the rail becomes locally narrower in the centre. The
central part of that relief is a rectangle.

```scad
module _bay_end_narrow_relief_2d(z_edge, direction=1) {
    d = rear_frame_end_step_depth;
    half_narrow = rear_frame_end_narrow_length / 2;
    cx = width / 2;

    polygon([
        [cx-half_narrow, z_edge],
        [cx-half_narrow, z_edge + direction*d],
        [cx+half_narrow, z_edge + direction*d],
        [cx+half_narrow, z_edge]
    ]);
}
```

**View:** `narrow-end-width`

<!-- scad-render
view: narrow-end-width
vpr: [68, 0, 212]
vpt: [0, 10, -149]
vpd: 105
size: [760, 560]
-->

This is not an extra solid. It is part of the **opening cutter**, so this red
area will eventually be removed from the rear housing.

## 6. Left transition into the narrow relief

The narrow central cut does not start with a square shoulder. A triangular
transition connects it to the normal-width bay edge.

```scad
polygon([
    [cx-half_narrow-d, z_edge],
    [cx-half_narrow,   z_edge + direction*d],
    [cx-half_narrow,   z_edge]
]);
```

**View:** `narrow-transition-left`

<!-- scad-render
view: narrow-transition-left
vpr: [68, 0, 212]
vpt: [-17, 10, -149]
vpd: 78
size: [760, 560]
-->

## 7. Right transition into the narrow relief

The other side is mirrored:

```scad
polygon([
    [cx+half_narrow,   z_edge],
    [cx+half_narrow,   z_edge + direction*d],
    [cx+half_narrow+d, z_edge]
]);
```

**View:** `narrow-transition-right`

<!-- scad-render
view: narrow-transition-right
vpr: [68, 0, 212]
vpt: [17, 10, -149]
vpd: 78
size: [760, 560]
-->

## 8. Combine the three end-relief pieces

The two triangular transitions and the central rectangle describe one
continuous trapezoidal end-relief cutter. For the production Boolean that same
outline is emitted as one polygon, with a 0.05 mm overlap into the already
removed rounded opening:

```scad
join_overlap = 0.05;

polygon([
    [cx-half_narrow-d, z_edge - direction*join_overlap],
    [cx-half_narrow,   z_edge + direction*d],
    [cx+half_narrow,   z_edge + direction*d],
    [cx+half_narrow+d, z_edge - direction*join_overlap]
]);
```

The overlap lies wholly inside the main bay opening, so it does not change the
intended rail dimensions. It only avoids a face-only union when the 2D cutter is
extruded and subtracted. The same operation is applied at the bottom and top
edge of the bay, with the direction reversed.

**View:** `bay-bottom-relief`

<!-- scad-render
view: bay-bottom-relief
vpr: [68, 0, 212]
vpt: [0, 10, -149]
vpd: 120
size: [800, 580]
-->

## 9. Complete one bay cutter

The rounded rectangle and both end reliefs now form one complete bay-opening
shape.

```scad
union() {
    _rounded_rect_2d(...);
    _bay_end_relief_2d(z0, -1);
    _bay_end_relief_2d(z1,  1);
}
```

**View:** `bay-1`

<!-- scad-render
view: bay-1
vpr: [68, 0, 212]
vpt: [0, 10, -120]
vpd: 190
size: [900, 650]
-->

This complete red shape is the material that will be removed for one
electronics bay.

## 10. Repeat the bay cutter four times

All four openings are generated from the same construction:

```scad
module _rear_openings_2d() {
    for(i=[0:3])
        _rear_opening_2d(i);
}
```

**View:** `rear-openings`

<!-- scad-render
view: rear-openings
vpr: [90, 0, 180]
-->

This explains where the three crossbars come from: they are simply the material
left **between** adjacent bay cutters.

## 11. Subtract the four openings from the tapered blank

Now the four complete 2D cutters are extruded through the rear housing and
subtracted.

```scad
module _rear_frame_core_3d() {
    difference() {
        _tapered_outer_blank(
            rear_frame_start_y,
            mounting_plane_y_value,
            0,
            rear_outer_inset_actual
        );

        _rear_extrude_from_to(
            rear_frame_start_y - 0.05,
            mounting_plane_y_value + 0.05
        )
            _rear_openings_2d();
    }
}
```

**View:** `rear-frame-core`

<!-- scad-render
view: rear-frame-core
vpr: [90, 0, 0]
-->

At this point the main rear frame exists: two side rails, top/bottom rails and
three crossbars.

The generated image is also a geometry check: each crossbar must show the same
clean stepped relief on both adjacent bay edges. Triangular remnants or a local
slit on only one side mean the opening subtraction is not valid.

---

# Reinforcement base geometry

## 12. Add the six Ø14 reinforcement solids

Six cylindrical reinforcement volumes are added beside the mounting positions.

They are circular toward the bay/interior side, but they must **not** bulge
through the outside wall. Therefore the cylinders are clipped by the same
tapered outer envelope used for the housing:

```scad
module _reinforcement_bushing_solids() {
    intersection() {
        union()
            for(pos=reinforcement_bushing_positions)
                translate([
                    pos[0],
                    mounting_plane_y_value
                        - reinforcement_bushing_inner_depth,
                    pos[1]
                ])
                    rotate([-90, 0, 0])
                        cylinder(
                            h = reinforcement_bushing_inner_depth,
                            d = reinforcement_bushing_outer_diameter_value
                        );

        _tapered_outer_blank(
            rear_frame_start_y,
            mounting_plane_y_value,
            0,
            rear_outer_inset_actual
        );
    }
}
```

**View:** `reinforcement-solids`

<!-- scad-render
view: reinforcement-solids
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->

The inner reinforcement stays round. The outside surface follows the smooth
panel wall.

The base rear structure is therefore:

```scad
module _rear_frame_base() {
    union() {
        _rear_frame_core_3d();
        _reinforcement_bushing_solids();
    }
}
```

---

# Rear-face recess

## 13. Construct the shallow recess cutter

The rear-face recess is itself assembled from several strips.

For the **top and bottom rails**, the recess must follow the real stepped rail
profile. A simple rectangular recess would cut through the outside rim when the
rail narrows in the centre.

The production code therefore intersects the actual frame profile with the
top/bottom rail band and then offsets that shape inward:

```scad
offset(delta = -end_margin)
    intersection() {
        _rear_frame_web_2d(outer_inset);

        translate([...])
            square([
                end_band_w,
                end_band_h
            ]);
    }
```

That leaves a continuous border on both sides of the recess:

```text
outer panel edge  → continuous rim
recessed surface  → follows the stepped contour
inner bay edge    → continuous rim
```

The complete rear-face recess is then assembled from several strips:

```scad
module _rear_recess_raw_2d() {
    union() {
        _rear_side_recess_2d("left");
        _rear_side_recess_2d("right");

        _rear_end_recess_2d("bottom");
        _rear_end_recess_2d("top");

        for(i=[0:2])
            _rear_crossbar_recess_2d(i);
    }
}
```

**View:** `recess-bottom`

<!-- scad-render
view: recess-bottom
vpr: [68, 0, 212]
vpt: [0, 10, -149]
vpd: 125
size: [800, 580]
-->

The red area is the actual bottom-rail recess cutter. The gray border should
remain visible continuously along both the outside and stepped inside edge.

The six reinforcement footprints are then excluded from that cutter:

```scad
module _rear_recess_2d() {
    difference() {
        _rear_recess_raw_2d();
        _reinforcement_bushing_footprints_2d();
    }
}
```

**View:** `rear-recess-3d`

<!-- scad-render
view: rear-recess-3d
vpr: [68, 0, 212]
-->

The red geometry is the shallow material to remove.

## 14. Subtract the rear-face recess

The cutter is extruded only through the shallow recess depth:

```scad
module _rear_frame_after_recess() {
    difference() {
        _rear_frame_base();

        _rear_extrude_from_to(
            mounting_plane_y_value - rear_recess_depth_actual,
            mounting_plane_y_value + 0.05
        )
            _rear_recess_2d();
    }
}
```

**View:** `rear-after-recess`

<!-- scad-render
view: rear-after-recess
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 130
-->

The circular reinforcement lands remain unrecessed.

---

# Mounting tubes

## 15. Remove local relief around each mounting tube

Before the tubes are added, a small circular relief is cut into the rail around
each mounting position.

```scad
module _mounting_tube_relief_cutters() {
    _rear_extrude_from_to(
        mounting_plane_y_value - mounting_tube_relief_depth_value,
        mounting_plane_y_value + 0.05
    )
        for(x=hole_x_positions)
            for(z=hole_z_positions)
                translate([x, z])
                    circle(
                        d = mounting_tube_outer_diameter_value
                            + 2 * mounting_tube_relief_clearance_value
                    );
}
```

**View:** `mounting-relief-single`

<!-- scad-render
view: mounting-relief-single
vpr: [68, 0, 212]
vpt: [-72.0, 10, -152.0]
vpd: 90
-->

Production state:

```scad
difference() {
    _rear_frame_after_recess();
    _mounting_tube_relief_cutters();
}
```

## 16. Add one Ø8.50 mounting tube

A tube is then added at the relieved position.

**View:** `mounting-tube-single`

<!-- scad-render
view: mounting-tube-single
vpr: [68, 0, 212]
vpt: [-72.0, 10, -152.0]
vpd: 90
-->

The tube itself is produced as an outer cylinder minus the Ø3 screw path:

```scad
module _mounting_tube(x, z) {
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

## 17. Repeat the tube at all six positions

Two X positions × three Z positions gives six tubes:

```scad
for(x=hole_x_positions)
    for(z=hole_z_positions)
        _mounting_tube(x, z);
```

**View:** `mounting-tubes`

<!-- scad-render
view: mounting-tubes
vpr: [68, 0, 212]
-->

The production state is:

```scad
module _rear_frame_with_mounting_tubes() {
    union() {
        _rear_frame_after_mounting_reliefs();

        for(x=hole_x_positions)
            for(z=hole_z_positions)
                _mounting_tube(x, z);
    }
}
```

---

# Reinforcement cuts

## 18. Cut the Ø10 reinforcement recess

The shallow Ø10 recess is cut into each Ø14 reinforcement area.

```scad
module _reinforcement_bushing_inner_recess_cuts() {
    for(pos=reinforcement_bushing_positions)
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

**View:** `reinforcement-inner-recess`

<!-- scad-render
view: reinforcement-inner-recess
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->

## 19. Cut the deeper Ø2.5 blind hole

The second cutter starts below the Ø10 recess floor and continues deeper into
the reinforcement.

```scad
module _reinforcement_bushing_blind_hole_cuts() {
    for(pos=reinforcement_bushing_positions)
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

**View:** `reinforcement-blind-hole`

<!-- scad-render
view: reinforcement-blind-hole
vpr: [68, 0, 212]
vpt: [-72.0, 10, -141.0]
vpd: 100
-->

Both cuts are combined in the production geometry:

```scad
module _rear_frame_after_reinforcement_cuts() {
    difference() {
        _rear_frame_with_mounting_tubes();
        _reinforcement_bushing_cuts();
    }
}
```

---

# Locator pins

## 20. Add the locator pins

Each locator is a Ø3 cylinder standing 3 mm proud of the rear mounting plane.

```scad
module _locator_pin(x, z) {
    translate([x, mounting_plane_y_value, z])
        rotate([-90, 0, 0])
            cylinder(
                h = locator_pin_protrusion_value,
                d = locator_pin_diameter_value
            );
}
```

**View:** `locator-upper-left`

<!-- scad-render
view: locator-upper-left
vpr: [68, 0, 212]
vpt: [-75, 10, 110]
vpd: 95
-->

Both pins are added after all reinforcement cuts:

```scad
module _rear_frame_structure() {
    _rear_frame_after_reinforcement_cuts();

    for(pos=locator_pin_positions)
        _locator_pin(pos[0], pos[1]);
}
```

---

# Connector reference geometry

## 21. Add the HUB75 connector clearance boxes

The data connectors are represented as simple clearance boxes because the
mechanical occupied volume matters more here than cosmetic connector detail.

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

**View:** `data-connector-bottom`

<!-- scad-render
view: data-connector-bottom
vpr: [68, 0, 212]
vpt: [0, 10, -113.5]
vpd: 135
-->

Both positions use the same helper.

**View:** `data-connectors`

<!-- scad-render
view: data-connectors
vpr: [68, 0, 212]
-->

## 22. Add the power-connector clearance box

The power connector uses the same clearance-volume principle. Its position is
approximate because the supplied drawing does not locate it authoritatively.

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

---

# 23. Complete rear structure

At this point the model has passed through the same physical sequence as the
production code:

```text
tapered blank
− four composed bay cutters
+ clipped reinforcement solids
− rear-face recess
− six tube reliefs
+ six mounting tubes
− reinforcement recesses/blind holes
+ locator pins
+ connector reference volumes
```

Return to the rear overview at the start of this document and compare it with
the individual construction steps above.

## Debug and reference views

The OpenSCAD renderer still exposes additional views for diagnosing dimensions,
placement, verification overlays and internal construction planes.

Those views remain useful in the Customizer, but the design walkthrough is
reserved for views that correspond to a meaningful construction operation.

Usage, nominal placement dimensions, coordinate conventions and the interactive
render-view selector are documented in:

```text
openscad/p5-64x32-panel/manual.md
```
