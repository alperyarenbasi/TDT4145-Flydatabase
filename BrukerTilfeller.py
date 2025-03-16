import sqlite3

def tilfelle1(cursor):  
    cursor.execute("""
                INSERT INTO Flyplass (flyPlassKode, flyPlassNavn) VALUES
                    ('BOO', 'Bodø Lufthavn'),
                    ('BGO', 'Bergen lufthavn, Flesland'),
                    ('OSL', 'Oslo lufthavn, Gardermoen'),
                    ('SVG', 'Stavanger lufthavn, Sola'),
                    ('TRD', 'Trondheim lufthavn, Værnes')
                """)
    print("Data for tilfelle1 har blitt lagt til i databasen (flyplasser).")



def tilfelle2(cursor):
    sql_script = """
    -- Sett inn i Flyprodusent først
    INSERT INTO Flyprodusent (produsentNavn, stiftelsesAar) VALUES
        ('The Boeing Company', 1916),
        ('Airbus Group', 1970),
        ('De Havilland Canada', 1928);

    -- Deretter Flyselskap
    INSERT INTO Flyselskap (flyselskapID, navn) VALUES
        ('DY', 'Norwegian'),
        ('SK', 'SAS'),
        ('WF', 'Widerøe');

    -- Så Flytype, som avhenger av Flyprodusent
    INSERT INTO Flytype (flytypeNavn, forsteProduksjonAAr, sisteProduksjonAAr, antallRader, FlytypeProdusent) VALUES
        ('Boeing 737 800', 1997, 2020, 31, 'The Boeing Company'),
        ('Airbus A320neo', 2016, NULL, 30, 'Airbus Group'),
        ('Dash-8 100', 1984, 2005, 10, 'De Havilland Canada');

    -- Norwegian (Airbus A320neo)
    INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
        ('LN-ENU', NULL, 2015, '42069', 'DY', 'Airbus Group', 'Airbus A320neo'),
        ('LN-ENR', 'Jan Bålsrud', 2018, '42093', 'DY', 'Airbus Group', 'Airbus A320neo'),
        ('LN-NIQ', 'Max Manus', 2011, '39403', 'DY', 'Airbus Group', 'Airbus A320neo'),
        ('LN-ENS', NULL, 2017, '42281', 'DY', 'Airbus Group', 'Airbus A320neo');

    -- SAS (Airbus A320neo)
    INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
        ('SE-RUB', 'Birger Viking', 2020, '9518', 'SK', 'Airbus Group', 'Airbus A320neo'),
        ('SE-DIR', 'Nora Viking', 2023, '11421', 'SK', 'Airbus Group', 'Airbus A320neo'),
        ('SE-RUP', 'Ragnhild Viking', 2024, '12066', 'SK', 'Airbus Group', 'Airbus A320neo'),
        ('SE-RZE', 'Ebbe Viking', 2024, '12166', 'SK', 'Airbus Group', 'Airbus A320neo');

    -- Widerøe (Airbus A320neo)
    INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
        ('LN-WIH', 'Oslo', 1994, '383', 'WF', 'Airbus Group', 'Airbus A320neo'),
        ('LN-WIA', 'Nordland', 1993, '359', 'WF', 'Airbus Group', 'Airbus A320neo'),
        ('LN-WIL', 'Narvik', 1995, '298', 'WF', 'Airbus Group', 'Airbus A320neo');

    -- Til slutt Nasjonalitet
    INSERT INTO Nasjonalitet (produsentNavn, nasjonalitet) VALUES 
        ('The Boeing Company', 'USA'),
        ('Airbus Group', 'Frankrike'),
        ('Airbus Group', 'Tyskland'),
        ('Airbus Group', 'Spania'),
        ('Airbus Group', 'Storbritannia'),
        ('De Havilland Canada', 'Canada');
    """
    cursor.executescript(sql_script)
    print("Data for tilfelle2 har blitt lagt til i databasen.")




