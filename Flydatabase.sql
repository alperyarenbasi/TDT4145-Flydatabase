-- 1) FLYPLASS
CREATE TABLE Flyplass (
    flyPlassKode      VARCHAR(10)  NOT NULL,
    flyPlassNavn      VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Flyplass
        PRIMARY KEY (flyPlassKode)
);


-- 2) FLYSELSKAP
CREATE TABLE Flyselskap (
    flyselskapID      INT          NOT NULL,
    navn              VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Flyselskap
        PRIMARY KEY (flyselskapID)
);

-- 3) FLYPRODUSENT
CREATE TABLE Flyprodusent (
    produsentNavn     VARCHAR(100) NOT NULL,
    stiftelsesAar     INT          NOT NULL,
    CONSTRAINT PK_Flyprodusent
        PRIMARY KEY (produsentNavn)
);

-- 4) FLYTYPE
CREATE TABLE Flytype (
    flytypeNavn         VARCHAR(100) NOT NULL,
    forsteProduksjonAAr INT          NOT NULL,
    sisteProduksjonAAr  INT          NULL,        -- Kan være NULL om produksjonen fremdeles pågår
    antallRader         INT          NOT NULL,
    FlytypeProdusent    VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Flytype
        PRIMARY KEY (flytypeNavn),
    CONSTRAINT FK_Flytype_Flyprodusent
        FOREIGN KEY (FlytypeProdusent) REFERENCES Flyprodusent(produsentNavn)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 5) SETE
--  (flyTypeNavn, radNr, setebokstav) utgjør en mulig primærnøkkel
CREATE TABLE Sete (
    flyTypeNavn    VARCHAR(100) NOT NULL,
    radNr          INT          NOT NULL,
    seteBokstav    VARCHAR(1)   NOT NULL,
    nodutgang      BOOLEAN      NOT NULL, 
    CONSTRAINT PK_Sete
        PRIMARY KEY (flyTypeNavn, radNr, seteBokstav),
    CONSTRAINT CK_SeteBokstav
        CHECK (seteBokstav IN ('A','B','C','D','E','F','G','H')),
    CONSTRAINT FK_Sete_Flytype
        FOREIGN KEY (flyTypeNavn) REFERENCES Flytype(flytypeNavn)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 6) BENYTTERTYPE - koblingstabell mellom Flyselskap og Flytype
