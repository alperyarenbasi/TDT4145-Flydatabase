# TDT4145-Flydatabase
TDT4145 Datamodellering og databasesystemer: Prosjektinnleveringer

Av: 
Pakalon Nirmalan 
Pabilan Sivanathan
Alper Yarenbasi

Bruksanvisning:
Programmet kjøres ved å kjøre main.py filen, slik du gjører python programmet ellers. Programmet må kjøre fra rotmappen. Når programmet blir kjørt blir all dataen tilhørende brukerhistorier 
1,2,3,4 og 7 initialisert og lagt til i databsen. Dette skjer i tillegg til at flydatabase.sql som inneholder databasene blir kjørt. Brukeren kommer så til en hovedmeny hvor man kan kjøre 
brukertilfelle 5,6 eller 8 ved å skrive henholdsvis 5,6 eller 8. Alternativt er det også mulig å avslutte programmet eller å skrive print for å se alt av tabellinnhold fra brukerhistorie 1,2,3,4,7


Kommentarer 
Til oppgave 1,2,3,4,7: Brukerhistoriene vil printes ut i en tabell
Til oppgave 6: 
For flyplasser som er en del av en større flyrute vises hele flyruten. Dette var det vi syntes virket mest logisk 
Til oppgave 8: 
Dersom en flyvning inneholder flere delflyvningen, vil alle disse vises under hverandre. Dette gjelder gså direkteflyvninger. Prøv å printe ut resultatet for ruten mellom TRD og SVG for å se dette. 
Billettene fra 7 har bitt lagt til i databasen som vil si at noen seter på et av flyene er bestilt allerede 



ENDRINGSLOGG:

1. Opprette PrisListe klasse for å sørge for at alle klasser er i 4NF og gjøre det lettere å tilfredstille brukerhistorier 
2. Constraints i delbillett er oppdatert slik man kan kun kjøpe billett på fly som har status planned 
3. Constraints i delbillett er oppdater slik at to delbilletter på samme flyvningssegment ikke kan ha samme sete (Samme sete kan ikke bestilles på ganger på samme flyvning)
4. Trigger funksjoner har blitt fjernet til fordel for manuell implementering 
5. flyselskapID har blitt endret til VARCHAR(3) (Fra type INT) pga. oppgaveteksten. Denne endringen hr gjort at referanser til denne tabellen, som eksø. gjøres i fly tabellen også endrer datatype 
6. Vi har implementert autoincrement der vi har sett at dette er nødvendig
7. Gruppen er klar over at det er en del Constraints com ideelt sett slutte vært implementert. Vi har valgt å fokusere på de vi mener er de viktigste. Vi har prøvd å teste for svakheter og prøvd å gjøre noe med disse
8. Fly trenger ikke produksentnavn fordi flytype allerede har produsentNavn
9. Prisliste er implementert som en kategori og er koblet til enten delreise eller flyrute
10. Drop table er lagt til på starten av flydatabase.db filen. Dette er for at innhold skal fjernes hvis tabellene allerede finnes 


FILFORKLARING: 
Flydatabase.sql -> Databasen med create tabel instruksjoner 
main.py -> Hovedfil den som skal kjøres 
ExtraFunctions.py -> Ekstrafunksjoner som trengs i noen av brukstillfellene + støtte for printing av tabeller 
Brukertilfeller.py -> Implementering av brukstillfellene som kjører INSERTS (vi kunne slått denne sammen med ExtraFunctions)

Eksempeldata: 

Brukertilfelle 1,2,3,4,7: 


Brukertilfelle 5:
Velg en handling:
5: Kjør brukerhistorie 5
6: Kjør brukerhistorie 6
8: Kjør brukerhistorie 8
print: Print alle data
q: Avslutt programmet
Ditt valg: 5
Data for tilfelle5 hentes fra databasen (flyselskap flytype oversikt).

--- Flyselskap Flytype Oversikt ---
Flyselskap           Flytype                   Antall Fly
-------------------------------------------------------
Norwegian            Boeing 737 800            4
SAS                  Airbus A320neo            4
Widerøe              Dash-8 100                3

