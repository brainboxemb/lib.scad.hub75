// Focused render helpers for the first physical verification procedure.
// These helpers do not duplicate panel geometry: the real library panel is
// built through the public API, then cropped/annotated for explanation.

use <../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>
use <../fixtures/hub75_p5_64x32_physical_verification_fixtures.scad>

function hub75_vrf_top_left_x(panel) =
    hub75_p5_64x32_panel_hole_x_positions_centered(panel)[0];

function hub75_vrf_top_left_z(panel) =
    hub75_p5_64x32_panel_hole_z_positions_centered(panel)[2];

function hub75_vrf_top_left_reinforcement_z(panel) =
    hub75_vrf_top_left_z(panel)
    - hub75_p5_64x32_panel_reinforcement_bushing_offset(panel);

module _hub75_vrf_rear_ring(x, y, z, outer_d, inner_d, thickness=0.6) {
    translate([x, y, z])
        rotate([90, 0, 0])
            difference() {
                cylinder(h=thickness, d=outer_d, center=true, $fn=96);
                cylinder(h=thickness+0.2, d=inner_d, center=true, $fn=96);
            }
}

module _hub75_vrf_rear_rect_frame(x0, x1, z0, z1, y, line=1.2) {
    color([1.0, 0.18, 0.08]) {
        translate([x0, y, z0]) cube([x1-x0, line, line]);
        translate([x0, y, z1-line]) cube([x1-x0, line, line]);
        translate([x0, y, z0]) cube([line, line, z1-z0]);
        translate([x1-line, y, z0]) cube([line, line, z1-z0]);
    }
}

module hub75_vrf_top_left_location(panel, crop_width=44, crop_height=52) {
    width = hub75_p5_64x32_panel_width(panel);
    height = hub75_p5_64x32_panel_height(panel);
    depth = hub75_p5_64x32_panel_depth(panel);
    left = -width/2;
    top = height/2;

    hub75_p5_64x32_panel_build(panel);

    _hub75_vrf_rear_rect_frame(
        left,
        left + crop_width,
        top - crop_height,
        top,
        depth + 1.8
    );
}

module hub75_vrf_top_left_panel_crop(panel, crop_width=44, crop_height=52) {
    width = hub75_p5_64x32_panel_width(panel);
    height = hub75_p5_64x32_panel_height(panel);
    depth = hub75_p5_64x32_panel_depth(panel);
    protrusion = hub75_p5_64x32_panel_mounting_tube_protrusion(panel);
    left = -width/2;
    top = height/2;

    intersection() {
        hub75_p5_64x32_panel_build(panel);
        translate([left-1, -0.5, top-crop_height])
            cube([crop_width+2, depth+protrusion+2.5, crop_height+1]);
    }
}

module hub75_vrf_top_left_feature_map(panel, crop_width=44, crop_height=52) {
    width = hub75_p5_64x32_panel_width(panel);
    height = hub75_p5_64x32_panel_height(panel);
    depth = hub75_p5_64x32_panel_depth(panel);
    protrusion = hub75_p5_64x32_panel_mounting_tube_protrusion(panel);
    tube_d = hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
    reinforcement_d =
        hub75_p5_64x32_panel_reinforcement_bushing_outer_diameter(panel);
    x = hub75_vrf_top_left_x(panel);
    z_screw = hub75_vrf_top_left_z(panel);
    z_reinforcement = hub75_vrf_top_left_reinforcement_z(panel);
    left = -width/2;
    top = height/2;

    hub75_vrf_top_left_panel_crop(panel, crop_width, crop_height);

    // Yellow datum references: the physical top and left edges used by the
    // measurement procedure. They float behind the rear face so they do not
    // obscure the panel geometry.
    color([1.0, 0.78, 0.08]) {
        translate([left, depth+protrusion+1.0, top-0.55])
            cube([crop_width, 0.55, 1.1]);
        translate([left-0.55, depth+protrusion+1.0, top-crop_height])
            cube([1.1, 0.55, crop_height]);
    }

    // Red = mounting tube / screw-hole centre.
    color([0.95, 0.12, 0.08])
        _hub75_vrf_rear_ring(
            x,
            depth+protrusion+1.2,
            z_screw,
            tube_d+2.0,
            tube_d+0.5
        );

    // Blue = separate reinforcement feature 11 mm inward from the screw centre.
    color([0.10, 0.38, 1.0])
        _hub75_vrf_rear_ring(
            x,
            depth+protrusion+1.2,
            z_reinforcement,
            reinforcement_d+2.0,
            reinforcement_d+0.5
        );
}

// Place the print-flat profile comb in its real use orientation.
// Local comb axes: X=front->rear, Y=down from top, Z=print thickness.
// Global panel axes: X=width, Y=front->rear, Z=height.
module hub75_vrf_top_left_profile_comb_on_panel(panel) {
    top = hub75_p5_64x32_panel_height(panel)/2;
    screw_x = hub75_vrf_top_left_x(panel);
    tube_d = hub75_p5_64x32_panel_mounting_tube_outer_diameter(panel);
    comb_x = screw_x + tube_d/2 + 2.0;

    multmatrix([
        [0,  0, 1, comb_x],
        [1,  0, 0, 0],
        [0, -1, 0, top],
        [0,  0, 0, 1]
    ])
        hub75_vrf_top_left_profile_comb(panel);
}

module hub75_vrf_top_left_comb_use(panel, crop_width=44, crop_height=52) {
    hub75_vrf_top_left_panel_crop(panel, crop_width, crop_height);

    color([1.0, 0.48, 0.05])
        hub75_vrf_top_left_profile_comb_on_panel(panel);
}
