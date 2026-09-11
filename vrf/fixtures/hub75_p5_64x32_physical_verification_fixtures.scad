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

module _hub75_vrf_spacing_bar(
    spacing,
    reference_diameter,
    opening_clearance = 0.8,
    bar_width = 22,
    thickness = 3.2
) {
    opening_d = reference_diameter + opening_clearance;
    end_d = max(bar_width, opening_d + 5);
    x0 = end_d / 2;
    x1 = x0 + spacing;
    y0 = end_d / 2;

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
// The opening intentionally does not try to gauge the 8.5 mm mounting tube at
// the same time. Centre position and local diameter fit are separate questions.
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
