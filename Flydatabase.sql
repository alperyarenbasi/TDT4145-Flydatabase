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
       -- Alternativ: CHECK (nodutgang IN ('TRUE','FALSE')) om DB ikke støtter BOOLEAN
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

-- 8) RUTETIL
CREATE TABLE RuteTil (
    fraFlyplassKode  VARCHAR(10) NOT NULL,
    tilFlyplassKode  VARCHAR(10) NOT NULL,
    -- Evt. tilleggsdata om ruten
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
    flyRuteNr         INT            NOT NULL,
    ukedagsKode       INT            NOT NULL,     -- For eksempel 1=Mandag,2=Tirsdag,...
    oppstartsDato     DATE           NOT NULL,
    sluttDato         DATE           NULL,
    startFlyplassKode VARCHAR(10)    NOT NULL,
    endeFlyplassKode  VARCHAR(10)    NOT NULL,
    opereresAvFlySelskap  INT       NOT NULL,
    bruktFlyType      VARCHAR(100)   NOT NULL,
    CONSTRAINT PK_Flyrute
        PRIMARY KEY (flyRuteNr),
    CONSTRAINT FK_Flyrute_Flyplass_Start
        FOREIGN KEY (startFlyplassKode) REFERENCES Flyplass(flyPlassKode)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_Flyrute_Flyplass_Slutt
        FOREIGN KEY (endeFlyplassKode) REFERENCES Flyplass(flyPlassKode)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_Flyrute_Flyselskap
        FOREIGN KEY (opereresAvFlySelskap) REFERENCES Flyselskap(flyselskapID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_Flyrute_Flytype
        FOREIGN KEY (bruktFlyType) REFERENCES Flytype(flytypeNavn)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
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
        ON DELETE RESTRICT
);

-- 14) FAKTISKSFLYVNING
CREATE TABLE FaktiskFlyvning (
    flyrutenummer INT         NOT NULL,
    lopenr        INT         NOT NULL,
    dato          DATE        NOT NULL,
    status        VARCHAR(10) NOT NULL,
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
        CHECK (status IN ('planned','active','complete','cancelled'))
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
        ON DELETE CASCADE
);

-- 16) PRISLISTE
--  For enkelhet: antar at tilhorerSegment peker på (flyvningsegmentnr) alene.
--  Men reelt sett trenger man trolig (flyrutenummer, lopenr, flyvningsegmentnr)
CREATE TABLE PrisListe (
    tilhorerSegment  INT        NOT NULL,
    gyldigFraDato    DATE       NOT NULL,
    premiumPris      DECIMAL(8,2) NOT NULL,
    budsjettPris     DECIMAL(8,2) NOT NULL,
    okonomiPris      DECIMAL(8,2) NOT NULL,
    CONSTRAINT PK_PrisListe
        PRIMARY KEY (tilhorerSegment, gyldigFraDato),
    CONSTRAINT FK_PrisListe_FlyvningSegment
        FOREIGN KEY (tilhorerSegment) 
        REFERENCES FlyvningSegment(flyvningsegmentnr)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 17) BILLETTKJOP
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

-- 18) DELBILLETT
--   Anntar: primærnøkkel er en egen billettID (f.eks. serial)
--   biletPris peker på PrisListe. Reelt sett trengs hele (tilhorerSegment, gyldigFraDato).
CREATE TABLE DelBillett (
    billettID         INT          NOT NULL,
    billettType       VARCHAR(20)  NOT NULL,
    innsjekketTid     DATETIME     NULL,
    booketSete        VARCHAR(100) NOT NULL,  -- Egentlig (flyTypeNavn, radNr, seteBokstav), men forenklet
    billetPris        INT          NOT NULL,  -- Forenklet: peker på PrisListe(tilhorerSegment) i eksempelet
    flyvningSegmentNr INT          NOT NULL,  -- Forenklet: kolonne for segment
    delAvBilletKjop   INT          NOT NULL,  -- Forenklet: referanseNr
    CONSTRAINT PK_DelBillett
        PRIMARY KEY (billettID),
    CONSTRAINT CK_DelBillett_billettType
        CHECK (billettType IN ('okonomi','premium','budsjett')),
    CONSTRAINT FK_DelBillett_PrisListe
        FOREIGN KEY (billetPris) 
        REFERENCES PrisListe(tilhorerSegment)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_DelBillett_FlyvningSegment
        FOREIGN KEY (flyvningSegmentNr) 
        REFERENCES FlyvningSegment(flyvningsegmentnr)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT FK_DelBillett_BillettKjop
        FOREIGN KEY (delAvBilletKjop) 
        REFERENCES BillettKjop(referanseNr)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 19) BAGASJE
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

-- 20) NASJONALITET (for Flyprodusent)
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
