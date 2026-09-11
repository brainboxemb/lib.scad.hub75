# Stage 1B — corner radius, reinforcement and repeatable TL1 placement

Stage 1B stays in the same **upper-left corner as seen from the rear**. It adds
three questions that are easy to confuse when looking only at the complete panel:

1. is TL1 actually held square while comparing the side profile?
2. which corner radius are we checking — the outside perimeter or the bay opening?
3. does the separate reinforcement feature have the expected relationship to the
   outside wall and the bay opening?

The generated 1:1 drawing for this stage is available as both a human-readable
preview and a DXF:

- [dimension-sheet preview](../../../raw/prod/verification/drawings/hub75-p5-64x32-top-left-dimensions.png)
- [1:1 DXF](../../../raw/prod/verification/drawings/hub75-p5-64x32-top-left-dimensions.dxf)

The DXF geometry comes from the same public accessors as the fixtures. It is not a
separately hand-drawn interpretation.

---

## Keep TL1 square: `SQ1 v0.1`

TL1 is only useful as a profile comparator when its plate is perpendicular to the
physical top edge. Holding a 2 mm plate by eye is not repeatable enough.

`SQ1 v0.1` is a small slotted alignment shoe. It sits only on the straight
front-most part of the panel's top edge and holds the TL1 plate in a 90-degree
orientation across the panel width. The slot deliberately has clearance: SQ1 is
an **orientation aid**, not a measurement of TL1 thickness.

<img src="../../../raw/prod/verification/fixtures/hub75-p5-64x32-top-left-alignment-guide.png" alt="SQ1 alignment guide" width="58%">

Use the pair as shown below.

<img src="../../../raw/prod/verification/plan/top-left-comb-square-use.png" alt="TL1 profile comb with SQ1 square guide on the panel" width="82%">

Procedure:

1. slide SQ1 over TL1;
2. move SQ1 to the front straight part of the top edge;
3. let SQ1 sit naturally on that edge without forcing it down;
4. only then inspect TL1 contact along the front-to-rear profile;
5. if SQ1 rocks on the physical top edge, record that separately — do not twist
   TL1 until the profile appears to fit.

A future fixture revision may integrate the square into TL1, but the separate
piece is intentional for the first physical test: it makes it obvious whether a
problem comes from profile geometry or from the alignment aid.

---

## Multicolour printing on X2D + AMS

The verification fixtures are supplied in two forms:

- one **combined STL** for a normal single-colour print;
- separate **base** and **markings** STLs with an identical origin for AMS use.

For an AMS print, import the base and markings together as one multipart object
in Bambu Studio, then assign the markings to a contrasting filament. Do not move,
centre or auto-arrange the two parts independently before combining them.

Raised information is used instead of small engraved text. The text/markers are
about 0.5 mm proud and live on non-datum faces, so colour and readability do not
change the contact geometry.

For TL1 the physical part is now **`TL1 v0.2`**. `S` marks the screw-centre
witness and `R` the reinforcement-centre witness.

---

## Two different corner-radius questions

The upper-left area contains two completely different corners. Record them as
separate checks.

### CR-01 — outside rear-perimeter corner

The current production model uses a tapered rectangular outer blank. In X/Z the
rear perimeter therefore has a **sharp R0 corner**. There is currently no
non-zero outer-corner-radius parameter.

That does **not** prove the real moulded panel is R0.

The yellow L in the detail image marks this exact outer corner. Do not confuse it
with the much larger magenta bay-opening radius.

<img src="../../../raw/prod/verification/plan/top-left-radius-reinforcement.png" alt="Bay radius, reinforcement and outer rear corner" width="78%">

### Use `R2 v0.1` if the outside corner is visibly rounded

A true R0 corner cannot be represented by a useful printed notch: printer nozzle
and layer rounding would dominate the result. `R2 v0.1` therefore answers the
next practical question instead — **if it is not visually sharp, roughly how
large is the moulded radius?**

It supplies four small concave references:

```text
R0.5     R1.0     R1.5     R2.0
```

<img src="../../../raw/prod/verification/fixtures/hub75-p5-64x32-outer-corner-radius-comparator.png" alt="R2 outer-corner radius comparator" width="78%">

Procedure:

1. first inspect the real rear-perimeter corner without R2;
2. if it looks genuinely sharp at the scale of the moulding, record
   `consistent with R0 / below useful printed-comparator resolution` and take a
   close photograph;
3. if it is clearly rounded, hold R2 square to the rear X/Z corner;
4. compare R0.5, R1.0, R1.5 and R2.0 without forcing the plastic against the
   panel;
5. record the best match or the two adjacent values if the result falls between
   them;
6. photograph the best fit approximately normal to the corner.

R2 is deliberately coarse. A result such as “between R1.0 and R1.5” is useful
evidence; it is **not** a reason to enter R1.25 into the production model. If a
non-zero radius matters to mating geometry, follow up with a finer gauge,
profile image/scan or another repeatable method before changing the library.

Printer dimensional error is especially significant at these small radii. Record
printer/nozzle/material/profile with the observation. The X2D/AMS colour split
is only for readability; the radius geometry is entirely in the base body.

### CR-02 — inside corner of the top rear bay

The concave bay-opening corner is explicitly modelled and has a public accessor:

```text
hub75_p5_64x32_panel_rear_opening_corner_radius()
```

Current target:

```text
R = 4.991 mm approximately
```

