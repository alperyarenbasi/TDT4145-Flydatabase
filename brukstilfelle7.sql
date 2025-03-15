INSERT INTO Kunde (kundeNr, telefonNr, epost, navn, nasjonalitet)
VALUES (5252, '94115890', 'ola.nordmann@example.com', 'Ola Nordmann', 'Norsk');


-- Sett inn ti billettkjøp i BillettKjop-tabellen
INSERT INTO BillettKjop (referanseNr, innsjekkTid, erTurRetur, kjoptAvKundeNr)
VALUES
    (1001, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252)),
    (1002, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252)),
    (1003, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252)),
    (1004, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252)),
    (1005, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252)),
    (1006, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252)),
    (1007, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252)),
    (1008, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252)),
    (1009, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252));   

-- Sett inn ti delbilletter i DelBillett-tabellen med unike seter
INSERT INTO DelBillett (billettID, delPris, delAvBilletKjop, BooketflyTypeNavn, BooketradNr, Booketsetebokstav, Flyrutenummer, lopenr, flyvningsegmentnr, prisID)
VALUES
    (2001, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1001, 'Dash-8 100', 1, 'C', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2002, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1002, 'Dash-8 100', 1, 'D', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2003, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1003, 'Dash-8 100', 2, 'A', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2004, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1004, 'Dash-8 100', 2, 'B', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2005, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1005, 'Dash-8 100', 2, 'C', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2006, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1006, 'Dash-8 100', 2, 'D', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2007, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1007, 'Dash-8 100', 3, 'A', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2008, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1008, 'Dash-8 100', 3, 'B', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2009, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1009, 'Dash-8 100', 3, 'C', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi')),
    (2010, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1010, 'Dash-8 100', 100, 'D', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'));