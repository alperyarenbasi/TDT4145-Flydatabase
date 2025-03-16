import sqlite3
from InitializeDB import run_sql_script

# Koble til SQLite-database
conn = sqlite3.connect("Test.db")
cur = conn.cursor()

run_sql_script("Flydatabase.sql", cur, conn)

# TEST 1: Sjekk at Flyplass-tabellen er tom før innsetting
cur.execute("SELECT COUNT(*) FROM Flyplass;")
print("Antall rader før insert:", cur.fetchone()[0])

run_sql_script("brukstilfelle1.sql", cur, conn)
print("Data er satt inn i Flyplass-tabellen.")

# TEST 3: Verifiser at alle rader er satt inn korrekt
cur.execute("SELECT * FROM Flyplass;")
print("Innhold i Flyplass-tabellen:")
for row in cur.fetchall():
    print(row)

# TEST 4: Prøv å sette inn en duplikat flyplasskode (skal feile)
try:
    cur.execute("INSERT INTO Flyplass (flyPlassKode, flyPlassNavn) VALUES (?, ?);", ('OSL', 'Oslo Lufthavn'))
    conn.commit()
except sqlite3.IntegrityError as e:
    print("Forventet feil (duplikat flyplasskode):", e)

# TEST 5: Prøv å sette inn en NULL-verdi i flyPlassKode (skal feile)
try:
    cur.execute("INSERT INTO Flyplass (flyPlassKode, flyPlassNavn) VALUES (?, ?);", (None, 'Test Flyplass'))
    conn.commit()
except sqlite3.IntegrityError as e:
    print("Forventet feil (NULL i flyPlassKode):", e)

# TEST 6: Prøv å sette inn en NULL-verdi i flyPlassNavn (skal feile)
try:
    cur.execute("INSERT INTO Flyplass (flyPlassKode, flyPlassNavn) VALUES (?, ?);", ('TST', None))
    conn.commit()
except sqlite3.IntegrityError as e:
    print("Forventet feil (NULL i flyPlassNavn):", e)

# TEST 7: Sjekk at det fremdeles er kun 5 rader i Flyplass-tabellen etter mislykkede inserts
cur.execute("SELECT COUNT(*) FROM Flyplass;")
print("Antall rader etter tester:", cur.fetchone()[0])

# Lukk databaseforbindelsen
conn.close()

