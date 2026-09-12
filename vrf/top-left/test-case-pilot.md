# Test case pilot — upper-left corner

This page is a small trial of a simpler verification format.

Each test case answers one question. It does not also contain design history,
CI status or unrelated measurements.

## Template / Sjabloon

### `[ID] — [short title / korte titel]`

**Question / Vraag**

What do we want to find out?  
Wat willen we vaststellen?

**Needed / Benodigd**

- exact part and revision / exact onderdeel en revisie;
- tool or measuring device / gereedschap of meetmiddel;
- sample ID when relevant / sample-ID indien relevant.

**Before / Vooraf**

Describe the starting position and anything that must already be true.  
Beschrijf de uitgangspositie en wat vooraf in orde moet zijn.

| # | Action / Handeling | Expected / Verwacht |
| ---: | --- | --- |
| 1 | One clear action. / Eén duidelijke handeling. | One observable result. / Eén waarneembaar resultaat. |

**Record / Registratie**

- Sample / sample: `...`
- Date / datum: `...`
- Result / resultaat: `agrees` / `investigate` / `not checked`
- Observed / waargenomen: `...`
- Evidence / bewijs: `...`
- Follow-up / vervolg: `...`

---

# SQ-01 — Hold TL1 square with SQ1

## English

**Question**

Can **SQ1 v0.2** hold **TL1 v0.2** square and in a repeatable position at the
upper-left panel corner without forcing or twisting either part?

This test checks placement only. It does **not** judge whether the TL1 profile
matches the panel; that belongs in a separate test case.

**Needed**

- one physical P5 64 × 32 panel;
- printed TL1 v0.2;
- printed SQ1 v0.2;
- phone or camera;
- sample ID.

**Before**

Place the panel with the rear/electronics side facing you and the 320 mm
direction vertical. Use the physical upper-left corner shown below.

<img src="../../../raw/prod/verification/plan/top-left-location.png" alt="Upper-left verification area on the rear of the panel" width="52%">

| # | Action | Expected |
| ---: | --- | --- |
| 1 | Slide SQ1 over TL1. | SQ1 moves over TL1 without force. Some slot clearance is acceptable. |
| 2 | Put SQ1 on the straight front part of the panel's top edge at the upper-left corner. | SQ1 rests on the intended edge and TL1 points across the panel depth. |
| 3 | Let the two parts settle with light hand contact. Do not twist TL1 to make it look correct. | SQ1 sits naturally and holds TL1 approximately perpendicular to the top edge. |
| 4 | Remove both parts and repeat the placement three times. | The same position and orientation can be found each time. |
| 5 | While seated, check gently for obvious rocking. | No obvious rocking. If it rocks or the seating is unclear, record `investigate` and take a close photo. |
| 6 | Record the result and take one photo of the seated parts. | The record contains a result, observation and evidence reference. |

<img src="../../../raw/prod/verification/plan/top-left-comb-square-use.png" alt="TL1 held square by SQ1 at the upper-left panel edge" width="78%">

**Record**

- Sample: `...`
- Date: `...`
- Result: `agrees` / `investigate` / `not checked`
- Observed: `...`
- Evidence: `...`
- Follow-up: `...`

---

# SQ-01 — TL1 haaks plaatsen met SQ1

## Nederlands

**Vraag**

Kan **SQ1 v0.2** de **TL1 v0.2** zonder forceren of verdraaien haaks en
herhaalbaar op de linkerbovenhoek van het paneel plaatsen?

Deze testcase controleert alleen de plaatsing. Of het TL1-profiel bij het paneel
past, hoort in een aparte testcase.

**Benodigd**

- één fysiek P5 64 × 32-paneel;
- geprinte TL1 v0.2;
- geprinte SQ1 v0.2;
- telefoon of camera;
- sample-ID.

**Vooraf**

Plaats het paneel met de achterzijde/elektronicazijde naar je toe en de
320 mm-richting verticaal. Gebruik de fysieke linkerbovenhoek uit de afbeelding
hierboven.

| # | Handeling | Verwacht |
| ---: | --- | --- |
| 1 | Schuif SQ1 over TL1. | SQ1 schuift zonder kracht over TL1. Enige speling in de sleuf is toegestaan. |
| 2 | Plaats SQ1 op het rechte voorste deel van de bovenrand, bij de linkerbovenhoek. | SQ1 rust op de bedoelde rand en TL1 wijst over de diepte van het paneel. |
| 3 | Laat beide delen met lichte handdruk vanzelf gaan zitten. Verdraai TL1 niet om hem passend te laten lijken. | SQ1 zit natuurlijk op de rand en houdt TL1 ongeveer haaks op de bovenrand. |
| 4 | Neem beide delen weg en herhaal de plaatsing drie keer. | Dezelfde positie en oriëntatie zijn iedere keer terug te vinden. |
| 5 | Controleer voorzichtig of SQ1 duidelijk wiebelt. | Geen duidelijke wiebel. Bij wiebelen of twijfel: noteer `investigate` en maak een detailfoto. |
| 6 | Noteer het resultaat en maak één foto van de geplaatste delen. | De registratie bevat een resultaat, waarneming en verwijzing naar het bewijs. |

**Registratie**

- Sample: `...`
- Datum: `...`
- Resultaat: `agrees` / `investigate` / `not checked`
- Waargenomen: `...`
- Bewijs: `...`
- Vervolg: `...`
