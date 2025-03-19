import sqlite3
from datetime import datetime

"""
Denne filen inneholder alle ekstra funksjoner som tilhører ulike brukertillfeller.
"""


#Funksjonalitet for å sette inn seter i Sete-tabellen. Tilhøre
#Setelogikk fra vedlegg 2, grunnen til at denne er imeplementer som en for loop er at hvert sete behandles som egen entitet i databasen.
#Hjelpemetode for å sette inn seter i Sete-tabellen
def insert_seat(cursor, flyTypeNavn, radNr, seteBokstav, nodutgang):
    """Setter inn et sete i Sete-tabellen"""
    cursor.execute("""
        INSERT INTO Sete (flyTypeNavn, radNr, seteBokstav, nodutgang)
        VALUES (?, ?, ?, ?)
    """, (flyTypeNavn, radNr, seteBokstav, nodutgang))

#Hovedmetode for å generere seter for ulike flytyper
def generate_seats(cursor):
    """Genererer og setter inn seter for ulike flytyper"""
    
    # Boeing 737 800 (note the space instead of hyphen)
    for rad in range(1, 32):  # Rader 1 til 31
        for sete in "ABCDEF":
            nodutgang = (rad == 13)  # Rad 13 er nødutgang
            insert_seat(cursor, "Boeing 737 800", rad, sete, nodutgang)

    # Airbus A320neo (lowercase 'a')
    for rad in range(1, 31):  # Rader 1 til 30
        for sete in "ABCDEF":
            nodutgang = (rad in [11, 12])  # Rader 11 og 12 er nødutganger
            insert_seat(cursor, "Airbus A320neo", rad, sete, nodutgang)

    # Dash-8 100
    insert_seat(cursor, "Dash-8 100", 1, "C", False)
    insert_seat(cursor, "Dash-8 100", 1, "D", False)
    
    for rad in range(2, 11):  # Rader 2 til 10
        for sete in "ABCD":
            nodutgang = (rad == 5)  # Rad 5 er nødutgang
            insert_seat(cursor, "Dash-8 100", rad, sete, nodutgang)

def hent_flyplasser(cursor):
    cursor.execute("SELECT flyPlassKode, flyPlassNavn FROM Flyplass")
    return {row[0]: row[1] for row in cursor.fetchall()}  # Returnerer en dictionary med kode som nøkkel og navn som verdi

def vis_flyplasser(airports):
    """Viser en liste med tilgjengelige flyplasser og lar brukeren velge basert på flyplasskode."""
    print("Tilgjengelige flyplasser:")
    for code, name in airports.items():
        print(f"{code}: {name}")
    
    while True:
        valgt_kode = input("Velg en flyplass ved å skrive inn flyplasskoden eller skriv m for å gå tilbake til hovedmenyen: ").strip().upper()
        if valgt_kode in airports:
            print(f"Du har valgt {airports[valgt_kode]} ({valgt_kode})")
            return valgt_kode
        elif valgt_kode == "M":
            return None
        else:
            print("Ugyldig kode, prøv igjen.")

# Legg til en funksjon for å konvertere ukedag til nummer (Hjelpefunksjon for tilfelle 6)
def ukedag_til_nummer():
    """Lar brukeren skrive inn en ukedag og returnerer tilsvarende nummer. Brukeren kan skrive m for å gå tilbake til hovedmenyen"""
    ukedager = {
        "mandag": 1, "tirsdag": 2, "onsdag": 3, "torsdag": 4,
        "fredag": 5, "lørdag": 6, "søndag": 7
    }
    
    while True:
        ukedag = input("Skriv inn en ukedag (f.eks. 'mandag') eller M for å gå tilbake til hovedmenyen:").strip().lower()
        if ukedag in ukedager:
            return ukedager[ukedag]
        elif ukedag == "m":
            return None
        else:
            print("Ugyldig input. Skriv en gyldig ukedag (f.eks. 'mandag') eller M for å gå tilbake til hovedmenyen")



