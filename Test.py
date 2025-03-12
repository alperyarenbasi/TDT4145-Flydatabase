import sqlite3
conn = sqlite3.connect("Test.db")
cur = conn.cursor()

# Leser SQL-scriptet fra filen "Flydatabase.sql" og kjører det
with open("Flydatabase.sql", "r") as file:
    sql_script = file.read()

cur.executescript(sql_script)
conn.commit()
print("SQL-scriptet er kjørt, og databasen er opprettet/oppdatert.")

# Opprett nødvendige tabeller og sett inn testdata i Flytype (for å oppfylle fremmednøkkelkravet)
cur.executescript("""    
    -- Sett inn en testrad i Flytype
    INSERT INTO Flytype (flytypeNavn, forsteProduksjonAAr, sisteProduksjonAAr, antallRader, FlytypeProdusent)
    VALUES ('TestFlyType', 2000, NULL, 30, 'TestProdusent');
    INSERT INTO Flytype (flytypeNavn, forsteProduksjonAAr, sisteProduksjonAAr, antallRader, FlytypeProdusent)
    VALUES ('TestFlyType2', 2000, NULL, 30, 'TestProdusent');

""")

# Sett inn en testrad i Sete-tabellen

# cur.execute("""
#     INSERT INTO Sete (flyTypeNavn, radNr, seteBokstav, nodutgang)
#     VALUES (?, ?, ?, ?)
# """, ("TestFlyType", 1, "A", False))
# conn.commit()

# cur.execute("""
#     INSERT INTO Sete (flyTypeNavn, radNr, seteBokstav, nodutgang)
#     VALUES (?, ?, ?, ?)
# """, ("TestFlyType", 1, "A", False))

# print("Testdata er lagt inn i Sete-tabellen.")



# Test 1: Sett inn en FaktiskFlyvning med status 'active'
try:
    cur.execute("""
        INSERT INTO FaktiskFlyvning (flyrutenummer, lopenr, dato, flyStatus, bruktFly)
        VALUES (1, 1, '2025-03-12', 'active', 'LN-ENU')
    """)
    conn.commit()
    cur.execute("""
        INSERT INTO DelBillett (billettID, delPris, delAvBilletKjop, BooketflyTypeNavn, BooketradNr, Booketsetebokstav, Flyrutenummer, lopenr, flyvningsegmentnr, prisID)
        VALUES (1, 500.00, 1, 'Boeing 737 800', 1, 'A', 1, 1, 1, 1)
    """)
    conn.commit()
    print("Test 1: Insert succeeded unexpectedly (skal feile).")
except sqlite3.IntegrityError as e:
    print("Test 1: Insert failed as expected:", e)

# Tøm tabellene for å kjøre test 2
cur.executescript("""
    DELETE FROM FaktiskFlyvning;
    DELETE FROM DelBillett;
""")
conn.commit()


print("\n \n")


# Test 2: Sett inn en FaktiskFlyvning med status 'planned'
try:
    cur.execute("""
        INSERT INTO FaktiskFlyvning (flyrutenummer, lopenr, dato, flyStatus, bruktFly)
        VALUES (1, 1, '2025-03-12', 'planned', 'LN-ENU')
    """)
    conn.commit()
    cur.execute("""
        INSERT INTO DelBillett (billettID, delPris, delAvBilletKjop, BooketflyTypeNavn, BooketradNr, Booketsetebokstav, Flyrutenummer, lopenr, flyvningsegmentnr, prisID)
        VALUES (2, 500.00, 1, 'Boeing 737 800', 1, 'A', 1, 1, 1, 1)
    """)
    conn.commit()
    print("Test 2: Insert succeeded as expected (flight is planned).")
except sqlite3.IntegrityError as e:
    print("Test 2: Insert failed unexpectedly:", e)


conn.close()
