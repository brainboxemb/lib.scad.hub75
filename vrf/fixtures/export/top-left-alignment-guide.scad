use <../hub75_p5_64x32_physical_verification_fixtures.scad>

$fn = 96;
$vpr = [90, 0, 90];

panel = hub75_vrf_default_panel();
hub75_vrf_top_left_alignment_guide(panel);
