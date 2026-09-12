use <../../../openscad/p5-64x32-panel/hub75_p5_64x32_panel.scad>
use <../hub75_p5_64x32_top_left_verification.scad>

$fn = 96;
$vpr = [66, 0, 212];
$vpt = [64, 7, 151];
$vpd = 135;

panel = hub75_p5_64x32_panel_create();
hub75_vrf_top_left_comb_square_use(panel);
