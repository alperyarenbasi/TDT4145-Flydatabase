
-- Vi har her valgt å legge til FlyruteNr Manuelt selv om den er implementert som en autoincrement i databasen. 
-- Dette er for å kunne tydeliggjøre hvilke delreiser som hører til hvilken flyrute.
-- Dette kan egentlig sløyfes men er for å gjøre det enklere å forstå hva som hører til hva.

-- Legg til flyruter med korrekt flyselskapID
INSERT INTO Flyrute (flyRuteNr, ukedagsKode, oppstartsDato, startFlyplassKode, endeFlyplassKode, opereresAvFlySelskap, bruktFlyType)
VALUES 
(1, '12345', '2018-01-01', 'TRD', 'BOO', 'WF', 'Dash-8 100'),  -- WF1311 TRD-BOO
(2,'12345', '2018-01-01', 'BOO', 'TRD', 'WF', 'Dash-8 100'),  -- WF1302 BOO-TRD
(3, '1234567', '2018-01-01', 'TRD', 'OSL', 'DY', 'Boeing 737 800'),  -- DY753 TRD-OSL
(4, '1234567', '2018-01-01', 'OSL', 'TRD', 'SK', 'Airbus A320neo'),  -- SK332 OSL-TRD
(5, '12345', '2018-01-01', 'TRD', 'SVG', 'SK', 'Airbus A320neo');  -- SK888 TRD-SVG via BGO

-- Legg til delreiser
INSERT INTO Delreise (flyRuteNr, delreiseNr, avgangstid, ankomsttid, delStartFlyplassKode, delSluttFlyplassKode)
VALUES 
(1, 1, '15:15', '16:20', 'TRD', 'BOO'),  -- WF1311 TRD-BOO
(2, 1, '07:35', '08:40', 'BOO', 'TRD'),  -- WF1302 BOO-TRD
(3, 1, '10:20', '11:15', 'TRD', 'OSL'),  -- DY753 TRD-OSL
(4, 1, '08:00', '09:05', 'OSL', 'TRD'),  -- SK332 OSL-TRD
(5, 1, '10:00', '11:10', 'TRD', 'BGO'),  -- SK888 TRD-BGO
(5, 2, '11:40', '12:10', 'BGO', 'SVG');  -- SK888 BGO-SVG
--Ideelt sett skulle vi ønske at delreisenr ble satt automatisk men her har vi gjort det manuelt 

-- Legg til prislister (knyttet til delreise)
INSERT INTO Prisliste (priskategori, pris, gyldigfraDato, flyRuteNr, delreiseNr)
VALUES 
    ('okonomi', 2018.00, '2025-01-01', 1, 1),  -- TRD-BGO
    ('premium', 899.00, '2025-01-01', 1, 1),
    ('budsjett', 599.00, '2025-01-01',1, 1),

    ('okonomi', 2018.00, '2025-01-01',2, 1),  -- BGO-SVG
    ('premium', 899.00, '2025-01-01',2, 1),
    ('budsjett', 599.00, '2025-01-01',2, 1),

    ('okonomi', 1500.00, '2025-01-01',3, 1),  
    ('premium', 1000.00, '2025-01-01',3, 1),
    ('budsjett', 500.00, '2025-01-01',3, 1),

    ('okonomi', 1500.00, '2025-01-01',4, 1),
    ('premium', 1000.00, '2025-01-01',4, 1),
    ('budsjett', 500.00, '2025-01-01',4, 1),

    ('okonomi', 2200.00, '2025-01-01',5, NULL),  -- Disse går til flyrute og ikke delreise 
    ('premium', 1700.00, '2025-01-01',5, NULL),
    ('budsjett', 1000.00, '2025-01-01',5, NULL),

    ('okonomi', 2000.00, '2025-01-01',5, 1),  
    ('premium', 1500.00, '2025-01-01',5, 1),
    ('budsjett', 800.00, '2025-01-01',5, 1),

    ('okonomi', 1000.00, '2025-01-01',5, 2),  
    ('premium', 700.00, '2025-01-01', 5, 2),
    ('budsjett', 350.00, '2025-01-01',5, 2);
