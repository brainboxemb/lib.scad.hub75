// File: hub75_p5_64x32_physical_verification_fixtures.scad
// Printable aids for physical verification of a real HUB75 P5 64 x 32 panel.
//
// These fixtures intentionally consume only the public panel API. They are fit
// and datum aids, not calibrated metrology instruments.

use <../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>

function hub75_vrf_default_panel() = hub75_p5_64x32_panel_create();

function hub75_vrf_mounting_spacing_x(panel) =
    let(xs = hub75_p5_64x32_panel_hole_x_positions(panel))
    xs[1] - xs[0];

function hub75_vrf_mounting_spacing_z(panel) =
    let(zs = hub75_p5_64x32_panel_hole_z_positions(panel))
    zs[1] - zs[0];

function hub75_vrf_top_left_profile_comb_version() = "v0.2";
function hub75_vrf_top_left_alignment_guide_version() = "v0.1";
function hub75_vrf_corner_radius_comparator_version() = "v0.1";

function hub75_vrf_top_left_hole_from_top(panel) =
    hub75_p5_64x32_panel_height(panel)
    - hub75_p5_64x32_panel_hole_z_positions(panel)[2];

function hub75_vrf_top_left_reinforcement_from_top(panel) =
    hub75_vrf_top_left_hole_from_top(panel)
    + hub75_p5_64x32_panel_reinforcement_bushing_offset(panel);

module _hub75_vrf_spacing_bar(
    spacing,
    reference_diameter,
    opening_clearance = 0.8,
    bar_width = 22,
    thickness = 3.2
) {
    opening_d = reference_diameter + opening_clearance;
    end_d = max(bar_width, opening_d + 5);
    x0 = -spacing / 2;
    x1 = spacing / 2;
    y0 = 0;

    difference() {
        hull() {
            translate([x0, y0, 0])
                cylinder(h=thickness, d=end_d, $fn=96);
            translate([x1, y0, 0])
                cylinder(h=thickness, d=end_d, $fn=96);
        }

        for(x=[x0, x1])
            translate([x, y0, -0.1])
                cylinder(h=thickness + 0.2, d=opening_d, $fn=96);
    }
}

// A rear-mounted corner datum gauge retained for later comparison work.
module hub75_vrf_corner_datum_gauge(
    panel,
    plate_size = 32,
    plate_thickness = 3.2,
    fence_thickness = 2.4,
    edge_clearance = 0.25,
    ring_clearance = 0.8
) {
    xs = hub75_p5_64x32_panel_hole_x_positions(panel);
    zs = hub75_p5_64x32_panel_hole_z_positions(panel);
    ring_d = hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);
    fence_height = hub75_p5_64x32_panel_depth(panel) + 1.5;
    outer_min = -edge_clearance - fence_thickness;
    span = plate_size - outer_min;
    center = (outer_min + plate_size) / 2;

    translate([-center, -center, 0])
        difference() {
            union() {
                translate([outer_min, outer_min, 0])
                    cube([span, span, plate_thickness]);
                translate([outer_min, outer_min, 0])
                    cube([fence_thickness, span, fence_height]);
                translate([outer_min, outer_min, 0])
                    cube([span, fence_thickness, fence_height]);
            }

            translate([xs[0], zs[0], -0.1])
                cylinder(
                    h=plate_thickness + 0.2,
                    d=ring_d + ring_clearance,
                    $fn=96
                );
        }
}

module hub75_vrf_mounting_spacing_x_gauge(
    panel,
    opening_clearance = 0.8,
    bar_width = 22,
    thickness = 3.2
) {
    spacing = hub75_vrf_mounting_spacing_x(panel);
    ring_d = hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);

    echo("hub75_vrf_mounting_spacing_x_mm", spacing);

    _hub75_vrf_spacing_bar(
        spacing=spacing,
        reference_diameter=ring_d,
        opening_clearance=opening_clearance,
        bar_width=bar_width,
        thickness=thickness
    );
}

