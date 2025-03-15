import sqlite3
conn = sqlite3.connect("Flydatabase.sql")
conn = sqlite3.connect("Brukertilfelle6.sql")
cur = conn.cursor()


def run_sql_script(filename, cursor, connection,):
    """ Leser og kjører et SQL-script fra en fil. """
    with open(filename, "r") as file:
        sql_script = file.read()
    
    cursor.executescript(sql_script)
    connection.commit()
    print(f"SQL-scriptet '{filename}' er kjørt, og databasen er opprettet/oppdatert.")

run_sql_script("Flydatabase.sql", cur, conn)
run_sql_script("Brukertilfelle6.sql", cur, conn)

def hent_flyruter(flyplasskode, ukedag, type_rute):
    if type_rute.lower() == "avganger":
        query = """
        SELECT flyRuteNr, startFlyplassKode, endeFlyplassKode
        FROM Flyrute
        WHERE startFlyplassKode = ? 
        AND instr(ukedagsKode, ?) > 0;
        """
    elif type_rute.lower() == "ankomster":
        query = """
        SELECT flyRuteNr, startFlyplassKode, endeFlyplassKode
        FROM Flyrute
        WHERE endeFlyplassKode = ? 
        AND instr(ukedagsKode, ?) > 0;
        """
    else:
        print("Ugyldig valg. Velg enten 'avganger' eller 'ankomster'.")
        return

    cur.execute(query, (flyplasskode, ukedag))
    resultater = cur.fetchall()

    if resultater:
        print(f"\n{type_rute.capitalize()} for {flyplasskode} på ukedag {ukedag}:")
        for rad in resultater:
            print(f"Flyrutenr: {rad[0]}, Fra: {rad[1]}, Til: {rad[2]}")
    else:
        print(f"Ingen {type_rute.lower()} funnet for {flyplasskode} på ukedag {ukedag}.")

conn.close()
