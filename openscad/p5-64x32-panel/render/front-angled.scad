// Stable build render for the HUB75 P5 64 x 32 panel front.
// Camera matches the angled front presentation used by the display-frame projects.

use <../hub75_p5_64x32_panel.scad>

$fn = 120;
$vpt = [0, 7.25, 0];
$vpr = [85, 0, 40];
$vpd = 500;

panel = hub75_p5_64x32_panel_create();
hub75_p5_64x32_panel_build(panel);
