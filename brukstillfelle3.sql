-- Legg til flyruter med korrekt flyselskapID
INSERT INTO Flyrute (flyRuteNr, ukedagsKode, oppstartsDato, startFlyplassKode, endeFlyplassKode, opereresAvFlySelskap, bruktFlyType)
VALUES 
(001, '12345', '2018-01-01', 'TRD', 'BOO', 'WF', 'Dash-8 100'),  -- WF1311 TRD-BOO
(002, '12345', '2018-01-01', 'BOO', 'TRD', 'WF', 'Dash-8 100'),  -- WF1302 BOO-TRD
(003, '1234567', '2018-01-01', 'TRD', 'OSL', 'DY', 'Boeing 737 800'),  -- DY753 TRD-OSL
(004, '1234567', '2018-01-01', 'OSL', 'TRD', 'SK', 'Airbus A320neo'),  -- SK332 OSL-TRD
(005, '12345', '2018-01-01', 'TRD', 'SVG', 'SK', 'Airbus A320neo');  -- SK888 TRD-SVG via BGO

-- Legg til delreiser
INSERT INTO Delreise (flyRuteNr, delreiseNr, avgangstid, ankomsttid, delStartFlyplassKode, delSluttFlyplassKode)
VALUES 
(001, 1, '15:15', '16:20', 'TRD', 'BOO'),  -- WF1311 TRD-BOO
(002, 1, '07:35', '08:40', 'BOO', 'TRD'),  -- WF1302 BOO-TRD
(003, 1, '10:20', '11:15', 'TRD', 'OSL'),  -- DY753 TRD-OSL
(004, 1, '08:00', '09:05', 'OSL', 'TRD'),  -- SK332 OSL-TRD
(005, 1, '10:00', '11:10', 'TRD', 'BGO'),  -- SK888 TRD-BGO
(005, 2, '11:40', '12:10', 'BGO', 'SVG');  -- SK888 BGO-SVG
--Ideelt sett skulle vi ønske at delreisenr ble satt automatisk men her har vi gjort det manuelt 

-- Legg til prislister (knyttet til delreise)
INSERT INTO Prisliste (prisID, priskategori, pris, gyldigfraDato, flyRuteNr, delreiseNr)
VALUES 
    (101, 'okonomi', 2018.00, '2025-01-01', 001, 1),  -- TRD-BGO
    (102, 'premium', 899.00, '2025-01-01', 001, 1),
    (103, 'budsjett', 599.00, '2025-01-01', 001, 1),

    (104, 'okonomi', 2018.00, '2025-01-01', 002, 1),  -- BGO-SVG
    (105, 'premium', 899.00, '2025-01-01', 002, 1),
    (106, 'budsjett', 599.00, '2025-03-14', 002, 1),

    (107, 'okonomi', 1500.00, '2025-01-01', 003, 1),  
    (108, 'premium', 1000.00, '2025-01-01', 003, 1),
    (109, 'budsjett', 500.00, '2025-01-01', 003, 1),

    (110, 'okonomi', 1500.00, '2025-01-01', 004, 1),
    (111, 'premium', 1000.00, '2025-01-01', 004, 1),
    (112, 'budsjett', 500.00, '2025-01-01', 004, 1),

    (113, 'okonomi', 2200.00, '2025-01-01', 005, NULL),  
    (114, 'premium', 1700.00, '2025-01-01', 005, NULL),
    (115, 'budsjett', 1000.00, '2025-01-01', 005, NULL),

    (116, 'okonomi', 2000.00, '2025-01-01', 005, 1),  
    (117, 'premium', 1500.00, '2025-01-01', 005, 1),
    (118, 'budsjett', 800.00, '2025-01-01', 005, 1),

    (116, 'okonomi', 1000.00, '2025-01-01', 005, 2),  
    (117, 'premium', 700.00, '2025-01-01', 005, 2),
    (118, 'budsjett', 350.00, '2025-01-01', 005, 2);