def tilfelle3(cursor):
    sql_script = """
    -- First, insert airport pairs into RuteTil table.  !!!!!!!!!! MÅ DETTE
    INSERT INTO RuteTil (fraFlyplassKode, tilFlyplassKode) VALUES
        ('TRD', 'BOO'),
        ('BOO', 'TRD'),
        ('TRD', 'OSL'),
        ('OSL', 'TRD'),
        ('TRD', 'BGO'),
        ('BGO', 'SVG');

    -- Now proceed with the original script
    -- Legg til flyruter med korrekt flyselskapID
    INSERT INTO Flyrute (flyRuteNr, ukedagsKode, oppstartsDato, startFlyplassKode, endeFlyplassKode, opereresAvFlySelskap, bruktFlyType)
    VALUES 
    ("WF1311", '12345', '2018-01-01', 'TRD', 'BOO', 'WF', 'Dash-8 100'),  -- WF1311 TRD-BOO
    ("WF1302", '12345', '2018-01-01', 'BOO', 'TRD', 'WF', 'Dash-8 100'),  -- WF1302 BOO-TRD
    ("DY753", '1234567', '2018-01-01', 'TRD', 'OSL', 'DY', 'Boeing 737 800'),  -- DY753 TRD-OSL
    ("SK332", '1234567', '2018-01-01', 'OSL', 'TRD', 'SK', 'Airbus A320neo'),  -- SK332 OSL-TRD
    ("SK888", '12345', '2018-01-01', 'TRD', 'SVG', 'SK', 'Airbus A320neo');  -- SK888 TRD-SVG via BGO

    -- Legg til delreiser
    INSERT INTO Delreise (flyRuteNr, delreiseNr, avgangstid, ankomsttid, delStartFlyplassKode, delSluttFlyplassKode)
    VALUES 
    ("WF1311", 1, '15:15', '16:20', 'TRD', 'BOO'),  -- WF1311 TRD-BOO
    ("WF1302", 1, '07:35', '08:40', 'BOO', 'TRD'),  -- WF1302 BOO-TRD
    ("DY753", 1, '10:20', '11:15', 'TRD', 'OSL'),  -- DY753 TRD-OSL
    ("SK332", 1, '08:00', '09:05', 'OSL', 'TRD'),  -- SK332 OSL-TRD
    ("SK888", 1, '10:00', '11:10', 'TRD', 'BGO'),  -- SK888 TRD-BGO
    ("SK888", 2, '11:40', '12:10', 'BGO', 'SVG');  -- SK888 BGO-SVG

    -- Legg til prislister (knyttet til delreise)
    INSERT INTO Prisliste (priskategori, pris, gyldigfraDato, flyRuteNr, delreiseNr)
    VALUES 
        ('okonomi', 2018.00, '2025-01-01', "WF1311", 1),  -- TRD-BGO
        ('premium', 899.00, '2025-01-01', "WF1311", 1),
        ('budsjett', 599.00, '2025-01-01', "WF1311", 1),

        ('okonomi', 2018.00, '2025-01-01', "WF1302", 1),  -- BGO-SVG
        ('premium', 899.00, '2025-01-01', "WF1302", 1),
        ('budsjett', 599.00, '2025-01-01', "WF1302", 1),

        ('okonomi', 1500.00, '2025-01-01', "DY753", 1),  
        ('premium', 1000.00, '2025-01-01', "DY753", 1),
        ('budsjett', 500.00, '2025-01-01', "DY753", 1),

        ('okonomi', 1500.00, '2025-01-01', "SK332", 1),
        ('premium', 1000.00, '2025-01-01', "SK332", 1),
        ('budsjett', 500.00, '2025-01-01', "SK332", 1),

        ('okonomi', 2200.00, '2025-01-01', "SK888", NULL),  -- Disse går til flyrute og ikke delreise 
        ('premium', 1700.00, '2025-01-01', "SK888", NULL),
        ('budsjett', 1000.00, '2025-01-01', "SK888", NULL),

        ('okonomi', 2000.00, '2025-01-01', "SK888", 1),  
        ('premium', 1500.00, '2025-01-01', "SK888", 1),
        ('budsjett', 800.00, '2025-01-01', "SK888", 1),

        ('okonomi', 1000.00, '2025-01-01', "SK888", 2),  
        ('premium', 700.00, '2025-01-01', "SK888", 2),
        ('budsjett', 350.00, '2025-01-01', "SK888", 2);
    """
    cursor.executescript(sql_script)
    print("Data for tilfelle3 har blitt lagt til i databasen.")


