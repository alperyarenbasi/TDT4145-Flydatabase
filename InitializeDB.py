"""
Description: just initializes the database and inserts data for the brukertillfeller.
Run BrukstilfelleX.py to see the data in the database.
"""
import sqlite3
import BrukerTilfeller as bt
import ExtraFunctions as ef
import os

#Filenavn for SQLite-databasen
databaseFile = "Flydatabase.db"
 
#Sjekker om databasen allerede eksisterer, og oppretter den hvis den ikke gjør det
if not os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()
    ef.run_sql_script("Flydatabase.sql", cur, conn)
else:
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()

cur.execute("PRAGMA foreign_keys = ON;")
conn.autocommit = False


try:                # Fiks try except i hver av bt.tilfelle1-8 ??
    bt.tilfelle1(cur)
    bt.tilfelle2(cur)
    ef.generate_seats(cur) 
    bt.tilfelle3(cur)
    bt.tilfelle4(cur)
    # bt.tilfelle5(cur)             #Fiks denne slik den ikke printer ut shit, KUN INITIALZING DATA INTO THE DB HER
    #bt.tilfelle6(cur)              #Implementer denne. Løs evt i egen fil.
    bt.tilfelle7(cur)
    # opg 8 er gjort tror jeg. Tror den er i BrukerTilfeller.py
    conn.commit()

except sqlite3.Error as e:
    print(f"Feil: {e}")
    print("Feil oppstod. Database er allerede opprettet (probably).")


conn.close()
