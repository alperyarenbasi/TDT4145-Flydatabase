import sqlite3
conn = sqlite3.connect("Flydatabase.db")
cur = conn.cursor()
#conn.autocommit = True

def run_sql_script(filename, cursor, connection):
    """ Leser og kjører et SQL-script fra en fil. """
    with open(filename, "r") as file:
        sql_script = file.read()
    
    cursor.executescript(sql_script)
    connection.commit()
    print(f"SQL-scriptet '{filename}' er kjørt, og databasen er opprettet/oppdatert.")

# Kjør begge SQL-skriptene
run_sql_script("Flydatabase.sql", cur, conn)
run_sql_script("brukstilfelle1.sql", cur, conn) # --Brukstilfelle 1--
run_sql_script("brukstilfelle2.sql", cur, conn) # --Brukstilfelle 2--

#Ekstra logikk for å  sørge for at seter blir lagt til riktig 
#Vi har valgt å gjøre dette manuelt så vi ikke trenger å skrive ut alle setene manuelt 
def insert_seat(flyTypeNavn, radNr, seteBokstav, nodutgang):
    """Setter inn et sete i Sete-tabellen"""
    cur.execute("""
        INSERT INTO Sete (flyTypeNavn, radNr, seteBokstav, nodutgang)
        VALUES (?, ?, ?, ?)
    """, (flyTypeNavn, radNr, seteBokstav, nodutgang))

def generate_seats():
    """Genererer og setter inn seter for ulike flytyper"""
    
    # Boeing 737-800
    for rad in range(1, 32):  # Rader 1 til 31
        for sete in "ABCDEF":
            nodutgang = (rad == 13)  # Rad 13 er nødutgang
            insert_seat("Boeing 737-800", rad, sete, nodutgang)

    # Airbus A320neo
    for rad in range(1, 31):  # Rader 1 til 30
        for sete in "ABCDEF":
            nodutgang = (rad in [11, 12])  # Rader 11 og 12 er nødutganger
            insert_seat("Airbus A320neo", rad, sete, nodutgang)

    # Dash-8 100
    insert_seat("Dash-8 100", 1, "C", False)
    insert_seat("Dash-8 100", 1, "D", False)
    
    for rad in range(2, 11):  # Rader 2 til 10
        for sete in "ABCD":
            nodutgang = (rad == 5)  # Rad 5 er nødutgang
            insert_seat("Dash-8 100", rad, sete, nodutgang)

# Generer og sett inn seter
generate_seats()


run_sql_script("brukstilfelle3.sql", cur, conn)

# Hent og skriv ut informasjon fra brukstilfelle 1
print("\n🔹 Innhold fra brukstilfelle 1-tabellen:")
cur.execute("SELECT * FROM Prisliste")  
rows = cur.fetchall()

for row in rows:
    print(row)






#Lukker databasen
conn.close()
