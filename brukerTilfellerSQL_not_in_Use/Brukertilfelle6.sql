-- Finn avganger fra valgt flyplass på en spesifikk ukedag
SELECT flyRuteNr, startFlyplassKode, endeFlyplassKode, ukedagsKode
FROM Flyrute
WHERE startFlyplassKode = ?
AND instr(ukedagsKode, ?) > 0;

-- Finn ankomster til valgt flyplass på en spesifikk ukedag
SELECT flyRuteNr, startFlyplassKode, endeFlyplassKode, ukedagsKode
FROM Flyrute
WHERE endeFlyplassKode = ?
AND instr(ukedagsKode, ?) > 0;
