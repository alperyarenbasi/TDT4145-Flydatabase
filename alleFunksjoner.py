

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
user_date = input("Angi dato (YYYY-MM-DD): ")
available_flights = get_available_flights(cur, user_date)
if available_flights:
    for flight in available_flights:
        print(flight)
else:
    print("Ingen planlagte flyvninger funnet for denne datoen.")



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

