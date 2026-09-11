// R2: coarse external-corner radius comparator for the HUB75 rear perimeter.
//
// The production model currently uses R0 at the rear outer X/Z corner. This
// helper does not assume that is physically correct: it provides four small
// concave external-radius references so a real moulded radius can be bracketed
// before changing CAD.

function hub75_vrf_outer_corner_radius_comparator_version() = "v0.2";
function hub75_vrf_outer_corner_radius_comparator_radii() = [0.5, 1.0, 1.5, 2.0];
function hub75_vrf_outer_corner_radius_comparator_probe_leg() = 8.0;
function hub75_vrf_outer_corner_radius_comparator_probe_wall() = 2.5;
function hub75_vrf_outer_corner_radius_comparator_spacing() = 13.0;
function hub75_vrf_outer_corner_radius_comparator_handle_height() = 12.0;

function hub75_vrf_outer_corner_radius_comparator_total_width() =
    let(
        radii = hub75_vrf_outer_corner_radius_comparator_radii(),
        leg = hub75_vrf_outer_corner_radius_comparator_probe_leg(),
        wall = hub75_vrf_outer_corner_radius_comparator_probe_wall(),
        spacing = hub75_vrf_outer_corner_radius_comparator_spacing()
    )
    (len(radii)-1)*spacing + leg + wall;

function hub75_vrf_outer_corner_radius_probe_tangent(index) =
    let(
        total_w = hub75_vrf_outer_corner_radius_comparator_total_width(),
        leg = hub75_vrf_outer_corner_radius_comparator_probe_leg(),
        spacing = hub75_vrf_outer_corner_radius_comparator_spacing()
    )
    [-total_w/2 + leg + index*spacing, 0];

// Canonical external-radius probe around a convex 90-degree corner.
// The theoretical sharp tangent intersection is [0,0]. A physical rounded
// corner of radius r has its arc centre at [-r,-r], so the inner gauge boundary
// must be tangent to y=0 and x=0 with that shifted centre. This is deliberately
// different from cutting a circle centred on [0,0], which would measure the
// wrong geometry.
function _hub75_vrf_outer_radius_probe_points(radius, leg, wall, steps=24) =
    concat(
        [[-leg, 0], [-radius, 0]],
        [
            for(i=[1:steps-1])
                let(a = 90 - i*90/steps)
                [
                    -radius + radius*cos(a),
                    -radius + radius*sin(a)
                ]
        ],
        [
            [0, -radius],
            [0, -leg],
            [wall, -leg],
            [wall, wall],
            [-leg, wall]
        ]
    );

module _hub75_vrf_outer_radius_probe_2d(
    radius,
    leg = hub75_vrf_outer_corner_radius_comparator_probe_leg(),
    wall = hub75_vrf_outer_corner_radius_comparator_probe_wall()
) {
    polygon(points=_hub75_vrf_outer_radius_probe_points(radius, leg, wall));
}

module hub75_vrf_outer_corner_radius_comparator_base(
    thickness = 2.0,
    leg = hub75_vrf_outer_corner_radius_comparator_probe_leg(),
    wall = hub75_vrf_outer_corner_radius_comparator_probe_wall(),
    spacing = hub75_vrf_outer_corner_radius_comparator_spacing(),
    handle_height = hub75_vrf_outer_corner_radius_comparator_handle_height()
) {
    radii = hub75_vrf_outer_corner_radius_comparator_radii();
    total_w = (len(radii)-1)*spacing + leg + wall;

    linear_extrude(height=thickness)
        union() {
            // Slight overlap avoids relying on a merely coplanar contact between
            // the individual probe arms and the common handle.
            translate([-total_w/2, wall-0.05])
                square([total_w, handle_height+0.05]);

            for(i=[0:len(radii)-1]) {
                tangent = hub75_vrf_outer_corner_radius_probe_tangent(i);
                translate(tangent)
                    _hub75_vrf_outer_radius_probe_2d(
                        radii[i],
                        leg,
                        wall
                    );
            }
        }
}

module hub75_vrf_outer_corner_radius_comparator_markings(
    thickness = 2.0,
    leg = hub75_vrf_outer_corner_radius_comparator_probe_leg(),
    wall = hub75_vrf_outer_corner_radius_comparator_probe_wall(),
    spacing = hub75_vrf_outer_corner_radius_comparator_spacing(),
    handle_height = hub75_vrf_outer_corner_radius_comparator_handle_height(),
    version = hub75_vrf_outer_corner_radius_comparator_version(),
    marking_height = 0.50
) {
    radii = hub75_vrf_outer_corner_radius_comparator_radii();
    labels = ["R0.5", "R1.0", "R1.5", "R2.0"];
    z0 = thickness - 0.02;
    h = marking_height + 0.02;

    for(i=[0:len(radii)-1]) {
        tangent = hub75_vrf_outer_corner_radius_probe_tangent(i);
        translate([tangent[0] - (leg-wall)/2, wall+3.1, z0])
            linear_extrude(height=h)
                text(
                    labels[i],
                    size=2.3,
                    halign="center",
                    valign="center"
                );
    }

    translate([0, wall+9.0, z0])
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
