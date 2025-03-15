"""
Advarsel: Klarte å sette inn et svært langt regnr, sjekk om dette er ønsket!
Advarsel: Klarte å sette inn et fly med aarDrift før flytypen ble produsert!
Advarsel: Klarte å sette inn en flytype med negativt antall rader!
Advarsel: Klarte å sette inn en flytype med sisteProduksjonAAr før forsteProduksjonAAr!
Advarsel: Klarte å sette inn et fly med fremtidig aarDrift (2026)! Er dette OK?
Advarsel: Klarte å endre flytype til en fra en annen produsent!
Advarsel: Klarte å sette inn to fly med samme serienummer!
Advarsel: Klarte å sette inn en nasjonalitet med tom streng!
"""

import sqlite3
from flydatabase import run_sql_script

# Koble til SQLite-database
conn = sqlite3.connect("Test.db")
cur = conn.cursor()

# Kjør SQL-skriptet med dataene
run_sql_script("Flydatabase.sql", cur, conn)
#run_sql_script("brukstilfelle1.sql", cur, conn)
run_sql_script("brukstilfelle2.sql", cur, conn)

# TEST 1: Sjekk at tabellene er fylt korrekt (baseline)
cur.execute("SELECT COUNT(*) FROM Flyselskap;")
print("Antall rader i Flyselskap:", cur.fetchone()[0])
cur.execute("SELECT COUNT(*) FROM Flytype;")
print("Antall rader i Flytype:", cur.fetchone()[0])
cur.execute("SELECT COUNT(*) FROM Fly;")
print("Antall rader i Fly:", cur.fetchone()[0])
cur.execute("SELECT COUNT(*) FROM Nasjonalitet;")
print("Antall rader i Nasjonalitet:", cur.fetchone()[0])

# EDGE CASE 1: Prøv å sette inn et fly med maksimalt tillatt registreringsnummer (lengde-test)
try:
    cur.execute("INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES (?, ?, ?, ?, ?, ?, ?);",
                ('LN-ABCDEFGHIJ', None, 2020, '12345', 'DY', 'The Boeing Company', 'Boeing 737 800'))
    conn.commit()
    print("Advarsel: Klarte å sette inn et svært langt regnr, sjekk om dette er ønsket!")
except sqlite3.IntegrityError as e:
    print("Forventet feil eller lengdebegrensning på regnr:", e)

# EDGE CASE 2: Prøv å sette inn et fly med år i drift før flytypen ble produsert
try:
    cur.execute("INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES (?, ?, ?, ?, ?, ?, ?);",
                ('LN-OLD', None, 1990, '54321', 'DY', 'The Boeing Company', 'Boeing 737 800'))  # 737-800 produsert fra 1997
    conn.commit()
    print("Advarsel: Klarte å sette inn et fly med aarDrift før flytypen ble produsert!")
except sqlite3.IntegrityError as e:
    print("Feil ved aarDrift før produksjon (forventet om det er sjekk):", e)

# EDGE CASE 3: Prøv å sette inn en flytype med negativt antall rader
try:
    cur.execute("INSERT INTO Flytype (flytypeNavn, forsteProduksjonAAr, sisteProduksjonAAr, antallRader, FlytypeProdusent) VALUES (?, ?, ?, ?, ?);",
                ('Test Flytype', 2020, None, -5, 'The Boeing Company'))
    conn.commit()
    print("Advarsel: Klarte å sette inn en flytype med negativt antall rader!")
except sqlite3.IntegrityError as e:
    print("Forventet feil (negativt antall rader):", e)

# EDGE CASE 4: Prøv å sette inn en flytype med sisteProduksjonAAr før forsteProduksjonAAr
try:
    cur.execute("INSERT INTO Flytype (flytypeNavn, forsteProduksjonAAr, sisteProduksjonAAr, antallRader, FlytypeProdusent) VALUES (?, ?, ?, ?, ?);",
                ('Crazy Flytype', 2020, 2010, 20, 'Airbus Group'))
    conn.commit()
    print("Advarsel: Klarte å sette inn en flytype med sisteProduksjonAAr før forsteProduksjonAAr!")
except sqlite3.IntegrityError as e:
    print("Forventet feil (ulogisk tidslinje):", e)

# EDGE CASE 5: Prøv å sette inn et fly med et fremtidig år i drift (2026)
try:
    cur.execute("INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES (?, ?, ?, ?, ?, ?, ?);",
                ('LN-FUTURE', None, 2026, '99999', 'SK', 'Airbus Group', 'Airbus a320neo'))
    conn.commit()
    print("Advarsel: Klarte å sette inn et fly med fremtidig aarDrift (2026)! Er dette OK?")
except sqlite3.IntegrityError as e:
    print("Feil ved fremtidig aarDrift (forventet om det er sjekk):", e)

# EDGE CASE 6: Prøv å oppdatere et fly til en flytype fra en annen produsent
try:
    cur.execute("UPDATE Fly SET erType = 'Dash-8 100' WHERE regnr = 'LN-ENU';")  # Boeing-fly endres til De Havilland
    conn.commit()
    print("Advarsel: Klarte å endre flytype til en fra en annen produsent!")
except sqlite3.IntegrityError as e:
    print("Forventet feil (produsent mismatch):", e)

# EDGE CASE 7: Sjekk om det er mulig å ha samme serienummer på to fly (bør kanskje være unikt?)
try:
    cur.execute("INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES (?, ?, ?, ?, ?, ?, ?);",
                ('LN-DUP', None, 2015, '42069', 'DY', 'The Boeing Company', 'Boeing 737 800'))  # Samme serienr som LN-ENU
    conn.commit()
    print("Advarsel: Klarte å sette inn to fly med samme serienummer!")
except sqlite3.IntegrityError as e:
    print("Forventet feil (duplikat serienummer):", e)

# EDGE CASE 8: Prøv å sette inn en nasjonalitet med et tomt navn (tom streng)
try:
    cur.execute("INSERT INTO Nasjonalitet (produsentNavn, nasjonalitet) VALUES (?, ?);", ('The Boeing Company', ''))
    conn.commit()
    print("Advarsel: Klarte å sette inn en nasjonalitet med tom streng!")
except sqlite3.IntegrityError as e:
    print("Forventet feil (tom nasjonalitet):", e)

# Sjekk tilstanden etter alle tester
cur.execute("SELECT COUNT(*) FROM Flytype;")
print("Antall rader i Flytype etter tester:", cur.fetchone()[0])
cur.execute("SELECT COUNT(*) FROM Fly;")
print("Antall rader i Fly etter tester:", cur.fetchone()[0])
cur.execute("SELECT COUNT(*) FROM Nasjonalitet;")
print("Antall rader i Nasjonalitet etter tester:", cur.fetchone()[0])

# Lukk databaseforbindelsen
conn.close()