from pathlib import Path

src = Path('openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad')
text = src.read_text()

speculative = '''    module _bay_end_relief_2d(z_edge, direction=1) {
        d = rear_frame_end_step_depth;
        half_narrow = rear_frame_end_narrow_length/2;
        cx = width/2;
        join_overlap = 0.05;

        // Build the production cutter as one polygon. The long edge overlaps
        // 0.05 mm into the already-removed rounded bay opening so the 3D
        // subtraction never depends on face-only unions between cutter parts.
        if(d > 0)
            polygon([
                [cx-half_narrow-d, z_edge - direction*join_overlap],
                [cx-half_narrow,   z_edge + direction*d],
                [cx+half_narrow,   z_edge + direction*d],
                [cx+half_narrow+d, z_edge - direction*join_overlap]
            ]);
    }
'''
original = '''    module _bay_end_relief_2d(z_edge, direction=1) {
        union() {
            _bay_end_transition_relief_2d(z_edge, direction, "left");
            _bay_end_narrow_relief_2d(z_edge, direction);
            _bay_end_transition_relief_2d(z_edge, direction, "right");
        }
    }
'''
if speculative not in text:
    raise SystemExit('Speculative relief block not found')
text = text.replace(speculative, original)

old_core = '''    module _rear_frame_core_3d() {
        difference() {
            // The full outside wall tapers continuously from the 2.0 mm
            // rear-housing start to the rear mounting plane. There is no
            // artificial short chamfer followed by a straight wall.
            _tapered_outer_blank(
                rear_frame_start_y,
                mounting_plane_y_value,
                0,
                rear_outer_inset_actual
            );

            // Keep the bay walls vertical, as in the STEP model.
            _rear_extrude_from_to(
                rear_frame_start_y - 0.05,
                mounting_plane_y_value + 0.05
            )
                _rear_openings_2d();
        }
    }
'''
new_core = '''    module _rear_frame_core_3d() {
        // Extrude the already-cut 2D frame web with vertical bay walls, then
        // clip only its outside perimeter with the tapered rear envelope.
        // This is geometrically equivalent to subtracting the four vertical
        // bay cutters, without the triangular Boolean remnants.
        intersection() {
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
                _rear_frame_web_2d();
        }
    }
'''
if old_core not in text:
    raise SystemExit('Rear frame core block not found')
src.write_text(text.replace(old_core, new_core))

design = Path('openscad/p5-64x32-panel/hub75_p5_64x32_panel/design/design.md')
text = design.read_text()

start = text.index('## 8. Combine the three end-relief pieces')
end = text.index('\n## 9. Complete one bay cutter', start)
step8 = '''## 8. Combine the three end-relief pieces

The two triangular transitions and the central rectangle are united into one
end-relief cutter:

```scad
module _bay_end_relief_2d(z_edge, direction=1) {
    union() {
        _bay_end_transition_relief_2d(z_edge, direction, "left");
        _bay_end_narrow_relief_2d(z_edge, direction);
        _bay_end_transition_relief_2d(z_edge, direction, "right");
    }
}
```

The same operation is applied at the bottom and top edge of the bay, with the
direction reversed.

**View:** `bay-bottom-relief`

<!-- scad-render
view: bay-bottom-relief
vpr: [68, 0, 212]
vpt: [0, 10, -149]
vpd: 120
size: [800, 580]
-->
'''
text = text[:start] + step8 + text[end:]

start = text.index('## 11. Subtract the four openings from the tapered blank')
end = text.index('\n---\n\n# Reinforcement base geometry', start)
step11 = '''## 11. Form the 3D rear frame from the cut web

The four openings already define a clean 2D frame web. That web is extruded
with vertical bay walls and then intersected with the tapered outer envelope:

```scad
module _rear_frame_core_3d() {
    intersection() {
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
            _rear_frame_web_2d();
    }
}
```

This gives the same intended physical result as subtracting four vertical bay
cutters: the **outside perimeter tapers**, while the **bay walls remain
vertical**. Constructing the clean 2D web first avoids triangular Boolean
remnants at the stepped bay reliefs.

**View:** `rear-frame-core`

<!-- scad-render
view: rear-frame-core
vpr: [90, 0, 0]
-->

At this point the main rear frame exists: two side rails, top/bottom rails and
three crossbars.

The generated image is also a geometry check: each crossbar must show the same
clean stepped relief on both adjacent bay edges. Triangular remnants or a local
slit on only one side mean the frame construction is not valid.
'''
text = text[:start] + step11 + text[end:]
design.write_text(text)

changelog = Path('CHANGELOG.md')
text = changelog.read_text().replace(
    '- Make the rear bay-end opening cutters topologically robust so the 3D subtraction no longer leaves triangular remnants in the horizontal crossbars.',
    '- Build the rear frame from the clean 2D web clipped by the tapered outer envelope, eliminating triangular Boolean remnants in the horizontal crossbars.'
)
changelog.write_text(text)
