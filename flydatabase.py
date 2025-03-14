import sqlite3
conn = sqlite3.connect("Flydatabase.db")
cur = conn.cursor()
#conn.autocommit = True

# Leser SQL-scriptet fra filen "Flydatabase.sql" og kjører det
with open("Flydatabase.sql", "r") as file:
    sql_script = file.read()

cur.executescript(sql_script)
conn.commit()
print("SQL-scriptet er kjørt, og databasen er opprettet/oppdatert.")

# --Brukstilfelle 1--
cur.execute("""
    INSERT INTO Flyplass (flyPlassKode, flyPlassNavn) VALUES
        ('BOO', 'Bodø Lufthavn'),
        ('BGO', 'Bergen lufthavn, Flesland'),
        ('OSL', 'Oslo lufthavn, Gardermoen'),
        ('SVG', 'Stavanger lufthavn, Sola'),
        ('TRD', 'Trondheim lufthavn, Værnes')
""")

# --Brukstilfelle 2--
cur.executescript("""
    INSERT INTO Flyselskap (flyselskapID, navn) VALUES
        (1, 'Norwegian'),
        (2, 'SAS'),
        (3, 'Widerøe');

    INSERT INTO Flytype (flytypeNavn, forsteProduksjonAAr, sisteProduksjonAAr, antallRader, FlytypeProdusent) VALUES
        ('Boeing 737 800', 1997, 2020, 31, 'The Boeing Company'),
        ('Airbus a320neo', 2016, NULL, 30, 'Airbus Group'),
        ('Dash-8 100', 1984, 2005, 10, 'De Havilland Canada');

    -- Norwegian (Boeing 737 800)
    INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
        ('LN-ENU', NULL, 2015, '42069', 1, 'The Boeing Company', 'Boeing 737 800'),
        ('LN-ENR', 'Jan Bålsrud', 2018, '42093', 1, 'The Boeing Company', 'Boeing 737 800'),
        ('LN-NIQ', 'Max Manus', 2011, '39403', 1, 'The Boeing Company', 'Boeing 737 800'),
        ('LN-ENS', NULL, 2017, '42281', 1, 'The Boeing Company', 'Boeing 737 800');

    -- SAS (Airbus a320neo)
    INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
        ('SE-RUB', 'Birger Viking', 2020, '9518', 2, 'Airbus Group', 'Airbus a320neo'),
        ('SE-DIR', 'Nora Viking', 2023, '11421', 2, 'Airbus Group', 'Airbus a320neo'),
        ('SE-RUP', 'Ragnhild Viking', 2024, '12066', 2, 'Airbus Group', 'Airbus a320neo'),
        ('SE-RZE', 'Ebbe Viking', 2024, '12166', 2, 'Airbus Group', 'Airbus a320neo');

    -- Widerøe (Dash-8 100)
    INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
        ('LN-WIH', 'Oslo', 1994, '383', 3, 'De Havilland Canada', 'Dash-8 100'),
        ('LN-WIA', 'Nordland', 1993, '359', 3, 'De Havilland Canada', 'Dash-8 100'),
        ('LN-WIL', 'Narvik', 1995, '298', 3, 'De Havilland Canada', 'Dash-8 100');
""")
conn.commit()




conn.close()