def tilfelle6main(cur):
    """
    Hovedfunksjon for tilfelle 6 som lar brukeren velge en flyplass, ukedag og 
    om de er interessert i avganger eller ankomster.
    """
    # Hent og vis tilgjengelige flyplasser
    flyplasser = hent_flyplasser(cur)
    valgt_flyplass = vis_flyplasser(flyplasser)
    if valgt_flyplass is None:
        return
    
    ukedag_nummer = ukedag_til_nummer()
    if ukedag_nummer is None:
        return
    
    while True: 
        interesse = input("Er du interessert i 'avganger' eller 'ankomster'? ").strip().lower()
        if interesse in ["avganger", "ankomster"]:
            break   
        else:
            print("Ugyldig input. Skriv 'avganger' eller 'ankomster'.")
    
    if ukedag_nummer is None:
        print("Ugyldig ukedag.")
        return
    

    """
    Vi har valgt å tolke oppgaveteksten slik at dersom vi har ruten TRD -> BGO -> SVG. Skal vi vil si søker opp BGO og avgang vise hele ruten. Dette er det vi syntes ga mest mening 

    """
    if interesse == "avganger":
        sql = """
            SELECT 
                dr.flyRuteNr, 
                MIN(dr.avgangstid) AS Avgangstid, --Grunnen til at vi bruker MIN og MAX er at vi har flere avganger og ankomster for samme flyrute 
                MAX(dr.ankomsttid) AS Ankomsttid,
                (
                    SELECT GROUP_CONCAT(fp.flyPlassKode, ' -> ') --Concatenation av flyplasskoder med ' -> ' som separator
                    FROM (
                        SELECT DISTINCT flyplassKode --Vi hadde et problem med at mellomlandinger er både ankomst og avgang. Derfor bruker vi DISTINCT for å unngå duplikater
                        FROM (
                            SELECT dr1.delStartFlyplassKode AS flyplassKode, dr1.avgangstid AS tid
                            FROM Delreise dr1
                            WHERE dr1.flyRuteNr = dr.flyRuteNr
                            
                            UNION ALL --Vi bruker Union for å finne både delStart og delSlutt flyplasser 
                            
                            SELECT dr2.delSluttFlyplassKode AS flyplassKode, dr2.ankomsttid AS tid
                            FROM Delreise dr2
                            WHERE dr2.flyRuteNr = dr.flyRuteNr
                        ) AS flyplass_stopp
                        ORDER BY tid
                    ) AS unique_stops
                    INNER JOIN Flyplass fp ON fp.flyPlassKode = unique_stops.flyplassKode
                ) AS stopp
            FROM Delreise AS dr
            INNER JOIN Flyrute fr ON dr.flyRuteNr = fr.flyRuteNr
            WHERE EXISTS ( 
                SELECT 1
                FROM Delreise dr_check
                WHERE dr_check.flyRuteNr = dr.flyRuteNr
                AND dr_check.delStartFlyplassKode = ? -- Her legger vi til parametert delStartFlyplassKode i neste spørring bruker vi endeFlyplass
            )
            AND INSTR(fr.ukedagsKode, ?) > 0 --Legger til ukedag parameter
            GROUP BY dr.flyRuteNr;
        """
    else:  # ankomster
        #Dette er i nesten det samme som forrige bare at vi sjekker for endeflyplass og ikke startflyplass. 
        sql = """
            SELECT 
                dr.flyRuteNr, 
                MIN(dr.avgangstid) AS Avgangstid, 
                MAX(dr.ankomsttid) AS Ankomsttid,
                (
                    SELECT GROUP_CONCAT(fp.flyPlassKode, ' -> ')
                    FROM (
                        SELECT DISTINCT flyplassKode
                        FROM (
                            SELECT dr1.delStartFlyplassKode AS flyplassKode, dr1.avgangstid AS tid
                            FROM Delreise dr1
                            WHERE dr1.flyRuteNr = dr.flyRuteNr
                            UNION ALL
                            SELECT dr2.delSluttFlyplassKode AS flyplassKode, dr2.ankomsttid AS tid
                            FROM Delreise dr2
                            WHERE dr2.flyRuteNr = dr.flyRuteNr
                        ) AS flyplass_stopp
                        ORDER BY tid
                    ) AS unique_stops
                    INNER JOIN Flyplass fp ON fp.flyPlassKode = unique_stops.flyplassKode
                ) AS stopp
            FROM Delreise AS dr
            INNER JOIN Flyrute fr ON dr.flyRuteNr = fr.flyRuteNr
            WHERE EXISTS (
                SELECT 1
                FROM Delreise dr_check
                WHERE dr_check.flyRuteNr = dr.flyRuteNr
                AND dr_check.delSluttFlyplassKode = ?
            )
            AND INSTR(fr.ukedagsKode, ?) > 0
            GROUP BY dr.flyRuteNr;
        """
    # Utfør spørringen med parameterinnsetting
    cur.execute(sql, (valgt_flyplass, str(ukedag_nummer)))
    resultater = cur.fetchall()

    # Sjekk om det finnes data
    if not resultater:
        print("Ingen treff for valgene dine.")
        return

    print("\nResultater:\n")
    print(f"{'Flynr':<10} {'Avgang':<10} {'Ankomst':<10} {'Stopp':<30}")
    print("-" * 70)

    for row in resultater:
        flynr, avgang, ankomst, stopp = row
        print(f"{flynr:<10} {avgang:<10} {ankomst:<10} {stopp:<30}")

    

