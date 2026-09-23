# HUB75 library specification

This document explains **why the library and its panel reference model exist**
and what consumers should be able to rely on conceptually.

## Why this library exists

HUB75 projects need repeatable mechanical knowledge of real LED matrix hardware:
panel envelope, mounting pattern, rear mating geometry, protrusions, locator
features and connector keep-outs.

If every project copies those dimensions into its own OpenSCAD source, the same
hardware quickly acquires several inconsistent definitions. This library exists
to keep one reusable mechanical reference model and one public mechanical API.

## What the P5 64 × 32 model should achieve

The model should let a consumer:

- place and render a recognisable P5 64 × 32 panel;
- obtain mechanical dimensions through a stable panel object and public accessors;
- build mating project geometry without reaching into private implementation state;
- distinguish the physical panel envelope from the nominal placement cell;
- understand which geometry is drawing-derived, STEP-derived or only supported by secondary visual evidence;
- inspect how the model was constructed;
- verify both software/API behavior and correspondence with physical hardware.

## Source hierarchy

Not all source material has the same authority.

For the current panel:

1. the supplied dimensional drawing owns authoritative envelope and mounting dimensions where it specifies them;
2. the supplied STEP model owns taper/rear mechanical form where that use is explicitly recorded;
3. photographs are secondary visual/orientation evidence only.

An approximation or photo/STEP observation must not silently become a
"drawing-derived" dimension.

## Mechanical API intent

Mechanical information belongs to the panel object and public accessors.
Consumers should create a semantic panel object and pass it through the library
instead of recreating unrelated global scalar state.

The library's native coordinate system remains stable:

```text
X = panel width, centred
Y = front to rear, front face Y=0
Z = panel height, centred
```

A consuming assembly may orient the complete panel differently; that does not
change the reference model's native axes.

## Physical versus nominal placement size

The physical body and the nominal panel-placement cell are intentionally
different concepts. Consumers must not infer that a nominal 160 × 320 mm cell
means the molded body exactly fills that rectangle.

The exact current values and accessors belong in the panel manual/source rather
than being duplicated here.

## Verification intent

Software/API checks prove that the implementation is internally consistent with
its current source. They do not prove that the source agrees with a real panel.

Physical verification therefore asks separate, small questions against
identified hardware samples. A printed fixture is a measurement aid, not proof
by itself.

The evidence model is:

```text
source / model target
        ↓
physical sample observation
        ↓
reviewed accepted library value
```

A mismatch is recorded and investigated before geometry is changed.

## Non-goals

This library does not own:

- project-specific brackets, couplers or frame geometry;
- a universal manufacturing or printer tolerance policy;
- slicer settings;
- an electronics/software abstraction of HUB75 signaling;
- a claim that the whole panel is physically verified before retained physical evidence exists;
- arbitrary replacement of source-derived dimensions merely to improve the fit of a printed helper.