module hub75_vrf_mounting_spacing_z_gauge(
    panel,
    opening_clearance = 0.8,
    bar_width = 22,
    thickness = 3.2
) {
    spacing = hub75_vrf_mounting_spacing_z(panel);
    ring_d = hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);

    echo("hub75_vrf_mounting_spacing_z_mm", spacing);

    _hub75_vrf_spacing_bar(
        spacing=spacing,
        reference_diameter=ring_d,
        opening_clearance=opening_clearance,
        bar_width=bar_width,
        thickness=thickness
    );
}

// TL1 profile-comb local coordinates:
//   X = real panel front -> rear depth
//   Y = distance downward from the physical top edge
//   Z = printed plate thickness / across-panel direction in use
module _hub75_vrf_top_left_profile_comb_2d(
    panel,
    rail_height = 4.0,
    blade_depth = 5.0,
    blade_height = 31.0,
    rear_clearance = 0.8,
    witness_width = 1.8
) {
    rear_start = hub75_rear_taper_start_y(panel);
    rear_plane = hub75_p5_64x32_panel_depth(panel);
    rear_inset = hub75_p5_64x32_panel_rear_outer_inset_z(panel);
    protrusion = hub75_p5_64x32_panel_mounting_tube_protrusion(panel);
    screw_from_top = hub75_vrf_top_left_hole_from_top(panel);
    reinforcement_from_top = hub75_vrf_top_left_reinforcement_from_top(panel);

    blade_x0 = rear_plane + protrusion + rear_clearance;
    blade_x1 = blade_x0 + blade_depth;
    arm_x0 = rear_plane + 0.05;

    difference() {
        union() {
            polygon([
                [0, -rail_height],
                [rear_start, -rail_height],
                [rear_plane, rear_inset-rail_height],
                [blade_x0, rear_inset-rail_height],
                [blade_x0, rear_inset],
                [rear_plane, rear_inset],
                [rear_start, 0],
                [0, 0]
            ]);

            translate([blade_x0, rear_inset-rail_height])
                square([
                    blade_depth,
                    blade_height + rail_height - rear_inset
                ]);

            translate([arm_x0, screw_from_top-witness_width/2])
                square([blade_x1-arm_x0, witness_width]);
            translate([arm_x0, reinforcement_from_top-witness_width/2])
                square([blade_x1-arm_x0, witness_width]);
        }

        translate([blade_x0 + blade_depth/2, screw_from_top])
            circle(d=1.5, $fn=32);
        translate([blade_x0 + blade_depth/2, reinforcement_from_top])
            circle(d=1.5, $fn=32);
    }
}

module hub75_vrf_top_left_profile_comb_base(panel, thickness = 2.0) {
    linear_extrude(height=thickness)
        _hub75_vrf_top_left_profile_comb_2d(panel);
}

// Raised markings are deliberately separate geometry. Exporting this module on
// its own produces an AMS-colour part that shares the exact origin with the
// base STL. Import base + markings as one multipart object in Bambu Studio.
module hub75_vrf_top_left_profile_comb_markings(
    panel,
    thickness = 2.0,
    version = hub75_vrf_top_left_profile_comb_version(),
    marking_height = 0.50
) {
    rear_plane = hub75_p5_64x32_panel_depth(panel);
    protrusion = hub75_p5_64x32_panel_mounting_tube_protrusion(panel);
    screw_from_top = hub75_vrf_top_left_hole_from_top(panel);
    reinforcement_from_top = hub75_vrf_top_left_reinforcement_from_top(panel);
    blade_x0 = rear_plane + protrusion + 0.8;
    blade_center_x = blade_x0 + 2.5;
    z0 = thickness - 0.02;
    h = marking_height + 0.02;

    translate([blade_center_x, 27.0, z0])
        linear_extrude(height=h)
            rotate(90)
                text(
                    str("TL1 ", version),
                    size=3.0,
                    halign="center",
                    valign="center"
                );

    for(mark = [
        [screw_from_top, "S"],
        [reinforcement_from_top, "R"]
    ])
        translate([blade_x0 + 0.85, mark[0] + 2.1, z0])
            linear_extrude(height=h)
                text(
                    mark[1],
                    size=2.4,
                    halign="center",
                    valign="center"
                );

    // Raised witness bar for the expected tube end, 0.5 mm behind the nominal
    // rear mounting plane.
    translate([
        rear_plane + protrusion - 0.18,
        screw_from_top - 0.8,
        z0
    ])
        cube([0.36, 1.6, h]);
}

