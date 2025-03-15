import sqlite3



#-----------------TASK 8 ?----------------------#
"""Henter planlagte flyvninger for en spesifikk dato."""
def get_available_flights(cursor, date_str):
    """Henter planlagte flyvninger for en spesifikk dato"""
    try:
        # Validerer at datoen er i riktig format (YYYY-MM-DD)
        datetime.strptime(date_str, '%Y-%m-%d') #Skal forhindre SQL injections 
    except ValueError:
        print("Ugyldig datoformat. Bruk YYYY-MM-DD.")
        return []

    cursor.execute("""
        SELECT * FROM FaktiskFlyvning 
        WHERE flystatus = 'planned' AND dato = ?
    """, (date_str,))
    return cursor.fetchall()

# Eksempel på bruk:
# user_date = input("Angi dato (YYYY-MM-DD): ")
# available_flights = get_available_flights(cur, user_date)
# if available_flights:
#     for flight in available_flights:
#         print(flight)
# else:
#     print("Ingen planlagte flyvninger funnet for denne datoen.")



def choose_flight(flights):
    """Lar brukeren velge en flyvning fra en liste"""
    if not flights:
        print("Ingen flyvninger tilgjengelig.")
        return None

    print("Velg en flyvning fra listen:")
    for i, flight in enumerate(flights, start=1):
        print(f"{i}: {flight}")
    
    try:
        choice = int(input("Skriv nummeret på flyvningen du vil velge: "))
        if 1 <= choice <= len(flights):
            return flights[choice - 1]
        else:
            print("Ugyldig valg.")
            return None
    except ValueError:
        print("Ugyldig input. Vennligst skriv et tall.")
        return None

def get_available_seats(cursor, flyrutenummer, lopenr):
    """Henter tilgjengelige seter for en bestemt flyvning"""
    cursor.execute("""
        SELECT s.flyTypeNavn, s.radNr, s.seteBokstav
        FROM Sete s
        WHERE NOT EXISTS (
            SELECT 1
            FROM DelBillett db
            WHERE db.BooketflyTypeNavn = s.flyTypeNavn
              AND db.BooketradNr = s.radNr
              AND db.Booketsetebokstav = s.seteBokstav
              AND db.Flyrutenummer = ? AND db.lopenr = ?
        )
    """, (flyrutenummer, lopenr))
    return cursor.fetchall()



#---------------------------------------#
"""Skriver ut innholdet i en spesifikk tabell.

    Args:
        cursor: En peker til databasen.
        tabellnavn: Navnet på tabellen som skal skrives ut."""
def printTabell(cursor, tabellnavn):
    """Skriver ut innholdet i en spesifikk tabell."""
    try:
        cursor.execute(f"SELECT * FROM {tabellnavn};")
        rows = cursor.fetchall()
        if not rows:
            print(f"Tabellen '{tabellnavn}' er tom.")
            return

        # Hent kolonnenavn
        col_names = [desc[0] for desc in cursor.description]

        # Formater utskrift
        print(f"\nInnhold i tabellen '{tabellnavn}':")
        print("-" * (len(tabellnavn) + 20))
        print("\t".join(col_names))
        print("-" * (len(tabellnavn) + 20))
        for row in rows:
            print("\t".join(str(value) for value in row))
        print("-" * (len(tabellnavn) + 20))
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




#---------------------------------------#
def insert_seat(cursor, flyTypeNavn, radNr, seteBokstav, nodutgang):
    """Setter inn et sete i Sete-tabellen"""
    cursor.execute("""
        INSERT INTO Sete (flyTypeNavn, radNr, seteBokstav, nodutgang)
        VALUES (?, ?, ?, ?)
    """, (flyTypeNavn, radNr, seteBokstav, nodutgang))

def generate_seats(cursor):
    """Genererer og setter inn seter for ulike flytyper"""
    
    # Boeing 737 800 (note the space instead of hyphen)
    for rad in range(1, 32):  # Rader 1 til 31
        for sete in "ABCDEF":
            nodutgang = (rad == 13)  # Rad 13 er nødutgang
            insert_seat(cursor, "Boeing 737 800", rad, sete, nodutgang)

    # Airbus a320neo (lowercase 'a')
    for rad in range(1, 31):  # Rader 1 til 30
        for sete in "ABCDEF":
            nodutgang = (rad in [11, 12])  # Rader 11 og 12 er nødutganger
            insert_seat(cursor, "Airbus a320neo", rad, sete, nodutgang)

    # Dash-8 100
    insert_seat(cursor, "Dash-8 100", 1, "C", False)
    insert_seat(cursor, "Dash-8 100", 1, "D", False)
    
    for rad in range(2, 11):  # Rader 2 til 10
        for sete in "ABCD":
            nodutgang = (rad == 5)  # Rad 5 er nødutgang
            insert_seat(cursor, "Dash-8 100", rad, sete, nodutgang)