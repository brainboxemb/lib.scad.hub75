// File: hub75_panel_render.scad
//   Design-render adapter for the HUB75 panel reference component.
//
// FileSummary: Maps stable design view names to the public object/render API.

$fn = 48;

use <hub75_panel.scad>

function _hub75_panel_design_view_id(view) =
    view == "front"        ? HUB75_PANEL_VIEW_FRONT :
    view == "rear"         ? HUB75_PANEL_VIEW_REAR :
    view == "structure"    ? HUB75_PANEL_VIEW_STRUCTURE :
    view == "connectors"   ? HUB75_PANEL_VIEW_CONNECTORS :
    view == "verification" ? HUB75_PANEL_VIEW_VERIFICATION :
    view == "profile"      ? HUB75_PANEL_VIEW_PROFILE :
    HUB75_PANEL_VIEW_FINAL;

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
