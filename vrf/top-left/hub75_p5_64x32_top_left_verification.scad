// Focused render helpers for the first physical verification procedure.
// These helpers do not duplicate panel geometry: the complete production panel
// is built through the public API and the render adapters frame the area with an
// explicit camera.

use <../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>
use <../fixtures/hub75_p5_64x32_physical_verification_fixtures.scad>

function hub75_vrf_top_left_x(panel) =
    hub75_p5_64x32_panel_hole_x_positions_centered(panel)[0];

function hub75_vrf_top_left_z(panel) =
    hub75_p5_64x32_panel_hole_z_positions_centered(panel)[2];

function hub75_vrf_top_left_reinforcement_z(panel) =
    hub75_vrf_top_left_z(panel)
    - hub75_p5_64x32_panel_reinforcement_bushing_offset(panel);

function hub75_vrf_overlay_y(panel) =
    hub75_p5_64x32_panel_depth(panel) + 4.5;

module _hub75_vrf_rear_ring(x, y, z, outer_d, inner_d, thickness=0.7) {
    translate([x, y, z])
        rotate([90, 0, 0])
            difference() {
                cylinder(h=thickness, d=outer_d, center=true, $fn=96);
                cylinder(h=thickness+0.2, d=inner_d, center=true, $fn=96);
            }
}

module _hub75_vrf_rear_rect_frame(x0, x1, z0, z1, y, line=1.2) {
    color([1.0, 0.18, 0.08]) {
        translate([x0, y, z0]) cube([x1-x0, 0.7, line]);
        translate([x0, y, z1-line]) cube([x1-x0, 0.7, line]);
        translate([x0, y, z0]) cube([line, 0.7, z1-z0]);
        translate([x1-line, y, z0]) cube([line, 0.7, z1-z0]);
    }
}

module hub75_vrf_top_left_location(panel, area_width=46, area_height=56) {
    width = hub75_p5_64x32_panel_width(panel);
    height = hub75_p5_64x32_panel_height(panel);
    left = -width/2;
    top = height/2;

    hub75_p5_64x32_panel_build(panel);

    _hub75_vrf_rear_rect_frame(
        left,
        left + area_width,
        top - area_height,
        top,
        hub75_vrf_overlay_y(panel)
    );
}

module hub75_vrf_top_left_feature_map(panel, datum_length=38) {
    width = hub75_p5_64x32_panel_width(panel);
    height = hub75_p5_64x32_panel_height(panel);
    tube_d = hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
    reinforcement_d =
        hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);
    x = hub75_vrf_top_left_x(panel);
    z_screw = hub75_vrf_top_left_z(panel);
    z_reinforcement = hub75_vrf_top_left_reinforcement_z(panel);
    left = -width/2;
    top = height/2;
    oy = hub75_vrf_overlay_y(panel);

    hub75_p5_64x32_panel_build(panel);

    // Yellow datum references: short segments along the physical top and left
    // edges. They float behind the rear-most panel details so the real rail and
    // mounting geometry stay visible underneath.
    color([1.0, 0.78, 0.08]) {
        translate([left, oy, top-0.5])
            cube([datum_length, 0.7, 1.0]);
        translate([left-0.5, oy, top-datum_length])
            cube([1.0, 0.7, datum_length]);
    }

    // Red = mounting tube / screw-hole centre.
    color([0.95, 0.12, 0.08])
        _hub75_vrf_rear_ring(
            x,
            oy+0.5,
            z_screw,
            tube_d+2.4,
            tube_d+0.8
        );

    // Blue = separate reinforcement feature 11 mm inward from the screw centre.
    color([0.10, 0.38, 1.0])
        _hub75_vrf_rear_ring(
            x,
            oy+0.5,
            z_reinforcement,
            reinforcement_d+2.4,
            reinforcement_d+0.8
        );
}

// Place the print-flat profile comb in its real use orientation.
// Local comb axes: X=front->rear, Y=down from top, Z=print thickness.
// Global panel axes: X=width, Y=front->rear, Z=height.
module hub75_vrf_top_left_profile_comb_on_panel(panel) {
    top = hub75_p5_64x32_panel_height(panel)/2;
    screw_x = hub75_vrf_top_left_x(panel);
    tube_d = hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);

    // Place the 2 mm plate beside the tube so the top profile can sit on the
    // panel without colliding with the physical tube itself.
    comb_x = screw_x + tube_d/2 + 2.4;

    multmatrix([
        [0,  0, 1, comb_x],
        [1,  0, 0, 0],
        [0, -1, 0, top],
        [0,  0, 0, 1]
    ])
        hub75_vrf_top_left_profile_comb(panel);
}

module hub75_vrf_top_left_comb_use(panel) {
    hub75_p5_64x32_panel_build(panel);

    color([1.0, 0.48, 0.05])
        hub75_vrf_top_left_profile_comb_on_panel(panel);
}