#Løpenr skal være 1 for alle flyvninger?? Burde det ikke være unike?
def tilfelle4(cursor):
    sql_script = """
    -- Insert flights for Tuesday, April 1, 2025
    INSERT INTO FaktiskFlyvning (flyrutenummer, lopenr, dato, flyStatus, bruktFly) 
    VALUES 
        ('WF1302', 1, '2025-04-01', 'planned', 'LN-WIA'),  -- BOO-TRD
        ('DY753', 2, '2025-04-01', 'planned', 'LN-ENU'),   -- TRD-OSL
        ('SK888', 3, '2025-04-01', 'planned', 'SE-RUB');   -- TRD-BGO-SVG

    -- Insert flight segments with correct datetime format
    INSERT INTO FlyvningSegment (flyrutenummer, lopenr, flyvningsegmentnr, faktiskAvgangTid, faktiskAnkomstTid, delreiseNr)
    VALUES
        ('WF1302', 1, 1, '2025-04-01 07:35:00', '2025-04-01 08:40:00', 1),  -- WF1302 BOO-TRD
        ('DY753', 2, 1, '2025-04-01 10:20:00', '2025-04-01 11:15:00', 1),    -- DY753 TRD-OSL
        ('SK888', 3, 1, '2025-04-01 10:00:00', '2025-04-01 11:10:00', 1),    -- SK888 TRD-BGO
        ('SK888', 3, 2, '2025-04-01 11:40:00', '2025-04-01 12:10:00', 2);    -- SK888 BGO-SVG
    """
    cursor.executescript(sql_script)
    print("Data for tilfelle4 har blitt lagt til i databasen (flygninger for 1. april 2025).")



def tilfelle5(cursor):
    sql_query = """
    SELECT
        f.navn AS flyselskap,
        IFNULL(ft.flytypeNavn, 'Ingen registrert flytype') AS flytype,
        COUNT(fly.regnr) AS antall_fly
    FROM Flyselskap f
    LEFT JOIN Fly fly ON f.flyselskapID = fly.tilhorerSelskapID
    LEFT JOIN Flytype ft ON fly.erType = ft.flytypeNavn
    GROUP BY f.navn, ft.flytypeNavn
    ORDER BY f.navn ASC, antall_fly DESC;
    """
    cursor.execute(sql_query)
    print("Data for tilfelle5 hentes fra databasen (flyselskap flytype oversikt).")
    
    # Fetch all results
    results = cursor.fetchall()
    
    # Print header
    print("\n--- Flyselskap Flytype Oversikt ---")
    print("{:<20} {:<25} {:<10}".format("Flyselskap", "Flytype", "Antall Fly"))
    print("-" * 55)
    
    # Print results
    for row in results:
        print("{:<20} {:<25} {:<10}".format(row[0], row[1], row[2]))
    
    print("\nData for tilfelle5 har blitt hentet fra databasen (flyselskap flytype oversikt).")




