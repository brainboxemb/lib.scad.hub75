# Physical HUB75 panel validation plan

## Goal

The current P5 64 × 32 model is coherent against the supplied drawing, STEP
model and rear photograph, but it has not yet been systematically checked against
a physical panel.

This verification phase has three goals:

1. measure the real panel and compare fit-critical geometry with the model;
2. distinguish nominal specification values from sample-specific measurements;
3. prove that project-specific mating parts can be built from the public library
   API without reaching into private object fields.

A successful OpenSCAD render is not physical verification.

## Evidence model

Keep three concepts separate for every dimension:

```text
specification / source value
        ↓
physical sample observation
        ↓
accepted library value
```

A measurement on one panel is evidence about that sample. It does not silently
replace a drawing-derived nominal value. If a measured value disagrees with the
drawing or STEP model, record the disagreement first. Change library geometry
only after the discrepancy is understood and the intended modelling rule is
explicit.

Each physical panel should get a stable sample ID, starting for example with:

```text
P5-64X32-001
```

For every measurement record:

- sample ID;
- feature ID;
- measuring tool and, when useful, tool resolution/uncertainty;
- at least three readings where repeatability can matter;
- measurement method/reference edges;
- photograph or sketch when the datum is not obvious;
- mean/range or selected reading;
- current model value/accessor;
- result: pending / agrees / investigate / model-change-approved.

## Measurement order

Measure the fit-critical geometry first. Cosmetic rear details are deliberately
last.

### P0 — physical envelope and mounting pattern

These dimensions affect every consumer and should be checked first.

| Feature | Current model target | Primary check |
| --- | ---: | --- |
| physical width | 159.70 mm | caliper, several positions |
| physical height | 319.71 mm | caliper, several positions |
| overall depth | 14.50 mm | front datum to rearmost mounting plane |
| left/right hole centre from side edge | 7.85 mm | edge-to-centre / corner datum gauge |
| bottom/top hole centre from end edge | 7.855 mm | edge-to-centre / corner datum gauge |
| horizontal mounting spacing | 144.00 mm | left ↔ right hole/boss centres |
| adjacent vertical row spacing | 152.00 mm | bottom ↔ middle and middle ↔ top |
| mounting-hole diameter | 3.00 mm | pin/caliper check |
| mounting tube outer diameter | 8.50 mm | caliper + fit gauge |
| mounting tube protrusion | 0.50 mm | depth/step measurement |

The full bottom-to-top mounting span does not need a 304 mm printed gauge: the
same 152 mm adjacent-row gauge can be checked twice. A direct caliper/reference
measurement of the complete span is still useful as a cross-check.

### P1 — rear mating geometry

These dimensions drive coupler guides and should be confirmed before treating
project fit as final.

| Feature | Current model target | Public API |
| --- | ---: | --- |
| side rail width at mounting plane | ~11.252 mm | `hub75_p5_64x32_panel_rear_side_rail_width_at_mounting_plane()` |
| end rail width at mounting plane | ~9.501 mm | `hub75_p5_64x32_panel_rear_end_rail_width_at_mounting_plane()` |
| narrow end width at mounting plane | ~6.501 mm | `hub75_p5_64x32_panel_rear_end_narrow_width_at_mounting_plane()` |
| crossbar width | ~19.982 mm | `hub75_p5_64x32_panel_rear_crossbar_width_at_mounting_plane()` |
| bay opening corner radius | ~4.991 mm | `hub75_p5_64x32_panel_rear_opening_corner_radius()` |
| rear outer inset | model-derived | `hub75_p5_64x32_panel_rear_outer_inset_x/z()` |
| continuous outer taper | STEP-derived | profile measurement / profile fixture |
| narrow end section length | 30 mm reference | direct measurement |

For the taper, measure at more than one Y depth. A correct rear-plane width alone
cannot prove that the continuous profile between the PCB/rear-frame start and the
mounting plane is correct.

### P2 — local mating features

