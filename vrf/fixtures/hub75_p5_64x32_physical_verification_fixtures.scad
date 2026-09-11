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

function hub75_vrf_top_left_profile_comb_version() = "v0.1";

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

// A rear-mounted corner datum gauge. The two fences wrap around the physical
// outer corner; the clearance opening is centred on the bottom-left mounting
// datum and clears the reinforcement ring around that mounting position.
//
// This older helper is retained for later comparison work. The first operator
// procedure now starts with the top-left profile comb below because that helper
// has an explicit placement/use procedure and checks one local area at a time.
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

    // Keep the physical datum construction in edge-based local coordinates,
    // then centre only the completed fixture for stable preview framing.
    translate([-center, -center, 0])
        difference() {
            union() {
                // Rear reference plate.
                translate([outer_min, outer_min, 0])
                    cube([span, span, plate_thickness]);

                // Side and end fences. Their inside faces sit edge_clearance outside
                // the nominal physical X/Z panel edges.
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

// Horizontal mounting-column spacing fixture. The openings clear the Ø14-ish
// reinforcement rings so the fixture primarily tests centre spacing.
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

// Adjacent-row vertical spacing fixture. It can be used on bottom-middle and
// middle-top, avoiding one very long 304 mm print.
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

// First physical-verification helper: a thin profile comb for the upper-left
// corner when the panel is viewed from the rear.
//
// Local 2D coordinates are deliberately human-readable:
//   X = front -> rear depth of the real panel
//   Y = distance downward from the physical top edge
//
// The comb is printed flat at 2 mm thickness. In use it stands perpendicular to
// the rear face, with the long lower edge of the top rail resting on the actual
// top edge/profile. The rear witness blade hangs behind the panel next to the
// upper-left mounting column.
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
            // The lower edge follows the expected physical top profile:
            // straight through the front/PCB stack, then the continuous rear
            // taper to the mounting plane.
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

            // Rear witness blade. It sits behind the panel, not over the rear
            // rail, so the operator can compare the real centres next to it.
            translate([blade_x0, rear_inset-rail_height])
                square([
                    blade_depth,
                    blade_height + rail_height - rear_inset
                ]);

            // Witness arms at the modelled screw and reinforcement centre
            // heights. Their front edge is the nominal rear mounting plane.
            translate([arm_x0, screw_from_top-witness_width/2])
                square([blade_x1-arm_x0, witness_width]);
            translate([arm_x0, reinforcement_from_top-witness_width/2])
                square([blade_x1-arm_x0, witness_width]);
        }

        // Round witness holes give an exact visual centre reference without
        // turning printer hole-size error into a false panel-diameter result.
        translate([blade_x0 + blade_depth/2, screw_from_top])
            circle(d=1.5, $fn=32);
        translate([blade_x0 + blade_depth/2, reinforcement_from_top])
            circle(d=1.5, $fn=32);
    }
}

module hub75_vrf_top_left_profile_comb(
    panel,
    thickness = 2.0,
    version = hub75_vrf_top_left_profile_comb_version(),
    engraving_depth = 0.35
) {
    rear_plane = hub75_p5_64x32_panel_depth(panel);
    protrusion = hub75_p5_64x32_panel_mounting_tube_protrusion(panel);
    screw_from_top = hub75_vrf_top_left_hole_from_top(panel);
    reinforcement_from_top = hub75_vrf_top_left_reinforcement_from_top(panel);
    blade_x0 = rear_plane + protrusion + 0.8;
    blade_center_x = blade_x0 + 2.5;
    marker_depth = engraving_depth + 0.05;

    difference() {
        linear_extrude(height=thickness)
            _hub75_vrf_top_left_profile_comb_2d(panel);

        // Engrave, rather than add, the fixture identity so the exported STL
        // remains one connected printable solid.
        translate([blade_center_x, 27, thickness-engraving_depth])
            linear_extrude(height=marker_depth)
                rotate(90)
                    text(
                        str("TL1 ", version),
                        size=2.2,
                        halign="center",
                        valign="center"
                    );

        // Shallow face engraving for the two witness levels.
        for(mark = [
            [screw_from_top, "S"],
            [reinforcement_from_top, "R"]
        ])
            translate([
                blade_x0 + 0.9,
                mark[0] + 2.0,
                thickness-engraving_depth
            ])
                linear_extrude(height=marker_depth)
                    text(
                        mark[1],
                        size=1.7,
                        halign="center",
                        valign="center"
                    );

        // The front edge of the upper witness arm is the rear mounting plane.
        // A shallow engraved line 0.5 mm farther rearward marks the expected
        // end of the mounting tube without cutting the arm into two pieces.
        translate([
            rear_plane + protrusion - 0.12,
            screw_from_top - 0.7,
            thickness-engraving_depth
        ])
            cube([0.24, 1.4, marker_depth]);
    }
}
