// Stable build render for the HUB75 P5 64 x 32 panel front.
// Keep a modest three-quarter angle so the portrait panel remains visually dominant.

use <../../hub75_p5_64x32_panel.scad>

$fn = 120;
$vpt = [0, 0, 0];
$vpr = [85, 0, 25];
$vpd = 850;

panel = hub75_p5_64x32_panel_create();
hub75_p5_64x32_panel_render(panel);
