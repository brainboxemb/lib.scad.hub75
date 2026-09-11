use <../hub75_p5_64x32_physical_verification_fixtures.scad>

$fn = 96;
panel = hub75_vrf_default_panel();

// Preview-only orientation: present the marked side face upward so the raised
// identifier can be judged clearly. This does not affect STL export orientation.
rotate([0, -90, 0])
    hub75_vrf_top_left_alignment_guide(panel);