CREATE TABLE BenytterType (
    flyselskapID   INT          NOT NULL,
    flyTypeNavn    VARCHAR(100) NOT NULL,
    CONSTRAINT PK_BenyttType
        PRIMARY KEY (flyselskapID, flyTypeNavn),
    CONSTRAINT FK_BenyttType_Flyselskap
        FOREIGN KEY (flyselskapID) REFERENCES Flyselskap(flyselskapID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_BenyttType_Flytype
        FOREIGN KEY (flyTypeNavn) REFERENCES Flytype(flytypeNavn)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 7) FLY
CREATE TABLE Fly (
    regnr              VARCHAR(50)  NOT NULL,
    navn               VARCHAR(100) NOT NULL,
    aarDrift           INT          NOT NULL,
    serienr            VARCHAR(50)  NOT NULL,
    tilhorerSelskapID  INT          NOT NULL,
    produsentNavn      VARCHAR(100) NOT NULL,
    erType             VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Fly
        PRIMARY KEY (regnr),
    CONSTRAINT FK_Fly_Flyselskap
        FOREIGN KEY (tilhorerSelskapID) REFERENCES Flyselskap(flyselskapID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_Fly_Flyprodusent
        FOREIGN KEY (produsentNavn) REFERENCES Flyprodusent(produsentNavn)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_Fly_Flytype
        FOREIGN KEY (erType) REFERENCES Flytype(flytypeNavn)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 8) RUTETIL : "Oversikt over hvilke flyplasser det er direkte forbindelser mellom"
CREATE TABLE RuteTil (
    fraFlyplassKode  VARCHAR(10) NOT NULL,
    tilFlyplassKode  VARCHAR(10) NOT NULL,
    CONSTRAINT PK_RuteTil
        PRIMARY KEY (fraFlyplassKode, tilFlyplassKode),
    CONSTRAINT FK_RuteTil_Flyplass_Fra
        FOREIGN KEY (fraFlyplassKode) REFERENCES Flyplass(flyPlassKode)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_RuteTil_Flyplass_Til
        FOREIGN KEY (tilFlyplassKode) REFERENCES Flyplass(flyPlassKode)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 9) KUNDE
CREATE TABLE Kunde (
    kundeNr       INT           NOT NULL,
    telefonNr     VARCHAR(50)   NOT NULL,
    epost         VARCHAR(100)  NOT NULL,
    navn          VARCHAR(100)  NOT NULL,
    nasjonalitet  VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_Kunde
        PRIMARY KEY (kundeNr)
);

-- 10) FORDELSPROGRAM
CREATE TABLE FordelsProgram (
    flyselskapID   INT          NOT NULL,
    programNr      INT          NOT NULL,
    beskrivelse    VARCHAR(255) NOT NULL,
    navn           VARCHAR(100) NOT NULL,
    CONSTRAINT PK_FordelsProgram
        PRIMARY KEY (flyselskapID, programNr),
    CONSTRAINT FK_FordelsProgram_Flyselskap
        FOREIGN KEY (flyselskapID) REFERENCES Flyselskap(flyselskapID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 11) MEDLEM
--  Representerer at en Kunde er medlem i et (FlyselskapID, programNr)-program
CREATE TABLE Medlem (
    flyselskapID   INT NOT NULL,
    programNr      INT NOT NULL,
    kundeNr        INT NOT NULL,
    CONSTRAINT PK_Medlem
        PRIMARY KEY (flyselskapID, programNr, kundeNr),
    CONSTRAINT FK_Medlem_FordelsProgram
        FOREIGN KEY (flyselskapID, programNr)
        REFERENCES FordelsProgram(flyselskapID, programNr)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Medlem_Kunde
        FOREIGN KEY (kundeNr) REFERENCES Kunde(kundeNr)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
-- 12) FLYRUTE
CREATE TABLE Flyrute (
    flyRuteNr           INTEGER       NOT NULL,
    ukedagsKode         TEXT          NOT NULL,
    oppstartsDato       DATE          NOT NULL,
    sluttDato           DATE          NULL,
    startFlyplassKode   TEXT          NOT NULL,
    endeFlyplassKode    TEXT          NOT NULL,
    opereresAvFlySelskap INTEGER      NOT NULL,
    bruktFlyType        TEXT          NOT NULL,
    
    CONSTRAINT PK_Flyrute
        PRIMARY KEY (flyRuteNr),

    -- Sjekk at oppstartsDato er før eller lik sluttDato (dersom sluttDato er angitt)
    CONSTRAINT CK_Flyrute_Dato
        CHECK (sluttDato IS NULL OR oppstartsDato <= sluttDato),

    CONSTRAINT FK_Flyrute_Flyplass_Start
        FOREIGN KEY (startFlyplassKode) REFERENCES Flyplass(flyPlassKode),
    CONSTRAINT FK_Flyrute_Flyplass_Slutt
        FOREIGN KEY (endeFlyplassKode) REFERENCES Flyplass(flyPlassKode),
    CONSTRAINT FK_Flyrute_Flyselskap
        FOREIGN KEY (opereresAvFlySelskap) REFERENCES Flyselskap(flyselskapID),
    CONSTRAINT FK_Flyrute_Flytype
        FOREIGN KEY (bruktFlyType) REFERENCES Flytype(flytypeNavn)
);


-- 13) DELREISE
CREATE TABLE Delreise (
    flyRuteNr            INT          NOT NULL,
    delreiseNr           INT          NOT NULL,
    avgangstid           TIME         NOT NULL,
    ankomsttid           TIME         NOT NULL,
    delStartFlyplassKode VARCHAR(10)  NOT NULL,
    delSluttFlyplassKode VARCHAR(10)  NOT NULL,
    CONSTRAINT PK_Delreise
        PRIMARY KEY (flyRuteNr, delreiseNr),
    CONSTRAINT FK_Delreise_Flyrute
        FOREIGN KEY (flyRuteNr) REFERENCES Flyrute(flyRuteNr)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_Delreise_Flyplass_Start
        FOREIGN KEY (delStartFlyplassKode) REFERENCES Flyplass(flyPlassKode)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_Delreise_Flyplass_Slutt
        FOREIGN KEY (delSluttFlyplassKode) REFERENCES Flyplass(flyPlassKode)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_Delreise_RuteTil
        FOREIGN KEY (delStartFlyplassKode, delSluttFlyplassKode)
        REFERENCES RuteTil(fraFlyplassKode, tilFlyplassKode)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT CK_Delreise_Tid
        CHECK (ankomsttid > avgangstid)
);

-- Trigger som setter delreiseNr automatisk per flyRuteNr: https://www.geeksforgeeks.org/sqlite-triggers/ and bit help from chat here
CREATE TRIGGER trg_set_delreiseNr
BEFORE INSERT ON Delreise
FOR EACH ROW
WHEN NEW.delreiseNr IS NULL OR NEW.delreiseNr = 0
BEGIN
    SELECT 
       COALESCE((SELECT MAX(delreiseNr) FROM Delreise WHERE flyRuteNr = NEW.flyRuteNr), 0) + 1
       INTO NEW.delreiseNr;
END;




-- 14) FAKTISKSFLYVNING
CREATE TABLE FaktiskFlyvning (
    flyrutenummer INT         NOT NULL,
    lopenr        INT         NOT NULL,
    dato          DATE        NOT NULL,
    flyStatus        VARCHAR(10) NOT NULL,
    bruktFly      VARCHAR(50) NOT NULL,
    CONSTRAINT PK_FaktiskFlyvning
        PRIMARY KEY (flyrutenummer, lopenr),
    CONSTRAINT FK_FaktiskFlyvning_Flyrute
        FOREIGN KEY (flyrutenummer) REFERENCES Flyrute(flyRuteNr)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_FaktiskFlyvning_Fly
        FOREIGN KEY (bruktFly) REFERENCES Fly(regnr)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT CK_FaktiskFlyvning_Status
        CHECK (flyStatus IN ('planned','active','complete','cancelled'))
);