| Feature | Current model target |
| --- | ---: |
| locator pin diameter | 3.00 mm |
| locator pin protrusion | 3.00 mm |
| reinforcement outer diameter | 14.00 mm |
| reinforcement recess diameter | 10.00 mm |
| reinforcement recess depth | 2.50 mm |
| reinforcement blind-hole diameter | 2.50 mm |
| reinforcement blind-hole depth | 10.00 mm |
| reinforcement offset | 11.00 mm |

Besides diameter/depth, record centre positions relative to nearby mounting-hole
centres or physical edges. Relative dimensions are often more useful for mating
parts than absolute coordinates.

### P3 — connector keep-outs

Confirm connector position, width, height and rear projection where a bracket or
coupler can approach them. Electrical/cosmetic details that never constrain a
mating part do not need the same metrology effort.

### P4 — visual-only details

Orientation arrows and other purely visual features remain secondary evidence.
They are not required to declare the mechanical model verified.

## Radius measurements

Do not infer a radius from a single chord measurement when the feature can be
checked directly.

Use a printed radius comparator as a first-pass discriminator, but do not treat
the nominal CAD radius of the printed gauge as metrology-grade evidence. Record
printer/material/profile and measure the printed comparator itself where the
result matters. A metal radius gauge, profile scan/photo with a scale reference,
or repeatable coordinate measurement is stronger evidence.

The first comparator should cover the expected rear-opening radius with nearby
alternatives, for example 4.0, 4.5, 5.0, 5.5 and 6.0 mm, and provide both
concave and convex references so inner and outer radii can be compared.

## Public-API verification

The existing `test/hub75_p5_64x32_panel_api.scad` proves software regression: it
asserts that current accessors return current expected values. That is useful but
circular for physical validation.

Physical/API verification should therefore use an independent accepted baseline:

```text
physical measurements / source evidence
        ↓
accepted verification baseline
        ↓
public API probe
        ↓
comparison test
```

The public probe must import the component with `use <...>` and use only public
functions. It should emit at least:

- envelope dimensions;
- mounting-hole positions and spacing;
- mounting plane;
- rail/end/crossbar widths;
- opening corner radius;
- boss and locator dimensions;
- reinforcement dimensions relevant to consumers.

A small mating coupon must also be constructed only from public accessors. If a
reasonable consumer fixture cannot be built without reading private object
fields, that is an API-design finding: either a public accessor is missing or
that feature should deliberately not be part of the public mating contract.

## Acceptance rule

Do not use a single global tolerance for every feature.

Classify findings by function:

- **location-critical** — mounting-hole centres, locator centres;
- **fit-critical** — boss OD, rail/crossbar widths, radii, taper;
- **clearance-critical** — connector keep-outs;
- **visual** — markings and non-mating details.

Set acceptance tolerances only after the measurement method and print/process
capability are known. The first measurement round is for collecting evidence,
not forcing every reading into a preselected ± value.

## Companion data repository

Recommended name: `lib.scad.hub75.data`.

Suggested structure:

```text
lib.scad.hub75.data/
├── README.md
├── source/
│   └── p5-64x32/
│       ├── drawings/
│       ├── step/
│       └── metadata/
├── samples/
│   └── P5-64X32-001/
│       ├── sample.yml
│       ├── measurements.yml
│       └── photos/
├── derived/
│   └── p5-64x32/
│       └── accepted-reference.yml
└── assets/
    └── non-authoritative supporting material
```

`source/` is original input/evidence, `samples/` records what was actually
measured, `derived/` contains normalized findings, and `assets/` is explicitly
non-authoritative supporting material.

If redistribution rights for a supplied STEP/PDF/photo are unclear, do not put
the binary in a public repository. Store provenance, filename/hash and an
external/private reference instead.

The library should pin or record the exact data-repository commit used to accept
a baseline, but normal consumers of `lib.scad.hub75` should not need to clone the
large/raw data repository.

## Completion criteria

The P5 64 × 32 model is physically verified when:

1. all P0 and P1 entries have physical evidence;
2. unresolved discrepancies are documented rather than hidden;
3. location- and fit-critical public accessors agree with the accepted baseline;
4. the small public-API mating coupons fit the real panel as intended;
5. verification evidence is reproducible from a named sample and data commit;
6. any library geometry corrections have their own reviewed change and do not
   get mixed into the measurement-data commit.