Brukertilfelle 6:
Velg en handling:
5: Kjør brukerhistorie 5
6: Kjør brukerhistorie 6
8: Kjør brukerhistorie 8
print: Print alle data
q: Avslutt programmet
Ditt valg: 6
Tilgjengelige flyplasser:
BOO: Bodø Lufthavn
BGO: Bergen lufthavn, Flesland
OSL: Oslo lufthavn, Gardermoen
SVG: Stavanger lufthavn, Sola
TRD: Trondheim lufthavn, Værnes
Velg en flyplass ved å skrive inn flyplasskoden eller skriv m for å gå tilbake til hovedmenyen: Osl
Du har valgt Oslo lufthavn, Gardermoen (OSL)
Skriv inn en ukedag (f.eks. 'mandag') eller M for å gå tilbake til hovedmenyen:mandag 
Er du interessert i 'avganger' eller 'ankomster'? ankomster

Resultater:

Flynr      Avgang     Ankomst    Stopp
----------------------------------------------------------------------
DY753      10:20      11:15      TRD -> OSL

*** Slutt på programmet ***

Brukertilfelle 8:
Velg en handling:
5: Kjør brukerhistorie 5
6: Kjør brukerhistorie 6
8: Kjør brukerhistorie 8
print: Print alle data
q: Avslutt programmet
Ditt valg: 8

*** FLYRUTE BOOKING SYSTEM ***

Følgende flyvninger eksisterer tilgjengelige for booking. Velg en dato hvor en av disse flyene går:
1: Flyrute WF1302, Dato 2025-04-01, Fra: BOO, Til: TRD, Brukt Fly: LN-WIA
2: Flyrute DY753, Dato 2025-04-01, Fra: TRD, Til: OSL, Brukt Fly: LN-ENU
3: Flyrute SK888, Dato 2025-04-01, Fra: TRD, Til: SVG, Brukt Fly: SE-RUB
Oppgi dato (YYYY-MM-DD) eller 'quit' for å avslutte: 2025-04-01

Velg en flyvning fra listen:
1: Flyrute WF1302, Dato 2025-04-01, Fra: BOO, Til: TRD, Brukt Fly: LN-WIA
2: Flyrute DY753, Dato 2025-04-01, Fra: TRD, Til: OSL, Brukt Fly: LN-ENU
3: Flyrute SK888, Dato 2025-04-01, Fra: TRD, Til: SVG, Brukt Fly: SE-RUB
Skriv nummeret på flyvningen du vil velge: 2

Du har valgt flyrute DY753 fra TRD til OSL den 2025-04-01. Brukt fly: LN-ENU


Ledige seter for flyvning:


