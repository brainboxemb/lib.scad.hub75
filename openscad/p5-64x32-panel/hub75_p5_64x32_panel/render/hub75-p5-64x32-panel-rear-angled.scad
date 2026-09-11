// Stable build render for the HUB75 P5 64 x 32 panel rear.
// Keep the panel level while using a modest side angle to show its depth.

use <../../hub75_p5_64x32_panel.scad>

$fn = 120;
$vpt = [0, 0, 0];
$vpr = [90, 0, 205];
$vpd = 850;

panel = hub75_p5_64x32_panel_create();
hub75_p5_64x32_panel_render(panel);
