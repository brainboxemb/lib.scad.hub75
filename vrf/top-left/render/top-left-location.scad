use <../../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>
use <../hub75_p5_64x32_top_left_verification.scad>

$fn = 96;
$vpr = [85, 0, 205];
$vpt = [0, 8, 0];
$vpd = 720;

panel = hub75_p5_64x32_panel_create();
hub75_vrf_top_left_location(panel);
