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
    (1010, NULL, 0, (SELECT kundeNr FROM Kunde WHERE kundeNr = 5252));   


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
    (2010, (SELECT pris FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'), 1010, 'Dash-8 100', 3, 'D', 'WF1302', 1, 1, (SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi'));



-- DENNE KAN OGSÅ BRUKES FOR TILFELLER7() I TILFELLER.PY


-- def tilfelle7(cursor):
--     cursor.execute("SELECT COUNT(*) FROM FlyvningSegment WHERE flyrutenummer = 'WF1302' AND lopenr = 1 AND flyvningsegmentnr = 1")
--     segment_count = cursor.fetchone()[0]
    
--     if segment_count == 0:
--         print("Error: The specified flight segment doesn't exist. Check that WF1302 flight is properly set up.")
--         return
    
--     cursor.execute("SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi' LIMIT 1")
--     price_result = cursor.fetchone()
    
--     if not price_result:
--         print("Error: No price found for WF1302 economy class. Check the Prisliste table.")
--         return
    
--     price_id = price_result[0]
    
--     cursor.execute("SELECT COUNT(*) FROM Sete WHERE flyTypeNavn = 'Dash-8 100'")
--     seat_count = cursor.fetchone()[0]
    
--     if seat_count < 10:
--         print(f"Warning: Only {seat_count} seats found for Dash-8 100, but 10 are needed.")
--         return
        
--     sql_script = f"""
--     -- First check if the customer already exists to avoid duplicates
--     INSERT OR IGNORE INTO Kunde (kundeNr, telefonNr, epost, navn, nasjonalitet)
--     VALUES (5252, '94115890', 'ola.nordmann@example.com', 'Ola Nordmann', 'Norsk');

--     -- Insert ten ticket purchases in the BillettKjop table at once
--     INSERT INTO BillettKjop (referanseNr, innsjekkTid, erTurRetur, kjoptAvKundeNr)
--     VALUES
--         (1001, NULL, 0, 5252),
--         (1002, NULL, 0, 5252),
--         (1003, NULL, 0, 5252),
--         (1004, NULL, 0, 5252),
--         (1005, NULL, 0, 5252),
--         (1006, NULL, 0, 5252),
--         (1007, NULL, 0, 5252),
--         (1008, NULL, 0, 5252),
--         (1009, NULL, 0, 5252),
--         (1010, NULL, 0, 5252);

--     -- Insert all 10 tickets at once with predefined seat assignments
--     INSERT INTO DelBillett 
--     (billettID, delPris, delAvBilletKjop, BooketflyTypeNavn, BooketradNr, Booketsetebokstav, Flyrutenummer, lopenr, flyvningsegmentnr, prisID)
--     VALUES
--         (2001, 2018.00, 1001, 'Dash-8 100', 1, 'A', 'WF1302', 1, 1, {price_id}),
--         (2002, 2018.00, 1002, 'Dash-8 100', 1, 'B', 'WF1302', 1, 1, {price_id}),
--         (2003, 2018.00, 1003, 'Dash-8 100', 1, 'C', 'WF1302', 1, 1, {price_id}),
--         (2004, 2018.00, 1004, 'Dash-8 100', 1, 'D', 'WF1302', 1, 1, {price_id}),
--         (2005, 2018.00, 1005, 'Dash-8 100', 2, 'A', 'WF1302', 1, 1, {price_id}),
--         (2006, 2018.00, 1006, 'Dash-8 100', 2, 'B', 'WF1302', 1, 1, {price_id}),
--         (2007, 2018.00, 1007, 'Dash-8 100', 2, 'C', 'WF1302', 1, 1, {price_id}),
--         (2008, 2018.00, 1008, 'Dash-8 100', 2, 'D', 'WF1302', 1, 1, {price_id}),
--         (2009, 2018.00, 1009, 'Dash-8 100', 3, 'A', 'WF1302', 1, 1, {price_id}),
--         (2010, 2018.00, 1010, 'Dash-8 100', 3, 'B', 'WF1302', 1, 1, {price_id});
--     """
    
--     try:
--         cursor.executescript(sql_script)
--         print("Data for tilfelle7 har blitt lagt til i databasen (10 billettbestillinger for WF1302 den 1. april 2025).")
--     except sqlite3.Error as e:
--         print(f"Database error: {e}")
--         cursor.execute("ROLLBACK")
--         return

