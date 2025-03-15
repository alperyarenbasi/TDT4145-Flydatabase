-- Vi har valgt å tolke det slik at disse flyvningene er planned tiden si skjer i framtiden (per mars 2025) 
-- ANGAGELSE Vi antar jo at disse faktiske flyvningene er mulig å gjøre. Altså at ruten finnes i flyrute og delreise tabellen. Vi har for sikkerhetsskyld lagt til en insert or ignore statement for å ta hensyn til dette 
-- Ignore delen er reletant dersom en prøver å gjøre en faktiskflyvning av en flyrute som ikke eksisterer. Siden flyrutenr er en del av PK vil dette føre til trøbbel i databasen 
INSERT INTO OR IGNORE FaktiskFlyvning (flyrutenummer, lopenr, dato, flyStatus, bruktFly) 
VALUES 
(
    (SELECT flyRuteNr FROM Flyrute WHERE startFlyplassKode = 'BOO' AND endeFlyplassKode = 'TRD'),
    1, '2025-04-01', 'planned', 'LN-WIH'
),
(
    (SELECT flyRuteNr FROM Flyrute WHERE startFlyplassKode = 'TRD' AND endeFlyplassKode = 'OSL'),
    1, '2025-04-01', 'planned', 'LN-ENU'
),
(
    (SELECT flyRuteNr FROM Flyrute WHERE startFlyplassKode = 'TRD' AND endeFlyplassKode = 'BGO'),
    1, '2025-04-01', 'planned', 'SE-RUB'
);


INSERT OR IGNORE INTO FlyvningSegment (flyrutenummer, lopenr, flyvningsegmentnr, faktiskAvgangTid, faktiskAnkomstTid, delreiseNr)
VALUES
    ((SELECT flyRuteNr FROM Flyrute WHERE startFlyplassKode = 'BOO' AND endeFlyplassKode = 'TRD'), 1, 1, '2025-04-01 07:35', '2025-04-01 08:40', 1),  -- WF1302 BOO-TRD
    ((SELECT flyRuteNr FROM Flyrute WHERE startFlyplassKode = 'TRD' AND endeFlyplassKode = 'OSL'), 1, 1, '2025-04-01 10:20', '2025-04-01 11:15', 1),  -- DY753 TRD-OSL
    ((SELECT flyRuteNr FROM Flyrute WHERE startFlyplassKode = 'TRD' AND endeFlyplassKode = 'SVG'), 1, 1, '2025-04-01 10:00', '2025-04-01 11:10', 1),  -- SK888 TRD-BGO
    ((SELECT flyRuteNr FROM Flyrute WHERE startFlyplassKode = 'TRD' AND endeFlyplassKode = 'SVG'), 1, 2, '2025-04-01 11:40', '2025-04-01 12:10', 2);  -- SK888 BGO-SVG