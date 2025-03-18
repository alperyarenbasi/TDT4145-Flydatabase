"""
KJØR DENNE!!!
"""

import sqlite3
import BrukerTilfeller as bt
import ExtraFunctions as ef
import os #For å sjekke om filen eksisterer

#Filenavn for SQLite-databasen
databaseFile = "Flydatabase.db"
 
#Sjekker om databasen allerede eksisterer, og oppretter den hvis den ikke gjør det
conn = sqlite3.connect(databaseFile)
cur = conn.cursor()
ef.run_sql_script("Flydatabase.sql", cur, conn)

""""
if not os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()
    ef.run_sql_script("Flydatabase.sql", cur, conn)
else:
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()
"""

cur.execute("PRAGMA foreign_keys = ON;") #Slår på foreign keys


try:
    bt.tilfelle1(cur)
    bt.tilfelle2(cur)
    ef.generate_seats(cur)
    bt.tilfelle3(cur)
    bt.tilfelle4(cur)
    bt.tilfelle5(cur)
    ef.tilfelle6main(cur)
    # TILFELLE 5 ER SQL SPØRRING. LEGGER IKKE DATA INN. DERMED IKKE MENINGEN Å KJØRE HER
    # TILFELLE 6 ER LEGGER IKKE INN DATA. DERMED IKKE MENINGEN Å KJØRE HER
    bt.tilfelle7(cur)
                 
    #bt.tilfelle7(cur)
    # opg 8 er gjort tror jeg. Tror den er i BrukerTilfeller.py
    conn.commit()           #Lagrer endringene. må gjøres for at endringene skal bli permanente

except sqlite3.Error as e:
    print(f"Feil: {e}")
    print("Det er noe feil i en av brukerhistoriene.")


conn.close()
