use <../../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>
use <../hub75_p5_64x32_top_left_verification.scad>
use <../../fixtures/hub75_p5_64x32_outer_corner_radius_comparator.scad>

$fn = 96;
$vpr = [88, 0, 205];
$vpt = [68, 16, 149];
$vpd = 145;

panel = hub75_p5_64x32_panel_create();

width = hub75_p5_64x32_panel_width(panel);
height = hub75_p5_64x32_panel_height(panel);
inset_x = hub75_p5_64x32_panel_rear_outer_inset_x(panel);
inset_z = hub75_p5_64x32_panel_rear_outer_inset_z(panel);
rear_y = hub75_p5_64x32_panel_depth(panel) + 0.7;
corner_x = width/2 - inset_x;
corner_z = height/2 - inset_z;

// Use the R1.0 notch only to demonstrate orientation. The render does not imply
// that R1.0 is the physically correct panel radius.
probe_index = 1;
notch = hub75_vrf_outer_corner_radius_probe_notch_corner(probe_index);

module place_r2_at_outer_corner() {
    multmatrix([
        [-1,  0,  0, corner_x + notch[0]],
        [ 0,  0,  1, rear_y],
        [ 0, -1,  0, corner_z + notch[1]],
        [ 0,  0,  0, 1]
    ])
        children();
}

hub75_vrf_plan_panel(panel);

place_r2_at_outer_corner()
    color([1.0, 0.48, 0.05])
        hub75_vrf_outer_corner_radius_comparator_base();

place_r2_at_outer_corner()
    color([0.10, 0.10, 0.10])
        hub75_vrf_outer_corner_radius_comparator_markings();
