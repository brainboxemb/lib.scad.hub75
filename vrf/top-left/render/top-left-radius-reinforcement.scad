use <../../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>
use <../hub75_p5_64x32_top_left_verification.scad>

$fn = 96;
$vpr = [88, 0, 205];
$vpt = [63, 13, 142];
$vpd = 105;

panel = hub75_p5_64x32_panel_create();
hub75_vrf_top_left_radius_reinforcement_map(panel);