-- 15) FLYVNINGSEGMENT
CREATE TABLE FlyvningSegment (
    flyrutenummer       INT      NOT NULL,
    lopenr              INT      NOT NULL,
    flyvningsegmentnr   INT      NOT NULL,
    faktiskAvgangTid    DATETIME NOT NULL,
    faktiskAnkomstTid   DATETIME NOT NULL,
    delreiseNr          INT      NOT NULL,
    CONSTRAINT PK_FlyvningSegment
        PRIMARY KEY (flyrutenummer, lopenr, flyvningsegmentnr),
    CONSTRAINT FK_FlyvningSegment_FaktiskFlyvning
        FOREIGN KEY (flyrutenummer, lopenr)
        REFERENCES FaktiskFlyvning(flyrutenummer, lopenr)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT FK_FlyvningSegment_Delreise
        FOREIGN KEY (flyrutenummer, delreiseNr)
        REFERENCES Delreise(flyRuteNr, delreiseNr)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT CK_FlyvningSegment_Tid
        CHECK (faktiskAnkomstTid > faktiskAvgangTid),
    -- Thet have to be alike
    CONSTRAINT CK_FlyvningSegment_SegmentNr
        CHECK (flyvningsegmentnr = delreiseNr)
);



-- 16) BILLETTKJOP
CREATE TABLE BillettKjop (
    referanseNr    INT        NOT NULL,
    innsjekkTid    DATETIME   NULL,
    erTurRetur     BOOLEAN    NOT NULL,
    kjoptAvKundeNr INT        NOT NULL,
    CONSTRAINT PK_BillettKjop
        PRIMARY KEY (referanseNr),
    CONSTRAINT FK_BillettKjop_Kunde
        FOREIGN KEY (kjoptAvKundeNr) REFERENCES Kunde(kundeNr)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 17) DELBILLETT
