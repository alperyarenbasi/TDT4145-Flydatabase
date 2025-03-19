"""
KJØR DENNE!!!
For å kjøre brukertilfelle 6, skriv inn 6
For å kjøre brukertilfelle 8, skriv inn 8
For å kjøre brukeertilfelle 5, skriv inn 5 
For å se tabellene fra brukertilfelle 1,2,3,4,7, skriv inn print for å se dataen 
"""

import sqlite3
import BrukerTilfeller as bt
import ExtraFunctions as ef

def initializeDB(cur, conn):
    try:
        bt.tilfelle1(cur)
        bt.tilfelle2(cur)
        ef.generate_seats(cur)
        bt.tilfelle3(cur)
        bt.tilfelle4(cur)
        bt.tilfelle7(cur)
        conn.commit()           
    except sqlite3.Error as e:
        print(f"Feil: {e}")
        print("Det er noe feil i en av brukerhistoriene.")


def main():
    #Filenavn for SQLite-databasen
    databaseFile = "Flydatabase.db"
    
    #Sjekker om databasen allerede eksisterer, og oppretter den hvis den ikke gjør det
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()
    ef.run_sql_script("Flydatabase.sql", cur, conn)
    cur.execute("PRAGMA foreign_keys = ON;") #Slår på foreign keys
    initializeDB(cur, conn)
    print("\n\n\nDatabase initialisert. Data fra brukerhistoriene 1,2,3,4,7 er lagt inn og er klart til bruk")
    while True:
        # Viser en informativ meny for brukeren
        print("\nVelg en handling:")
        print("5: Kjør brukerhistorie 5")
        print("6: Kjør brukerhistorie 6")
        print("8: Kjør brukerhistorie 8")
        print("print: Print alle data")
        print("q: Avslutt programmet")
        
        valg = input("Ditt valg: ").strip().lower()  # Fjerner whitespace og gjør case-insensitive
        
        # Sjekker brukerens valg og utfører handling
        if valg == "5":
            bt.tilfelle5(cur)
        elif valg == "6":
            ef.tilfelle6main(cur)
        elif valg == "8":
            ef.tilfelle8main(cur)
        elif valg == "print":
            ef.printAllTables(cur)
        elif valg == "q":
            # Bekreftelse for å unngå utilsiktet avslutning
            bekreft = input("Er du sikker på at du vil avslutte? (j/n): ").strip().lower()
            if bekreft == "j":
                break
        else:
            print("Ugyldig valg. Vennligst prøv igjen.")

    conn.close()  # Lukker database-tilkoblingen etter løkken
    

main()