Delflyvning 1:
  Flytype: Boeing 737 800, Rad: 1, Sete: A
  Flytype: Boeing 737 800, Rad: 1, Sete: B
  Flytype: Boeing 737 800, Rad: 1, Sete: C
  Flytype: Boeing 737 800, Rad: 1, Sete: D
  Flytype: Boeing 737 800, Rad: 1, Sete: E
  Flytype: Boeing 737 800, Rad: 1, Sete: F
  Flytype: Boeing 737 800, Rad: 2, Sete: A
  Flytype: Boeing 737 800, Rad: 2, Sete: B
  Flytype: Boeing 737 800, Rad: 2, Sete: C
  Flytype: Boeing 737 800, Rad: 2, Sete: D
  Flytype: Boeing 737 800, Rad: 2, Sete: E
  Flytype: Boeing 737 800, Rad: 2, Sete: F
  Flytype: Boeing 737 800, Rad: 3, Sete: A
  Flytype: Boeing 737 800, Rad: 3, Sete: B
  Flytype: Boeing 737 800, Rad: 3, Sete: C
  Flytype: Boeing 737 800, Rad: 3, Sete: D
  Flytype: Boeing 737 800, Rad: 3, Sete: E
  Flytype: Boeing 737 800, Rad: 3, Sete: F
  Flytype: Boeing 737 800, Rad: 4, Sete: A
  Flytype: Boeing 737 800, Rad: 4, Sete: B
  Flytype: Boeing 737 800, Rad: 4, Sete: C
  Flytype: Boeing 737 800, Rad: 4, Sete: D
  Flytype: Boeing 737 800, Rad: 4, Sete: E
  Flytype: Boeing 737 800, Rad: 4, Sete: F
  Flytype: Boeing 737 800, Rad: 5, Sete: A
  Flytype: Boeing 737 800, Rad: 5, Sete: B
  Flytype: Boeing 737 800, Rad: 5, Sete: C
  Flytype: Boeing 737 800, Rad: 5, Sete: D
  Flytype: Boeing 737 800, Rad: 5, Sete: E
  Flytype: Boeing 737 800, Rad: 5, Sete: F
  Flytype: Boeing 737 800, Rad: 6, Sete: A
  Flytype: Boeing 737 800, Rad: 6, Sete: B
  Flytype: Boeing 737 800, Rad: 6, Sete: C
  Flytype: Boeing 737 800, Rad: 6, Sete: D
  Flytype: Boeing 737 800, Rad: 6, Sete: E
  Flytype: Boeing 737 800, Rad: 6, Sete: F
  Flytype: Boeing 737 800, Rad: 7, Sete: A
  Flytype: Boeing 737 800, Rad: 7, Sete: B
  Flytype: Boeing 737 800, Rad: 7, Sete: C
  Flytype: Boeing 737 800, Rad: 7, Sete: D
  Flytype: Boeing 737 800, Rad: 7, Sete: E
  Flytype: Boeing 737 800, Rad: 7, Sete: F
  Flytype: Boeing 737 800, Rad: 8, Sete: A
  Flytype: Boeing 737 800, Rad: 8, Sete: B
  Flytype: Boeing 737 800, Rad: 8, Sete: C
  Flytype: Boeing 737 800, Rad: 8, Sete: D
  Flytype: Boeing 737 800, Rad: 8, Sete: E
  Flytype: Boeing 737 800, Rad: 8, Sete: F
  Flytype: Boeing 737 800, Rad: 9, Sete: A
  Flytype: Boeing 737 800, Rad: 9, Sete: B
  Flytype: Boeing 737 800, Rad: 9, Sete: C
  Flytype: Boeing 737 800, Rad: 9, Sete: D
  Flytype: Boeing 737 800, Rad: 9, Sete: E
  Flytype: Boeing 737 800, Rad: 9, Sete: F
  Flytype: Boeing 737 800, Rad: 10, Sete: A
  Flytype: Boeing 737 800, Rad: 10, Sete: B
  Flytype: Boeing 737 800, Rad: 10, Sete: C
  Flytype: Boeing 737 800, Rad: 10, Sete: D
  Flytype: Boeing 737 800, Rad: 10, Sete: E
  Flytype: Boeing 737 800, Rad: 10, Sete: F
  Flytype: Boeing 737 800, Rad: 11, Sete: A
  Flytype: Boeing 737 800, Rad: 11, Sete: B
  Flytype: Boeing 737 800, Rad: 11, Sete: C
  Flytype: Boeing 737 800, Rad: 11, Sete: D
  Flytype: Boeing 737 800, Rad: 11, Sete: E
  Flytype: Boeing 737 800, Rad: 11, Sete: F
  Flytype: Boeing 737 800, Rad: 12, Sete: A
  Flytype: Boeing 737 800, Rad: 12, Sete: B
  Flytype: Boeing 737 800, Rad: 12, Sete: C
  Flytype: Boeing 737 800, Rad: 12, Sete: D
  Flytype: Boeing 737 800, Rad: 12, Sete: E
  Flytype: Boeing 737 800, Rad: 12, Sete: F
  Flytype: Boeing 737 800, Rad: 13, Sete: A
  Flytype: Boeing 737 800, Rad: 13, Sete: B
  Flytype: Boeing 737 800, Rad: 13, Sete: C
  Flytype: Boeing 737 800, Rad: 13, Sete: D
  Flytype: Boeing 737 800, Rad: 13, Sete: E
  Flytype: Boeing 737 800, Rad: 13, Sete: F
  Flytype: Boeing 737 800, Rad: 14, Sete: A
  Flytype: Boeing 737 800, Rad: 14, Sete: B
  Flytype: Boeing 737 800, Rad: 14, Sete: C
  Flytype: Boeing 737 800, Rad: 14, Sete: D
  Flytype: Boeing 737 800, Rad: 14, Sete: E
  Flytype: Boeing 737 800, Rad: 14, Sete: F
  Flytype: Boeing 737 800, Rad: 15, Sete: A
  Flytype: Boeing 737 800, Rad: 15, Sete: B
  Flytype: Boeing 737 800, Rad: 15, Sete: C
  Flytype: Boeing 737 800, Rad: 15, Sete: D
  Flytype: Boeing 737 800, Rad: 15, Sete: E
  Flytype: Boeing 737 800, Rad: 15, Sete: F
  Flytype: Boeing 737 800, Rad: 16, Sete: A
  Flytype: Boeing 737 800, Rad: 16, Sete: B
  Flytype: Boeing 737 800, Rad: 16, Sete: C
  Flytype: Boeing 737 800, Rad: 16, Sete: D
  Flytype: Boeing 737 800, Rad: 16, Sete: E
  Flytype: Boeing 737 800, Rad: 16, Sete: F
  Flytype: Boeing 737 800, Rad: 17, Sete: A
  Flytype: Boeing 737 800, Rad: 17, Sete: B
  Flytype: Boeing 737 800, Rad: 17, Sete: C
  Flytype: Boeing 737 800, Rad: 17, Sete: D
  Flytype: Boeing 737 800, Rad: 17, Sete: E
  Flytype: Boeing 737 800, Rad: 17, Sete: F
  Flytype: Boeing 737 800, Rad: 18, Sete: A
  Flytype: Boeing 737 800, Rad: 18, Sete: B
  Flytype: Boeing 737 800, Rad: 18, Sete: C
  Flytype: Boeing 737 800, Rad: 18, Sete: D
  Flytype: Boeing 737 800, Rad: 18, Sete: E
  Flytype: Boeing 737 800, Rad: 18, Sete: F
  Flytype: Boeing 737 800, Rad: 19, Sete: A
  Flytype: Boeing 737 800, Rad: 19, Sete: B
  Flytype: Boeing 737 800, Rad: 19, Sete: C
  Flytype: Boeing 737 800, Rad: 19, Sete: D
  Flytype: Boeing 737 800, Rad: 19, Sete: E
  Flytype: Boeing 737 800, Rad: 19, Sete: F
  Flytype: Boeing 737 800, Rad: 20, Sete: A
  Flytype: Boeing 737 800, Rad: 20, Sete: B
  Flytype: Boeing 737 800, Rad: 20, Sete: C
  Flytype: Boeing 737 800, Rad: 20, Sete: D
  Flytype: Boeing 737 800, Rad: 20, Sete: E
  Flytype: Boeing 737 800, Rad: 20, Sete: F
  Flytype: Boeing 737 800, Rad: 21, Sete: A
  Flytype: Boeing 737 800, Rad: 21, Sete: B
  Flytype: Boeing 737 800, Rad: 21, Sete: C
  Flytype: Boeing 737 800, Rad: 21, Sete: D
  Flytype: Boeing 737 800, Rad: 21, Sete: E
  Flytype: Boeing 737 800, Rad: 21, Sete: F
  Flytype: Boeing 737 800, Rad: 22, Sete: A
  Flytype: Boeing 737 800, Rad: 22, Sete: B
  Flytype: Boeing 737 800, Rad: 22, Sete: C
  Flytype: Boeing 737 800, Rad: 22, Sete: D
  Flytype: Boeing 737 800, Rad: 22, Sete: E
  Flytype: Boeing 737 800, Rad: 22, Sete: F
  Flytype: Boeing 737 800, Rad: 23, Sete: A
  Flytype: Boeing 737 800, Rad: 23, Sete: B
  Flytype: Boeing 737 800, Rad: 23, Sete: C
  Flytype: Boeing 737 800, Rad: 23, Sete: D
  Flytype: Boeing 737 800, Rad: 23, Sete: E
  Flytype: Boeing 737 800, Rad: 23, Sete: F
  Flytype: Boeing 737 800, Rad: 24, Sete: A
  Flytype: Boeing 737 800, Rad: 24, Sete: B
  Flytype: Boeing 737 800, Rad: 24, Sete: C
  Flytype: Boeing 737 800, Rad: 24, Sete: D
  Flytype: Boeing 737 800, Rad: 24, Sete: E
  Flytype: Boeing 737 800, Rad: 24, Sete: F
  Flytype: Boeing 737 800, Rad: 25, Sete: A
  Flytype: Boeing 737 800, Rad: 25, Sete: B
  Flytype: Boeing 737 800, Rad: 25, Sete: C
  Flytype: Boeing 737 800, Rad: 25, Sete: D
  Flytype: Boeing 737 800, Rad: 25, Sete: E
  Flytype: Boeing 737 800, Rad: 25, Sete: F
  Flytype: Boeing 737 800, Rad: 26, Sete: A
  Flytype: Boeing 737 800, Rad: 26, Sete: B
  Flytype: Boeing 737 800, Rad: 26, Sete: C
  Flytype: Boeing 737 800, Rad: 26, Sete: D
  Flytype: Boeing 737 800, Rad: 26, Sete: E
  Flytype: Boeing 737 800, Rad: 26, Sete: F
  Flytype: Boeing 737 800, Rad: 27, Sete: A
  Flytype: Boeing 737 800, Rad: 27, Sete: B
  Flytype: Boeing 737 800, Rad: 27, Sete: C
  Flytype: Boeing 737 800, Rad: 27, Sete: D
  Flytype: Boeing 737 800, Rad: 27, Sete: E
  Flytype: Boeing 737 800, Rad: 27, Sete: F
  Flytype: Boeing 737 800, Rad: 28, Sete: A
  Flytype: Boeing 737 800, Rad: 28, Sete: B
  Flytype: Boeing 737 800, Rad: 28, Sete: C
  Flytype: Boeing 737 800, Rad: 28, Sete: D
  Flytype: Boeing 737 800, Rad: 28, Sete: E
  Flytype: Boeing 737 800, Rad: 28, Sete: F
  Flytype: Boeing 737 800, Rad: 29, Sete: A
  Flytype: Boeing 737 800, Rad: 29, Sete: B
  Flytype: Boeing 737 800, Rad: 29, Sete: C
  Flytype: Boeing 737 800, Rad: 29, Sete: D
  Flytype: Boeing 737 800, Rad: 29, Sete: E
  Flytype: Boeing 737 800, Rad: 29, Sete: F
  Flytype: Boeing 737 800, Rad: 30, Sete: A
  Flytype: Boeing 737 800, Rad: 30, Sete: B
  Flytype: Boeing 737 800, Rad: 30, Sete: C
  Flytype: Boeing 737 800, Rad: 30, Sete: D
  Flytype: Boeing 737 800, Rad: 30, Sete: E
  Flytype: Boeing 737 800, Rad: 30, Sete: F
  Flytype: Boeing 737 800, Rad: 31, Sete: A
  Flytype: Boeing 737 800, Rad: 31, Sete: B
  Flytype: Boeing 737 800, Rad: 31, Sete: C
  Flytype: Boeing 737 800, Rad: 31, Sete: D
  Flytype: Boeing 737 800, Rad: 31, Sete: E
  Flytype: Boeing 737 800, Rad: 31, Sete: F

*** Slutt på programmet ***