module hub75_vrf_top_left_profile_comb(
    panel,
    thickness = 2.0,
    version = hub75_vrf_top_left_profile_comb_version(),
    marking_height = 0.50
) {
    union() {
        hub75_vrf_top_left_profile_comb_base(panel, thickness);
        hub75_vrf_top_left_profile_comb_markings(
            panel,
            thickness,
            version,
            marking_height
        );
    }
}

// SQ1 is an orientation helper rather than a dimensional gauge. It sits on the
// straight front-most 1.8 mm of the physical top edge and its slot holds the
// 2 mm TL1 plate normal to that edge. A generous slot clearance prevents SQ1
// printer fit from becoming a false panel measurement.
module hub75_vrf_top_left_alignment_guide_base(
    panel,
    comb_thickness = 2.0,
    slot_clearance = 0.30,
    width = 18.0,
    depth = 1.80,
    height = 5.0
) {
    slot = comb_thickness + slot_clearance;

    difference() {
        translate([0, -height, -width/2])
            cube([depth, height, width]);

        translate([-0.1, -height-0.1, -slot/2])
            cube([depth+0.2, height+0.2, slot]);
    }
}

module hub75_vrf_top_left_alignment_guide_markings(
    panel,
    width = 18.0,
    depth = 1.80,
    height = 5.0,
    version = hub75_vrf_top_left_alignment_guide_version(),
    marking_height = 0.50
) {
    // Mark the broad outside face; the text never touches the panel or TL1 slot.
    translate([depth-0.02, -height/2, 0])
        rotate([0, 90, 0])
            linear_extrude(height=marking_height+0.02)
                text(
                    str("SQ1 ", version),
                    size=2.8,
                    halign="center",
                    valign="center"
                );
}

module hub75_vrf_top_left_alignment_guide(panel) {
    union() {
        hub75_vrf_top_left_alignment_guide_base(panel);
        hub75_vrf_top_left_alignment_guide_markings(panel);
    }
}

// R1 compares the concave bay-opening corner against three nearby convex probe
// radii. The centre probe comes from the public API (~R4.99 mm); its neighbours
// intentionally bracket it by ±0.5 mm so a visual fit can distinguish the model
// value from a clearly larger/smaller radius.
module _hub75_vrf_radius_probe_2d(size, radius) {
    rr = min(radius, size/2 - 0.1);
    offset(r=rr)
        square([size-2*rr, size-2*rr], center=true);
}

module hub75_vrf_corner_radius_comparator_base(
    panel,
    thickness = 2.0,
    probe_size = 15.0,
    spacing = 20.0,
    handle_height = 8.0
) {
    target = hub75_p5_64x32_panel_rear_opening_corner_radius(panel);
    radii = [max(0.1, target-0.5), target, target+0.5];
    total_w = 2*spacing + probe_size;

    linear_extrude(height=thickness)
        union() {
            translate([-total_w/2, -handle_height])
                square([total_w, handle_height]);

            for(i=[0:2])
                translate([(i-1)*spacing, probe_size/2])
                    _hub75_vrf_radius_probe_2d(probe_size, radii[i]);
        }
}

module hub75_vrf_corner_radius_comparator_markings(
    panel,
    thickness = 2.0,
    probe_size = 15.0,
    spacing = 20.0,
    handle_height = 8.0,
    version = hub75_vrf_corner_radius_comparator_version(),
    marking_height = 0.50
) {
    z0 = thickness - 0.02;
    h = marking_height + 0.02;
    labels = ["R4.5", "R5.0", "R5.5"];

    for(i=[0:2])
        translate([(i-1)*spacing, -handle_height/2, z0])
            linear_extrude(height=h)
                text(
                    labels[i],
                    size=2.6,
                    halign="center",
                    valign="center"
                );

    translate([0, probe_size+1.8, z0])
        linear_extrude(height=h)
            text(
                str("R1 ", version),
                size=2.8,
                halign="center",
                valign="center"
            );
}

module hub75_vrf_corner_radius_comparator(panel) {
    union() {
        hub75_vrf_corner_radius_comparator_base(panel);
        hub75_vrf_corner_radius_comparator_markings(panel);
    }
}