CREATE TABLE DelBillett (
    billettID             INT           NOT NULL,
    billettPrisKategori   VARCHAR(20)  NOT NULL,  -- 'okonomi','premium','budsjett'
    innsjekketTid         DATETIME     NULL,
    dato                  DATE         NOT NULL,
    delPris               DECIMAL(8,2) NOT NULL,
    delAvBilletKjop       INT          NOT NULL,
    BooketflyTypeNavn     VARCHAR(50)  NOT NULL,
    BooketradNr           INT          NOT NULL,
    Booketsetebokstav     VARCHAR(1)   NOT NULL,
    Flyrutenummer         INT          NOT NULL,
    lopenr                INT          NOT NULL,
    flyvningsegmentnr     INT          NOT NULL,

    -- Primærnøkkel
    CONSTRAINT PK_DelBillett
        PRIMARY KEY (billettID),

    -- Begrensning: billettPrisKategori kan kun være en av disse verdiene
    CONSTRAINT CK_DelBillett_Kategori
        CHECK (billettPrisKategori IN ('okonomi','premium','budsjett')),

    -- Fremmednøkkel: BooketflyTypeNavn, BooketradNr, Booketsetebokstav → Sete
    CONSTRAINT FK_DelBillett_Sete
        FOREIGN KEY (BooketflyTypeNavn, BooketradNr, Booketsetebokstav)
        REFERENCES Sete(flyTypeNavn, radNr, seteBokstav)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    -- Fremmednøkkel: Flyrutenummer, lopenr, flyvningsegmentnr → FlyvningSegment
    CONSTRAINT FK_DelBillett_FlyvningSegment
        FOREIGN KEY (Flyrutenummer, lopenr, flyvningsegmentnr)
        REFERENCES FlyvningSegment(flyrutenummer, lopenr, flyvningsegmentnr)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    -- Fremmednøkkel til BillettKjop (knytte delbilletten til et kjøp)
    CONSTRAINT FK_DelBillett_BillettKjop
        FOREIGN KEY (delAvBilletKjop)
        REFERENCES BillettKjop(referanseNr)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


-- 18) BAGASJE
CREATE TABLE Bagasje (
    bagasjeTagNr    INT         NOT NULL,
    vekt            DECIMAL(5,2)NOT NULL,
    innleveringsTid DATETIME    NOT NULL,
    innsjekket      BOOLEAN     NOT NULL,
    bagasjePaaReise INT         NOT NULL, -- FK til Delbillett(billettID)
    CONSTRAINT PK_Bagasje
        PRIMARY KEY (bagasjeTagNr),
    CONSTRAINT FK_Bagasje_DelBillett
        FOREIGN KEY (bagasjePaaReise) REFERENCES DelBillett(billettID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 19) NASJONALITET (for Flyprodusent)
CREATE TABLE Nasjonalitet (
    produsentNavn  VARCHAR(100) NOT NULL,
    nasjonalitet   VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_Nasjonalitet
        PRIMARY KEY (produsentNavn, nasjonalitet),
    CONSTRAINT FK_Nasjonalitet_Flyprodusent
        FOREIGN KEY (produsentNavn) REFERENCES Flyprodusent(produsentNavn)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO Flyplass (flyPlassKode, flyPlassNavn) VALUES
('BOO', 'Bodø Lufthavn'),
('BGO', 'Bergen lufthavn, Flesland'),
('OSL', 'Oslo lufthavn, Gardermoen'),
('SVG', 'Stavanger lufthavn, Sola'),
('TRD', 'Trondheim lufthavn, Værnes');

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

INSERT INTO Flyrute (flyRuteNr, ukedagsKode, oppstartsDato, sluttDato, startFlyplassKode, endeFlyplassKode, opereresAvFlySelskap, bruktFlyType) VALUES
(1311, '12345', '2024-01-01', NULL, 'TRD', 'BOO', 3, 'Dash-8 100'), -- WF1311
(1302, '12345', '2024-01-01', NULL, 'BOO', 'TRD', 3, 'Dash-8 100'), -- WF1302
(753, '1234567', '2024-01-01', NULL, 'TRD', 'OSL', 1, 'Boeing 737 800'), -- DY753
(332, '1234567', '2024-01-01', NULL, 'OSL', 'TRD', 2, 'Airbus a320neo'), -- SK332
(888, '12345', '2024-01-01', NULL, 'TRD', 'SVG', 2, 'Airbus a320neo'); -- SK888 (TRD-BGO-SVG)

/* insert av pris*/

INSERT INTO FaktiskFlyvning (flyrutenummer, lopenr, dato, flyStatus, bruktFly) VALUES
(1302, 1, '2025-04-01', 'planned', 'LN-WIH'),  -- WF1302 (BOO-TRD) med Dash-8 100
(753, 1, '2025-04-01', 'planned', 'LN-ENU'),  -- DY753 (TRD-OSL) med Boeing 737 800
(888, 1, '2025-04-01', 'planned', 'SE-RUB');  -- SK888 (TRD-BGO-SVG) med Airbus a320neo

SELECT 
    f.navn AS flyselskap, 
    ft.flytypeNavn AS flytype, 
    COUNT(fly.regnr) AS antall_fly
FROM Flyselskap f
JOIN Fly fly ON f.flyselskapID = fly.tilhorerSelskapID
JOIN Flytype ft ON fly.erType = ft.flytypeNavn
GROUP BY f.navn, ft.flytypeNavn
ORDER BY f.navn, antall_fly DESC;
