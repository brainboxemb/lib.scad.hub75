# SQ-01 — TL1 haaks plaatsen met SQ1

**Vraag**

Kan SQ1 TL1 zonder forceren of verdraaien haaks en herhaalbaar op de linkerbovenhoek van het paneel plaatsen?

Deze testcase controleert **alleen de plaatsing en herhaalbaarheid**. Of het TL1-profiel de echte paneelgeometrie en maatvoering volgt, hoort in een aparte testcase.

**Status**

`defined` — nog niet fysiek uitgevoerd.

De eerste ontwikkelversie van deze testcase gebruikte TL1 v0.2 en SQ1 v0.2 in PR #19. Die fixture-implementatie wordt niet met deze documentatieslice naar `main` overgenomen. Voor uitvoering moeten de te gebruiken fixture-revisies opnieuw worden bevestigd en gepubliceerd.

**Benodigd**

- één fysiek P5 64 × 32-paneel met sample-ID;
- een goedgekeurde TL1-revisie;
- een bijpassende goedgekeurde SQ1-revisie;
- telefoon of camera.

**Vooraf**

Plaats het paneel met de achterzijde/elektronicazijde naar je toe en de 320 mm-richting verticaal. Gebruik de fysieke linkerbovenhoek die in de bestaande verificatie-output is gemarkeerd.

<img src="../../../../../raw/prod/verification/plan/top-left-location.png" alt="Linkerbovenhoek voor de controle aan de achterzijde van het paneel" width="52%">

| # | Handeling | Verwacht |
| ---: | --- | --- |
| 1 | Schuif SQ1 over TL1. | SQ1 schuift zonder kracht over TL1. Enige functionele speling in de sleuf is toegestaan. |
| 2 | Plaats SQ1 op het rechte voorste deel van de bovenrand, bij de linkerbovenhoek. | SQ1 rust op de bedoelde rand en TL1 wijst over de diepte van het paneel. |
| 3 | Laat beide delen met lichte handdruk vanzelf gaan zitten. Verdraai TL1 niet om hem passend te laten lijken. | SQ1 zit natuurlijk op de rand en houdt TL1 ongeveer haaks op de bovenrand. |
| 4 | Neem beide delen weg en herhaal de plaatsing drie keer. | Dezelfde positie en oriëntatie zijn iedere keer terug te vinden. |
| 5 | Controleer voorzichtig of SQ1 duidelijk wiebelt. | Geen duidelijke wiebel. Bij wiebelen of twijfel: noteer `investigate` en maak een detailfoto. |
| 6 | Noteer het resultaat en maak één foto van de geplaatste delen. | De registratie bevat een resultaat, waarneming en verwijzing naar het bewijs. |

**Registratie**

- Sample: `...`
- Datum: `...`
- TL1-revisie: `...`
- SQ1-revisie: `...`
- Resultaat: `agrees` / `investigate` / `not checked`
- Waargenomen: `...`
- Bewijs: `...`
- Vervolg: `...`