#Brukstilfelle 8 
def get_available_flights(cursor):
    """Henter planlagte flyvninger for en spesifikk dato."""

    #Denne SQL delen kan droppes når databasen er større / man er sikker på at det får fly hver dag 
    cursor.execute("""
        SELECT Flyrute.flyRuteNr, FaktiskFlyvning.dato, Flyrute.startFlyplassKode, Flyrute.endeFlyplassKode, FaktiskFlyvning.bruktFly
        FROM FaktiskFlyvning INNER JOIN Flyrute ON FaktiskFlyvning.flyrutenummer = Flyrute.flyRuteNr 
        WHERE flystatus = 'planned'
        """)
    print("Følgende flyvninger eksisterer tilgjengelige for booking. Velg en dato hvor en av disse flyene går:")
    flights = cursor.fetchall()
    for i, flight in enumerate(flights, start=1):
        print(f"{i}: Flyrute {flight[0]}, Dato {flight[1]}, Fra: {flight[2]}, Til: {flight[3]}, Brukt Fly: {flight[4]}")

    while True:
        date_str = input("Oppgi dato (YYYY-MM-DD) eller 'quit' for å avslutte: ").strip()
        if date_str.lower() == 'quit':
            print("Avslutter...")
            return []

        try:
            datetime.strptime(date_str, '%Y-%m-%d')
            break
        except ValueError:
            print("Ugyldig datoformat. Bruk YYYY-MM-DD eller 'quit' for å avslutte.")


    cursor.execute("""
        SELECT Flyrute.flyRuteNr, FaktiskFlyvning.dato, Flyrute.startFlyplassKode, Flyrute.endeFlyplassKode, FaktiskFlyvning.bruktFly
        FROM FaktiskFlyvning INNER JOIN Flyrute ON FaktiskFlyvning.flyrutenummer = Flyrute.flyRuteNr 
        WHERE flystatus = 'planned' AND dato = ?
    """, (date_str,))

    flights = cursor.fetchall()
    return flights

def choose_flight(flights):
    """Lar brukeren velge en flyvning fra en liste."""
    print("\nVelg en flyvning fra listen:")
    for i, flight in enumerate(flights, start=1):
        print(f"{i}: Flyrute {flight[0]}, Dato {flight[1]}, Fra: {flight[2]}, Til: {flight[3]}, Brukt Fly: {flight[4]}")

    while True:
        try:
            choice = int(input("Skriv nummeret på flyvningen du vil velge: "))
            if 1 <= choice <= len(flights):
                return flights[choice - 1]  # Returnerer valgt flyvning
            else:
                print("Ugyldig valg. Velg et nummer fra listen.")
        except ValueError:
            print("Ugyldig input. Vennligst skriv et tall.")

def finn_ledige_seter(cur, flyRuteNr, dato):
    query = """
    SELECT 
        dr.delreiseNr, 
        s.flyTypeNavn, 
        s.radNr, 
        s.seteBokstav
    FROM 
        Delreise dr
    INNER JOIN 
        Flyrute fr ON dr.flyRuteNr = fr.flyRuteNr
    INNER JOIN 
        Sete s ON s.flyTypeNavn = fr.bruktFlyType
    LEFT JOIN 
        FlyvningSegment fs ON dr.flyRuteNr = fs.flyrutenummer 
                          AND dr.delreiseNr = fs.flyvningsegmentnr
    LEFT JOIN 
        FaktiskFlyvning ff ON fs.flyrutenummer = ff.flyrutenummer 
                           AND fs.lopenr = ff.lopenr
    LEFT JOIN 
        DelBillett db ON fs.flyrutenummer = db.Flyrutenummer 
                     AND fs.lopenr = db.lopenr 
                     AND fs.flyvningsegmentnr = db.flyvningsegmentnr 
                     AND s.flyTypeNavn = db.BooketflyTypeNavn 
                     AND s.radNr = db.BooketradNr 
                     AND s.seteBokstav = db.Booketsetebokstav
    WHERE 
        fr.flyRuteNr = ? 
        AND ff.dato = ? 
        AND db.billettID IS NULL
    ORDER BY 
        dr.delreiseNr, s.radNr, s.seteBokstav;
    """
    cur.execute(query, (flyRuteNr, dato))
    resultater = cur.fetchall()
    if not resultater:
            print("\nDet er ingen ledige seter på denne flyvningen.\n")
            return
        
    # Print ledige seter, gruppert etter delflyvning
    print("\nLedige seter for flyvning:\n")
    
    forrige_delreise = None
    for sete in resultater:
        delreise_nr, flytype, rad, bokstav = sete
        if delreise_nr != forrige_delreise:
            print(f"\nDelflyvning {delreise_nr}:")
            forrige_delreise = delreise_nr
        print(f"  Flytype: {flytype}, Rad: {rad}, Sete: {bokstav}")
    
    return 