def tilfelle7(cursor):
    #Gjorde denne mer generell, slik at den kan kjøres flere ganger uten å få feil
    #samt mer detaljert siden det er en del ting som må sjekkes før insert. Fikk feil mange ganger pga dette.

    # sjekker om det er noen seter for Dash-8 100 
    cursor.execute("SELECT COUNT(*) FROM Sete WHERE flyTypeNavn = 'Dash-8 100'")
    seat_count = cursor.fetchone()[0]
    
    if seat_count == 0:
        print("Warning: No seats found for Dash-8 100. Make sure seats are generated before running this function.")
        return
    
    # Sjekker om flyvningsegmentet eksisterer
    cursor.execute("SELECT COUNT(*) FROM FlyvningSegment WHERE flyrutenummer = 'WF1302' AND lopenr = 1 AND flyvningsegmentnr = 1")
    segment_count = cursor.fetchone()[0]
    
    if segment_count == 0:
        print("Error: The specified flight segment doesn't exist. Check that WF1302 flight is properly set up.")
        return
    
    # Sjekke pris for WF1302 economy class
    cursor.execute("SELECT prisID FROM Prisliste WHERE flyRuteNr = 'WF1302' AND delreiseNr = 1 AND priskategori = 'okonomi' LIMIT 1")
    price_result = cursor.fetchone()
    
    if not price_result:
        print("Error: No price found for WF1302 economy class. Check the Prisliste table.")
        return
    
    price_id = price_result[0]
    
    # Insertion
    sql_script = f"""
    -- First check if the customer already exists to avoid duplicates
    INSERT OR IGNORE INTO Kunde (kundeNr, telefonNr, epost, navn, nasjonalitet)
    VALUES (5252, '94115890', 'ola.nordmann@example.com', 'Ola Nordmann', 'Norsk');

    -- Insert ten ticket purchases in the BillettKjop table
    INSERT INTO BillettKjop (referanseNr, innsjekkTid, erTurRetur, kjoptAvKundeNr)
    VALUES
        (1001, NULL, 0, 5252),
        (1002, NULL, 0, 5252),
        (1003, NULL, 0, 5252),
        (1004, NULL, 0, 5252),
        (1005, NULL, 0, 5252),
        (1006, NULL, 0, 5252),
        (1007, NULL, 0, 5252),
        (1008, NULL, 0, 5252),
        (1009, NULL, 0, 5252),
        (1010, NULL, 0, 5252);
    """
    
    try:
        cursor.executescript(sql_script)
        
        # ledige seter for Dash-8 100 så vi ikke tar noen oppdatte seter
        cursor.execute("""
        SELECT flyTypeNavn, radNr, seteBokstav 
        FROM Sete 
        WHERE flyTypeNavn = 'Dash-8 100' 
        ORDER BY radNr, seteBokstav 
        LIMIT 10
        """)
        
        available_seats = cursor.fetchall()
  
        if len(available_seats) < 10:
            print(f"Warning: Only {len(available_seats)} seats available, but 10 needed.")
            
        # Legge inn en og en ticket i DelBillett (mulig å sette inn alle på en gang også. se brukstilfelle7.sql kommentar på bunn)
        for i, (ref_nr, seat) in enumerate(zip(range(1001, 1011), available_seats), start=1):
            billettID = 0000 + i
            flyTypeNavn, radNr, seteBokstav = seat
            
            cursor.execute("""
            INSERT INTO DelBillett 
            (billettID, delPris, delAvBilletKjop, BooketflyTypeNavn, BooketradNr, Booketsetebokstav, Flyrutenummer, lopenr, flyvningsegmentnr, prisID)
            VALUES
            (?, 2018.00, ?, ?, ?, ?, 'WF1302', 1, 1, ?)
            """, (billettID, ref_nr, flyTypeNavn, radNr, seteBokstav, price_id))
            
        print("Data for tilfelle7 har blitt lagt til i databasen (10 billettbestillinger for WF1302 den 1. april 2025).")
        
    except sqlite3.Error as e:
        print(f"Database error: {e}")
        # Rollback in case of error
        cursor.execute("ROLLBACK")


def tilfelle8(cursor):
    #IMPLEMENTER DENNE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    return None