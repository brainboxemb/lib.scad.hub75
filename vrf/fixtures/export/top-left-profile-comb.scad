use <../hub75_p5_64x32_physical_verification_fixtures.scad>

$fn = 96;
$vpr = [65, 0, 35];
$vpt = [10.4, 13.5, 1];
$vpd = 70;

panel = hub75_vrf_default_panel();
hub75_vrf_top_left_profile_comb(panel);
