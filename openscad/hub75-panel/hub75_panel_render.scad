// File: hub75_panel_render.scad
//   Design-render adapter for the HUB75 panel reference component.
//
// FileSummary: Maps stable design view names to the public object/render API.

$fn = 48;

use <hub75_panel.scad>

function _hub75_panel_design_view_id(view) =
    view == "front"        ? hub75_panel_view_front() :
    view == "rear"         ? hub75_panel_view_rear() :
    view == "structure"    ? hub75_panel_view_structure() :
    view == "connectors"   ? hub75_panel_view_connectors() :
    view == "verification" ? hub75_panel_view_verification() :
    view == "profile"      ? hub75_panel_view_profile() :
    hub75_panel_view_final();

// Module: hub75_panel_design()
// Usage:
//   hub75_panel_design("rear");
// Description:
//   Creates the default panel object and renders one named documentation view.
// Arguments:
//   view = Stable design-documentation view name.
module hub75_panel_design(view = "final") {
    panel = hub75_panel_create();

    hub75_panel_render(
        panel,
        view = _hub75_panel_design_view_id(view)
    );
}

hub75_panel_design();