The highlighted view shows the relevant inside corner in magenta. The blue circle
is the nearby reinforcement feature; the yellow L is the current sharp rear
perimeter corner.

---

## Use `R1 v0.1` for the bay radius

`R1 v0.1` is a coarse physical comparator around the expected R5 bay corner.
It intentionally gives three nearby convex probes rather than one probe that can
only confirm our own assumption:

```text
R4.5     R5.0     R5.5
```

<img src="../../../raw/prod/verification/fixtures/hub75-p5-64x32-corner-radius-comparator.png" alt="R1 three-radius comparator" width="78%">

Use it as a discriminator, not as a calibrated radius gauge:

1. hold the comparator square to the rear face;
2. bring one probe gently into the concave bay corner;
3. do not force the probe into the moulding;
4. compare visible rocking/gaps for R4.5, R5.0 and R5.5;
5. record which probe is the best visual fit;
6. photograph the best fit approximately square to the rear face.

If R5.0 is clearly best, that supports the current model. If two probes are
indistinguishable, record the result as such instead of inventing extra precision.
If R4.5 or R5.5 is clearly better, repeat with a finer comparator before changing
the library.

Printer dimensional error matters here. Record printer/nozzle/material/profile
and, if the result is close, measure or optically inspect the printed probe too.

---

## Reinforcement geometry is not a complete Ø14 circle at the outside wall

The upper-left reinforcement feature is deliberately asymmetric with respect to
the outer wall. The production model starts from a Ø14 reinforcement cylinder,
but clips it with the same continuous tapered envelope as the outside panel wall.
The external wall therefore stays continuous rather than bulging outward.

Current local relationships from the public model are:

| Check | Current target |
| --- | ---: |
| reinforcement centre from physical left edge | 7.850 mm |
| reinforcement centre from physical top edge | 18.855 mm |
| reinforcement outer diameter | 14.000 mm |
| reinforcement recess diameter | 10.000 mm |
| reinforcement blind-hole diameter | 2.500 mm |
| rear perimeter inset from physical left edge | about 1.248 mm |
| bay edge reference from physical left edge | about 12.500 mm |

The useful derived relationships are:

```text
reinforcement outside extent toward panel edge
= 7.850 - 14/2
= 0.850 mm from the physical edge

rear perimeter at the mounting plane
≈ 1.248 mm from the physical edge

raw Ø14 circle therefore crosses the tapered perimeter by
≈ 1.248 - 0.850
≈ 0.398 mm
```

So the outer side of the feature should be visibly clipped/merged into the
continuous outside wall.

At the other side:

```text
reinforcement inside extent
= 7.850 + 14/2
= 14.850 mm from the physical edge

bay-edge reference
≈ 12.500 mm from the physical edge

reinforcement therefore projects into the bay by
≈ 14.850 - 12.500
≈ 2.350 mm
```

This **2.35 mm inward projection** is a much more useful physical check than just
asking whether something is roughly Ø14.

Check and record separately:

- does the outside wall stay smooth/continuous through the reinforcement area?
- does the reinforcement visibly project into the bay by roughly the expected
  amount?
- is the rear recess concentric with the retained reinforcement material?
- are Ø14, Ø10 and the blind hole individually plausible/measurable?

If the real part instead has a complete circular boss bulging through the outside
wall, the production model is conceptually wrong even if the diameters themselves
are correct.

For RF-01/RF-02, use the dimension sheet and a direct caliper/visual measurement
first. No extra printed gauge is introduced yet: a custom fixture would add its
own printer tolerance without answering this local relationship better than the
1:1 drawing plus direct measurement.

---

## Dimension sheet — what it is for

The generated DXF is a **1:1 reference drawing**, not a replacement for the
measurement record. Its left-side rear view contains:

- datum A: physical top edge;
- datum B: physical rear-view left edge;
- mounting tube and screw-hole centre;
- reinforcement OD/recess/blind-hole circles;
- rear-perimeter inset and the current R0 outer corner;
- the R~4.99 bay-opening corner;
- actual dimension lines for TL-01, TL-02 and TL-06;
- local callouts for tube, reinforcement, radius and reinforcement/wall relation.

The right-side table names the TL/CR/RF checks and nominal values. A small side
profile underneath shows the front-to-rear taper start, 14.5 mm rear mounting
plane and rear inset.

Useful ways to use the DXF:

- inspect exact nominal geometry in CAD;
- print at 100% as a disposable visual reference after checking printer scaling;
- place a photograph/scan over it in CAD for qualitative comparison;
- use it to decide which caliper/tangent dimensions are practical before touching
  the library model.

Never infer a sub-0.1 mm correction merely because a normal office printer or a
phone photograph does not overlay perfectly.

---

## Stage 1B result table

| ID | Observation | Result |
| --- | --- | --- |
| SQ-01 | TL1 can be held square/repeatably with SQ1 | pending |
| CR-01 | outside rear corner: visually R0 / R0.5 / R1.0 / R1.5 / R2.0 / between / unclear | pending |
| CR-02 | best bay-corner probe: R4.5 / R5.0 / R5.5 / unclear | pending |
| RF-01 | outside wall remains continuous through reinforcement | pending |
| RF-02 | reinforcement projects into bay about 2.35 mm | pending |
| RF-03 | Ø14 outer retained region | pending |
| RF-04 | Ø10 recess | pending |
| RF-05 | Ø2.5 blind hole | pending |

Use the same `agrees`, `investigate` and `not checked` result words as Stage 1.
