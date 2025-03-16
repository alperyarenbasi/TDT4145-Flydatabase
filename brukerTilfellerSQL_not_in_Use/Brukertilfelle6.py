import sqlite3

def hent_flyruter(flyplasskode, ukedag, type_rute):
    # Koble til databasen
    conn = sqlite3.connect("Brukertilfelle6.sql")  # Tilpass databasenavn
    cursor = conn.cursor()

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

    cursor.execute(query, (flyplasskode, ukedag))
    resultater = cursor.fetchall()

    if resultater:
        print(f"\n{type_rute.capitalize()} for {flyplasskode} på ukedag {ukedag}:")
        for rad in resultater:
            print(f"Flyrutenr: {rad[0]}, Fra: {rad[1]}, Til: {rad[2]}")
    else:
        print(f"Ingen {type_rute.lower()} funnet for {flyplasskode} på ukedag {ukedag}.")

    conn.close()
