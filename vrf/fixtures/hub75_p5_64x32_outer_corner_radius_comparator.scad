// R2: coarse external-corner radius comparator for the HUB75 rear perimeter.
//
// The production model currently uses R0 at the rear outer X/Z corner. This
// helper does not assume that is physically correct: it provides four small
// concave notches so a real moulded radius can be bracketed before changing CAD.

function hub75_vrf_outer_corner_radius_comparator_version() = "v0.1";
function hub75_vrf_outer_corner_radius_comparator_radii() = [0.5, 1.0, 1.5, 2.0];
function hub75_vrf_outer_corner_radius_comparator_probe_size() = 10.0;
function hub75_vrf_outer_corner_radius_comparator_spacing() = 14.0;
function hub75_vrf_outer_corner_radius_comparator_handle_height() = 12.0;
function hub75_vrf_outer_corner_radius_comparator_total_width() =
    let(
        radii = hub75_vrf_outer_corner_radius_comparator_radii(),
        spacing = hub75_vrf_outer_corner_radius_comparator_spacing(),
        probe_size = hub75_vrf_outer_corner_radius_comparator_probe_size()
    )
    (len(radii)-1)*spacing + probe_size;
function hub75_vrf_outer_corner_radius_probe_notch_corner(index) =
    let(
        total_w = hub75_vrf_outer_corner_radius_comparator_total_width(),
        spacing = hub75_vrf_outer_corner_radius_comparator_spacing(),
        probe_size = hub75_vrf_outer_corner_radius_comparator_probe_size(),
        x0 = -total_w/2
    )
    [x0 + index*spacing + probe_size, probe_size];

module _hub75_vrf_outer_radius_probe_2d(radius, size=10.0) {
    // Concave quarter-circle at the exposed upper-right corner. The adjacent
    // straight edges provide tangent references against the real moulding.
    difference() {
        square([size, size]);
        translate([size, size])
            circle(r=radius, $fn=64);
    }
}

module hub75_vrf_outer_corner_radius_comparator_base(
    thickness = 2.0,
    probe_size = hub75_vrf_outer_corner_radius_comparator_probe_size(),
    spacing = hub75_vrf_outer_corner_radius_comparator_spacing(),
    handle_height = hub75_vrf_outer_corner_radius_comparator_handle_height()
) {
    radii = hub75_vrf_outer_corner_radius_comparator_radii();
    total_w = (len(radii)-1)*spacing + probe_size;
    x0 = -total_w/2;

    linear_extrude(height=thickness)
        union() {
            translate([x0, -handle_height])
                square([total_w, handle_height]);

            for(i=[0:len(radii)-1])
                translate([x0 + i*spacing, 0])
                    _hub75_vrf_outer_radius_probe_2d(
                        radii[i],
                        probe_size
                    );
        }
}

module hub75_vrf_outer_corner_radius_comparator_markings(
    thickness = 2.0,
    probe_size = hub75_vrf_outer_corner_radius_comparator_probe_size(),
    spacing = hub75_vrf_outer_corner_radius_comparator_spacing(),
    handle_height = hub75_vrf_outer_corner_radius_comparator_handle_height(),
    version = hub75_vrf_outer_corner_radius_comparator_version(),
    marking_height = 0.50
) {
    radii = hub75_vrf_outer_corner_radius_comparator_radii();
    total_w = (len(radii)-1)*spacing + probe_size;
    x0 = -total_w/2;
    z0 = thickness - 0.02;
    h = marking_height + 0.02;

    for(i=[0:len(radii)-1])
        translate([x0 + i*spacing + probe_size/2, -3.3, z0])
            linear_extrude(height=h)
                text(
                    str("R", radii[i]),
                    size=2.3,
                    halign="center",
                    valign="center"
                );

    translate([0, -9.0, z0])
        linear_extrude(height=h)
            text(
                str("R2 ", version),
                size=2.8,
                halign="center",
                valign="center"
            );
}

module hub75_vrf_outer_corner_radius_comparator() {
    union() {
        hub75_vrf_outer_corner_radius_comparator_base();
        hub75_vrf_outer_corner_radius_comparator_markings();
    }
}
