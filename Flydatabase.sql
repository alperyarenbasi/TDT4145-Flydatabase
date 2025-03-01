
CREATE TABLE Airlines (
    airlineid  VARCHAR(2) PRIMARY KEY,
    airlinename       VARCHAR(255) NOT NULL
);

CREATE TABLE Airports (
    airportid VARCHAR(3) PRIMARY KEY,
    airportname VARCHAR(255) NOT NULL
);

CREATE TABLE Operates (
    airlineid VARCHAR(2),
    aircrafttypename VARCHAR(255),
    PRIMARY KEY (airlineid, aircrafttypename),
    FOREIGN KEY (airlineid) REFERENCES Airlines(airlineid),
    FOREIGN KEY (aircrafttypename) REFERENCES AircraftTypes(aircrafttypename)
);

CREATE TABLE AircraftTypes (
    aircrafttypename VARCHAR(255) PRIMARY KEY,
    firstproductionyear INT NOT NULL,
    lastproductionyear INT NOT NULL
    manufacturer VARCHAR(255) NOT NULL

);

CREATE TABLE Aircrafts (
    aircraftregnr VARCHAR(10) PRIMARY KEY,       -- Registreringsnummer
    aircraftname VARCHAR(255) NOT NULL,          -- Navn på flyet
    aircrafttypename VARCHAR(255) NOT NULL,      -- Flytypenavn
    serialnumber INT NOT NULL,                   -- Serienummer
    year_in_service YEAR NOT NULL,               -- År flyet ble tatt i bruk
    FOREIGN KEY (aircrafttypename) REFERENCES AircraftTypes(aircrafttypename) ON DELETE CASCADE
);

CREATE TABLE Seats (
    aircraftregnr VARCHAR(10),
    rownumber INT NOT NULL,
    seatletter CHAR(1) CHECK (seatletter IN ('A', 'B', 'C', 'D')),
    is_emergency_exit BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (aircraftregnr, rownumber, seatletter),
    FOREIGN KEY (aircraftregnr) REFERENCES Aircrafts(aircraftregnr)
);

CREATE TABLE Customer (
    customerid SERIAL PRIMARY KEY,
    customername VARCHAR(255) NOT NULL,
    customermail VARCHAR(255) UNIQUE NOT NULL,
    customertelephone VARCHAR(20) NOT NULL,
    nationality_id INT NOT NULL,
    FOREIGN KEY (nationality_id) REFERENCES Nationalities(id) ON DELETE CASCADE
);

CREATE TABLE Manufacturers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    year_founded INT CHECK (year_founded > 0) NOT NULL
);

CREATE TABLE Nationalities (
    id SERIAL PRIMARY KEY,
    country VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Manufacturer_Nationality (
    manufacturer_id INT REFERENCES Manufacturers(id) ON DELETE CASCADE,
    nationality_id INT REFERENCES Nationalities(id) ON DELETE CASCADE,
    PRIMARY KEY (manufacturer_id, nationality_id)
);


INSERT INTO Airports (airportid, airportname) VALUES 
('BOO', 'Bodø Airport'),
('BGO', 'Bergen Airport, Flesland'),
('OSL', 'Oslo Airport, Gardermoen'),
('SVG', 'Stavanger Airport, Sola'),
('TRD', 'Trondheim Airport, Værnes');


INSERT INTO Airlines VALUES ('DY', 'Norwegian'), 
('SK', 'SAS'),
('WF', 'Widerøe');
