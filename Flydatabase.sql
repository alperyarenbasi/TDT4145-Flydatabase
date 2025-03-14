DROP TABLE IF EXISTS Flyplass;
DROP TABLE IF EXISTS Flyselskap;
DROP TABLE IF EXISTS Flyprodusent;
DROP TABLE IF EXISTS Flytype;
DROP TABLE IF EXISTS Sete;
DROP TABLE IF EXISTS BenytterType;
DROP TABLE IF EXISTS Fly;
DROP TABLE IF EXISTS RuteTil;
DROP TABLE IF EXISTS Kunde;
DROP TABLE IF EXISTS FordelsProgram;
DROP TABLE IF EXISTS Medlem;
DROP TABLE IF EXISTS Flyrute;
DROP TABLE IF EXISTS Delreise;
DROP TABLE IF EXISTS FaktiskFlyvning;
DROP TABLE IF EXISTS FlyvningSegment;
DROP TABLE IF EXISTS BillettKjop;
DROP TABLE IF EXISTS DelBillett;
DROP TABLE IF EXISTS Bagasje;
DROP TABLE IF EXISTS Nasjonalitet;
DROP TABLE IF EXISTS PrisListe;

-- 1) FLYPLASS
CREATE TABLE Flyplass (
    flyPlassKode      VARCHAR(10)  NOT NULL,
    flyPlassNavn      VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Flyplass
        PRIMARY KEY (flyPlassKode)
);

-- 2) FLYSELSKAP
CREATE TABLE Flyselskap (
    flyselskapID      VARCHAR(3)   NOT NULL,
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
    navn               VARCHAR(100) NULL,
    aarDrift           INT          NOT NULL,
    serienr            VARCHAR(50)  NOT NULL,
    tilhorerSelskapID  VARCHAR(3)   NULL,
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


-- 17) DELBILLETT (oppdatert)
CREATE TABLE DelBillett (
    billettID             INT           NOT NULL,
    delPris               DECIMAL(8,2)  NOT NULL,  -- Refereres fra PrisListe
    delAvBilletKjop       INT           NOT NULL,
    BooketflyTypeNavn     VARCHAR(50)   NOT NULL,
    BooketradNr           INT           NOT NULL,
    Booketsetebokstav     VARCHAR(1)    NOT NULL,
    Flyrutenummer         INT           NOT NULL,
    lopenr                INT           NOT NULL,
    flyvningsegmentnr     INT           NOT NULL,
    prisID                INT           NOT NULL,  -- Referanse til PrisListe

    CONSTRAINT PK_DelBillett
        PRIMARY KEY (billettID),

    CONSTRAINT FK_DelBillett_Sete
        FOREIGN KEY (BooketflyTypeNavn, BooketradNr, Booketsetebokstav)
        REFERENCES Sete(flyTypeNavn, radNr, seteBokstav)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_DelBillett_FlyvningSegment
        FOREIGN KEY (Flyrutenummer, lopenr, flyvningsegmentnr)
        REFERENCES FlyvningSegment(flyrutenummer, lopenr, flyvningsegmentnr)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_DelBillett_BillettKjop
        FOREIGN KEY (delAvBilletKjop)
        REFERENCES BillettKjop(referanseNr)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_DelBillett_Pris
        FOREIGN KEY (prisID)
        REFERENCES PrisListe(prisID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT UQ_DelBillett_UnikeSeter UNIQUE (Flyrutenummer, lopenr, flyvningsegmentnr, BooketflyTypeNavn, BooketradNr, Booketsetebokstav)
);

-- Trigger for å sjekke at flystatus er 'planned' før innsending av en DelBillett
CREATE TRIGGER check_fly_status_before_insert
BEFORE INSERT ON DelBillett
FOR EACH ROW
BEGIN
    SELECT
        CASE
            WHEN NOT EXISTS (
                SELECT 1
                FROM FaktiskFlyvning 
                WHERE flyrutenummer = NEW.Flyrutenummer 
                  AND lopenr = NEW.lopenr 
                  AND flyStatus = 'planned'
            )
            THEN RAISE(ABORT, 'Cannot insert: Flight status is not planned')
        END;
END;

-- Trigger for å sjekke at flystatus er 'planned' før oppdatering av en DelBillett
CREATE TRIGGER check_fly_status_before_update
BEFORE UPDATE ON DelBillett
FOR EACH ROW
BEGIN
    SELECT
        CASE
            WHEN NOT EXISTS (
                SELECT 1
                FROM FaktiskFlyvning 
                WHERE flyrutenummer = NEW.Flyrutenummer 
                  AND lopenr = NEW.lopenr 
                  AND flyStatus = 'planned'
            )
            THEN RAISE(ABORT, 'Cannot update: Flight status is not planned')
        END;
END;



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


-- NY TABELL FOR Å SPITTE UT PRISINFORMASJON 
-- 20) PRISLISTE
-- 20) PRISLISTE (oppdatert)
CREATE TABLE Prisliste (
    prisID          INT           NOT NULL,  -- Prisens unike ID
    priskategori    VARCHAR(20)   NOT NULL,  -- Kategori som 'okonomi', 'premium', 'budsjett'
    pris            DECIMAL(8,2)  NOT NULL,  -- Pris for billetten
    gyldigfraDato   DATE          NOT NULL,  -- Startdato for når prisen er gyldig
    flyRuteNr       INT           NOT NULL,  -- Flyrutenummer prisen gjelder for
    delreiseNr      INT           NULL,      -- Hvilken delreise prisen gjelder for (kan være NULL hvis prisen gjelder for hele ruten)

    -- Primærnøkkel
    CONSTRAINT PK_Prisliste
        PRIMARY KEY (prisID),

    -- Sjekk at priskategori er gyldig
    CONSTRAINT CK_Prisliste_Kategori
        CHECK (priskategori IN ('okonomi', 'premium', 'budsjett')),

    -- Fremmednøkkel: Knytter prisen til en hel flyrute eller en spesifikk delreise
    CONSTRAINT FK_Prisliste_Flyrute
        FOREIGN KEY (flyRuteNr)
        REFERENCES Flyrute(flyRuteNr)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Prisliste_Delreise
        FOREIGN KEY (flyRuteNr, delreiseNr)
        REFERENCES Delreise(flyRuteNr, delreiseNr)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