def tilfelle8main(cur):
    """Hovedfunksjonen som samler hele prosessen for å finne og velge en flyvning."""
    print("\n*** FLYRUTE BOOKING SYSTEM ***\n")
    
    flights = get_available_flights(cur)
    if not flights:
        print("Ingen tilgjengelige flyvninger. Avslutter programmet.")
        return  # Avslutter hvis ingen flyvninger finnes

    selected_flight = choose_flight(flights)
    if not selected_flight:
        print("Ingen flyvning valgt. Avslutter programmet.")
        return  # Avslutter hvis ingen flyvning er valgt

    # Henter nødvendige detaljer fra den valgte flyvningen
    flyrutenummer, dato, start, destinasjon, brukt_fly = selected_flight  

    print(f"\nDu har valgt flyrute {flyrutenummer} fra {start} til {destinasjon} den {dato}. Brukt fly: {brukt_fly}\n")

    # Henter ledige seter for valgt flyvning
    #available_seats = get_available_seats(cur, flyrutenummer, flyrutenummer, dato)

    available_seats = finn_ledige_seter(cur, flyrutenummer, dato)

    print("\n*** Slutt på programmet ***\n")



#---------------------------------------#
"""Skriver ut innholdet i en spesifikk tabell.

    Args:
        cursor: En peker til databasen.
        tabellnavn: Navnet på tabellen som skal skrives ut."""
def printTabell(cursor, tabellnavn):
    """Skriver ut innholdet i en spesifikk tabell på en oversiktlig måte."""
    try:
        cursor.execute(f"SELECT * FROM {tabellnavn};")
        rows = cursor.fetchall()
        if not rows:
            print(f"Tabellen '{tabellnavn}' er tom.")
            return

        # Hent kolonnenavn
        col_names = [desc[0] for desc in cursor.description]

        # Finn maksimum bredde for hver kolonne
        col_widths = [len(name) for name in col_names]
        for row in rows:
            for i, value in enumerate(row):
                col_widths[i] = max(col_widths[i], len(str(value)))

        # Formater utskrift
        total_width = sum(col_widths) + len(col_widths) * 3 + 1  # Juster for rammer og mellomrom
        separator = "-" * total_width

        print(f"\nInnhold i tabellen '{tabellnavn}':")
        print(separator)
        
        # Skriv ut overskrifter
        header = "| " + " | ".join(
            name.ljust(col_widths[i]) for i, name in enumerate(col_names)
        ) + " |"
        print(header)
        print(separator)

        # Skriv ut rader
        for row in rows:
            formatted_row = "| " + " | ".join(
                str(value).ljust(col_widths[i]) for i, value in enumerate(row)
            ) + " |"
            print(formatted_row)
        
        print(separator)

    except sqlite3.Error as e:
        print(f"Feil ved henting av tabellen '{tabellnavn}': {e}")




"""Skriver ut innholdet i alle tabeller i databasen. 

    Args:
        cursor: En peker til databasen.
"""
def printAllTables(cursor):
    """Skriver ut alle tabeller i databasen og deres innhold."""
    try:
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = cursor.fetchall()
        if not tables:
            print("Ingen tabeller funnet i databasen.")
            return

        for table in tables:
            table_name = table[0]
            printTabell(cursor, table_name)  # Bruker printTabell til å vise hver tabell
    except sqlite3.Error as e:
        print(f"Feil ved henting av tabeller: {e}")




#---------------------------------------#
"""Leser og kjører et SQL-script fra en fil.

    Args:
        filename: Navnet på SQL-filen som skal kjøres.
        cursor: En peker til databasen.
        connection: En peker til databasetilkoblingen."""

def run_sql_script(filename, cursor, connection):
    """ Leser og kjører et SQL-script fra en fil. """
    with open(filename, "r") as file:
        sql_script = file.read()
    
    cursor.executescript(sql_script)
    connection.commit()
    print(f"SQL-scriptet '{filename}' er kjørt, og databasen er opprettet/oppdatert.")


