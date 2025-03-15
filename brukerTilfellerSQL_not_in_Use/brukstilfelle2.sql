INSERT INTO Flyselskap (flyselskapID, navn) VALUES
    ('DY', 'Norwegian'),
    ('SK', 'SAS'),
    ('WF', 'Widerøe');

INSERT INTO Flytype (flytypeNavn, forsteProduksjonAAr, sisteProduksjonAAr, antallRader, FlytypeProdusent) VALUES
    ('Boeing 737 800', 1997, 2020, 31, 'The Boeing Company'),
    ('Airbus a320neo', 2016, NULL, 30, 'Airbus Group'),
    ('Dash-8 100', 1984, 2005, 10, 'De Havilland Canada');

-- Norwegian (Boeing 737 800)
INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
    ('LN-ENU', NULL, 2015, '42069', 'DY', 'The Boeing Company', 'Boeing 737 800'),
    ('LN-ENR', 'Jan Bålsrud', 2018, '42093', 'DY', 'The Boeing Company', 'Boeing 737 800'),
    ('LN-NIQ', 'Max Manus', 2011, '39403', 'DY', 'The Boeing Company', 'Boeing 737 800'),
    ('LN-ENS', NULL, 2017, '42281', 'DY', 'The Boeing Company', 'Boeing 737 800');

-- SAS (Airbus a320neo)
INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
    ('SE-RUB', 'Birger Viking', 2020, '9518', 'SK', 'Airbus Group', 'Airbus a320neo'),
    ('SE-DIR', 'Nora Viking', 2023, '11421', 'SK', 'Airbus Group', 'Airbus a320neo'),
    ('SE-RUP', 'Ragnhild Viking', 2024, '12066', 'SK', 'Airbus Group', 'Airbus a320neo'),
    ('SE-RZE', 'Ebbe Viking', 2024, '12166', 'SK', 'Airbus Group', 'Airbus a320neo');

-- Widerøe (Dash-8 100)
INSERT INTO Fly (regnr, navn, aarDrift, serienr, tilhorerSelskapID, produsentNavn, erType) VALUES
    ('LN-WIH', 'Oslo', 1994, '383', 'WF', 'De Havilland Canada', 'Dash-8 100'),
    ('LN-WIA', 'Nordland', 1993, '359', 'WF', 'De Havilland Canada', 'Dash-8 100'),
    ('LN-WIL', 'Narvik', 1995, '298', 'WF', 'De Havilland Canada', 'Dash-8 100');


--Innsetter Nasjonaliteter i tabellen 
INSERT INTO Nasjonalitet (produsentNavn, nasjonalitet) VALUES 
    ('The Boeing Company', 'USA'),
    ('Airbus Group', 'Frankrike'),
    ('Airbus Group', 'Tyskland'),
    ('Airbus Group', 'Spania'),
    ('Airbus Group', 'Storbritannia'),
    ('De Havilland Canada', 'Canada');
