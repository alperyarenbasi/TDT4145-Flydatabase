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



Eksmepeldata:
Brukertilfelle 1,2,3,4,7:
Velg print: print ut alle data

Brukertilfelle 5:
Velg 5: Kjører brukertilfelle 5 og printer ut tabell

Brukertilfelle 6:
Velg 6: Kjører brukertilfelle 6
Velg en flyplass ved å skrive inn flyplasskoden eller skriv m for å gå tilbake til hovedmenyen: Osl  #Eksempel på hva man kan skrive inn
Skriv inn en ukedag (f.eks. 'mandag') eller M for å gå tilbake til hovedmenyen: mandag #Eksempel på hva man kan skrive inn
Er du interessert i 'avganger' eller 'ankomster'? ankomster #Eksempel på hva man kan skrive inn

Brukertilfelle 8:
Velg 8: Kjører brukertilfelle 8
Oppgi dato (YYYY-MM-DD) eller 'quit' for å avslutte: 2025-04-01
Skriv nummeret på flyvningen du vil velge: 2



Output:

Brukertilfelle 1,2,3,4,7: 
Velg en handling:
5: Kjør brukerhistorie 5
6: Kjør brukerhistorie 6
8: Kjør brukerhistorie 8
print: Print alle data
q: Avslutt programmet
Ditt valg: print


Innhold i tabellen 'Flyplass':
---------------------------------------------
| flyPlassKode | flyPlassNavn               |
---------------------------------------------
| BOO          | Bodø Lufthavn              |
| BGO          | Bergen lufthavn, Flesland  |
| OSL          | Oslo lufthavn, Gardermoen  |
| SVG          | Stavanger lufthavn, Sola   |
| TRD          | Trondheim lufthavn, Værnes |
---------------------------------------------

Innhold i tabellen 'Flyselskap':
----------------------------
| flyselskapID | navn      |
----------------------------
| DY           | Norwegian |
| SK           | SAS       |
| WF           | Widerøe   |
----------------------------

Innhold i tabellen 'Flyprodusent':
---------------------------------------
| produsentNavn       | stiftelsesAar |
---------------------------------------
| The Boeing Company  | 1916          |
| Airbus Group        | 1970          |
| De Havilland Canada | 1928          |
---------------------------------------

Innhold i tabellen 'Flytype':
-------------------------------------------------------------------------------------------------
| flytypeNavn    | forsteProduksjonAAr | sisteProduksjonAAr | antallRader | FlytypeProdusent    |
-------------------------------------------------------------------------------------------------
| Boeing 737 800 | 1997                | 2020               | 31          | The Boeing Company  |
| Airbus A320neo | 2016                | None               | 30          | Airbus Group        |
| Dash-8 100     | 1984                | 2005               | 10          | De Havilland Canada |
-------------------------------------------------------------------------------------------------

Innhold i tabellen 'Sete':
----------------------------------------------------
| flyTypeNavn    | radNr | seteBokstav | nodutgang |
----------------------------------------------------
| Boeing 737 800 | 1     | A           | 0         |
| Boeing 737 800 | 1     | B           | 0         |
| Boeing 737 800 | 1     | C           | 0         |
| Boeing 737 800 | 1     | D           | 0         |
| Boeing 737 800 | 1     | E           | 0         |
| Boeing 737 800 | 1     | F           | 0         |
| Boeing 737 800 | 2     | A           | 0         |
| Boeing 737 800 | 2     | B           | 0         |
| Boeing 737 800 | 2     | C           | 0         |
| Boeing 737 800 | 2     | D           | 0         |
| Boeing 737 800 | 2     | E           | 0         |
| Boeing 737 800 | 2     | F           | 0         |
| Boeing 737 800 | 3     | A           | 0         |
| Boeing 737 800 | 3     | B           | 0         |
| Boeing 737 800 | 3     | C           | 0         |
| Boeing 737 800 | 3     | D           | 0         |
| Boeing 737 800 | 3     | E           | 0         |
| Boeing 737 800 | 3     | F           | 0         |
| Boeing 737 800 | 4     | A           | 0         |
| Boeing 737 800 | 4     | B           | 0         |
| Boeing 737 800 | 4     | C           | 0         |
| Boeing 737 800 | 4     | D           | 0         |
| Boeing 737 800 | 4     | E           | 0         |
| Boeing 737 800 | 4     | F           | 0         |
| Boeing 737 800 | 5     | A           | 0         |
| Boeing 737 800 | 5     | B           | 0         |
| Boeing 737 800 | 5     | C           | 0         |
| Boeing 737 800 | 5     | D           | 0         |
| Boeing 737 800 | 5     | E           | 0         |
| Boeing 737 800 | 5     | F           | 0         |
| Boeing 737 800 | 6     | A           | 0         |
| Boeing 737 800 | 6     | B           | 0         |
| Boeing 737 800 | 6     | C           | 0         |
| Boeing 737 800 | 6     | D           | 0         |
| Boeing 737 800 | 6     | E           | 0         |
| Boeing 737 800 | 6     | F           | 0         |
| Boeing 737 800 | 7     | A           | 0         |
| Boeing 737 800 | 7     | B           | 0         |
| Boeing 737 800 | 7     | C           | 0         |
| Boeing 737 800 | 7     | D           | 0         |
| Boeing 737 800 | 7     | E           | 0         |
| Boeing 737 800 | 7     | F           | 0         |
| Boeing 737 800 | 8     | A           | 0         |
| Boeing 737 800 | 8     | B           | 0         |
| Boeing 737 800 | 8     | C           | 0         |
| Boeing 737 800 | 8     | D           | 0         |
| Boeing 737 800 | 8     | E           | 0         |
| Boeing 737 800 | 8     | F           | 0         |
| Boeing 737 800 | 9     | A           | 0         |
| Boeing 737 800 | 9     | B           | 0         |
| Boeing 737 800 | 9     | C           | 0         |
| Boeing 737 800 | 9     | D           | 0         |
| Boeing 737 800 | 9     | E           | 0         |
| Boeing 737 800 | 9     | F           | 0         |
| Boeing 737 800 | 10    | A           | 0         |
| Boeing 737 800 | 10    | B           | 0         |
| Boeing 737 800 | 10    | C           | 0         |
| Boeing 737 800 | 10    | D           | 0         |
| Boeing 737 800 | 10    | E           | 0         |
| Boeing 737 800 | 10    | F           | 0         |
| Boeing 737 800 | 11    | A           | 0         |
| Boeing 737 800 | 11    | B           | 0         |
| Boeing 737 800 | 11    | C           | 0         |
| Boeing 737 800 | 11    | D           | 0         |
| Boeing 737 800 | 11    | E           | 0         |
| Boeing 737 800 | 11    | F           | 0         |
| Boeing 737 800 | 12    | A           | 0         |
| Boeing 737 800 | 12    | B           | 0         |
| Boeing 737 800 | 12    | C           | 0         |
| Boeing 737 800 | 12    | D           | 0         |
| Boeing 737 800 | 12    | E           | 0         |
| Boeing 737 800 | 12    | F           | 0         |
| Boeing 737 800 | 13    | A           | 1         |
| Boeing 737 800 | 13    | B           | 1         |
| Boeing 737 800 | 13    | C           | 1         |
| Boeing 737 800 | 13    | D           | 1         |
| Boeing 737 800 | 13    | E           | 1         |
| Boeing 737 800 | 13    | F           | 1         |
| Boeing 737 800 | 14    | A           | 0         |
| Boeing 737 800 | 14    | B           | 0         |
| Boeing 737 800 | 14    | C           | 0         |
| Boeing 737 800 | 14    | D           | 0         |
| Boeing 737 800 | 14    | E           | 0         |
| Boeing 737 800 | 14    | F           | 0         |
| Boeing 737 800 | 15    | A           | 0         |
| Boeing 737 800 | 15    | B           | 0         |
| Boeing 737 800 | 15    | C           | 0         |
| Boeing 737 800 | 15    | D           | 0         |
| Boeing 737 800 | 15    | E           | 0         |
| Boeing 737 800 | 15    | F           | 0         |
| Boeing 737 800 | 16    | A           | 0         |
| Boeing 737 800 | 16    | B           | 0         |
| Boeing 737 800 | 16    | C           | 0         |
| Boeing 737 800 | 16    | D           | 0         |
| Boeing 737 800 | 16    | E           | 0         |
| Boeing 737 800 | 16    | F           | 0         |
| Boeing 737 800 | 17    | A           | 0         |
| Boeing 737 800 | 17    | B           | 0         |
| Boeing 737 800 | 17    | C           | 0         |
| Boeing 737 800 | 17    | D           | 0         |
| Boeing 737 800 | 17    | E           | 0         |
| Boeing 737 800 | 17    | F           | 0         |
| Boeing 737 800 | 18    | A           | 0         |
| Boeing 737 800 | 18    | B           | 0         |
| Boeing 737 800 | 18    | C           | 0         |
| Boeing 737 800 | 18    | D           | 0         |
| Boeing 737 800 | 18    | E           | 0         |
| Boeing 737 800 | 18    | F           | 0         |
| Boeing 737 800 | 19    | A           | 0         |
| Boeing 737 800 | 19    | B           | 0         |
| Boeing 737 800 | 19    | C           | 0         |
| Boeing 737 800 | 19    | D           | 0         |
| Boeing 737 800 | 19    | E           | 0         |
| Boeing 737 800 | 19    | F           | 0         |
| Boeing 737 800 | 20    | A           | 0         |
| Boeing 737 800 | 20    | B           | 0         |
| Boeing 737 800 | 20    | C           | 0         |
| Boeing 737 800 | 20    | D           | 0         |
| Boeing 737 800 | 20    | E           | 0         |
| Boeing 737 800 | 20    | F           | 0         |
| Boeing 737 800 | 21    | A           | 0         |
| Boeing 737 800 | 21    | B           | 0         |
| Boeing 737 800 | 21    | C           | 0         |
| Boeing 737 800 | 21    | D           | 0         |
| Boeing 737 800 | 21    | E           | 0         |
| Boeing 737 800 | 21    | F           | 0         |
| Boeing 737 800 | 22    | A           | 0         |
| Boeing 737 800 | 22    | B           | 0         |
| Boeing 737 800 | 22    | C           | 0         |
| Boeing 737 800 | 22    | D           | 0         |
| Boeing 737 800 | 22    | E           | 0         |
| Boeing 737 800 | 22    | F           | 0         |
| Boeing 737 800 | 23    | A           | 0         |
| Boeing 737 800 | 23    | B           | 0         |
| Boeing 737 800 | 23    | C           | 0         |
| Boeing 737 800 | 23    | D           | 0         |
| Boeing 737 800 | 23    | E           | 0         |
| Boeing 737 800 | 23    | F           | 0         |
| Boeing 737 800 | 24    | A           | 0         |
| Boeing 737 800 | 24    | B           | 0         |
| Boeing 737 800 | 24    | C           | 0         |
| Boeing 737 800 | 24    | D           | 0         |
| Boeing 737 800 | 24    | E           | 0         |
| Boeing 737 800 | 24    | F           | 0         |
| Boeing 737 800 | 25    | A           | 0         |
| Boeing 737 800 | 25    | B           | 0         |
| Boeing 737 800 | 25    | C           | 0         |
| Boeing 737 800 | 25    | D           | 0         |
| Boeing 737 800 | 25    | E           | 0         |
| Boeing 737 800 | 25    | F           | 0         |
| Boeing 737 800 | 26    | A           | 0         |
| Boeing 737 800 | 26    | B           | 0         |
| Boeing 737 800 | 26    | C           | 0         |
| Boeing 737 800 | 26    | D           | 0         |
| Boeing 737 800 | 26    | E           | 0         |
| Boeing 737 800 | 26    | F           | 0         |
| Boeing 737 800 | 27    | A           | 0         |
| Boeing 737 800 | 27    | B           | 0         |
| Boeing 737 800 | 27    | C           | 0         |
| Boeing 737 800 | 27    | D           | 0         |
| Boeing 737 800 | 27    | E           | 0         |
| Boeing 737 800 | 27    | F           | 0         |
| Boeing 737 800 | 28    | A           | 0         |
| Boeing 737 800 | 28    | B           | 0         |
| Boeing 737 800 | 28    | C           | 0         |
| Boeing 737 800 | 28    | D           | 0         |
| Boeing 737 800 | 28    | E           | 0         |
| Boeing 737 800 | 28    | F           | 0         |
| Boeing 737 800 | 29    | A           | 0         |
| Boeing 737 800 | 29    | B           | 0         |
| Boeing 737 800 | 29    | C           | 0         |
| Boeing 737 800 | 29    | D           | 0         |
| Boeing 737 800 | 29    | E           | 0         |
| Boeing 737 800 | 29    | F           | 0         |
| Boeing 737 800 | 30    | A           | 0         |
| Boeing 737 800 | 30    | B           | 0         |
| Boeing 737 800 | 30    | C           | 0         |
| Boeing 737 800 | 30    | D           | 0         |
| Boeing 737 800 | 30    | E           | 0         |
| Boeing 737 800 | 30    | F           | 0         |
| Boeing 737 800 | 31    | A           | 0         |
| Boeing 737 800 | 31    | B           | 0         |
| Boeing 737 800 | 31    | C           | 0         |
| Boeing 737 800 | 31    | D           | 0         |
| Boeing 737 800 | 31    | E           | 0         |
| Boeing 737 800 | 31    | F           | 0         |
| Airbus A320neo | 1     | A           | 0         |
| Airbus A320neo | 1     | B           | 0         |
| Airbus A320neo | 1     | C           | 0         |
| Airbus A320neo | 1     | D           | 0         |
| Airbus A320neo | 1     | E           | 0         |
| Airbus A320neo | 1     | F           | 0         |
| Airbus A320neo | 2     | A           | 0         |
| Airbus A320neo | 2     | B           | 0         |
| Airbus A320neo | 2     | C           | 0         |
| Airbus A320neo | 2     | D           | 0         |
| Airbus A320neo | 2     | E           | 0         |
| Airbus A320neo | 2     | F           | 0         |
| Airbus A320neo | 3     | A           | 0         |
| Airbus A320neo | 3     | B           | 0         |
| Airbus A320neo | 3     | C           | 0         |
| Airbus A320neo | 3     | D           | 0         |
| Airbus A320neo | 3     | E           | 0         |
| Airbus A320neo | 3     | F           | 0         |
| Airbus A320neo | 4     | A           | 0         |
| Airbus A320neo | 4     | B           | 0         |
| Airbus A320neo | 4     | C           | 0         |
| Airbus A320neo | 4     | D           | 0         |
| Airbus A320neo | 4     | E           | 0         |
| Airbus A320neo | 4     | F           | 0         |
| Airbus A320neo | 5     | A           | 0         |
| Airbus A320neo | 5     | B           | 0         |
| Airbus A320neo | 5     | C           | 0         |
| Airbus A320neo | 5     | D           | 0         |
| Airbus A320neo | 5     | E           | 0         |
| Airbus A320neo | 5     | F           | 0         |
| Airbus A320neo | 6     | A           | 0         |
| Airbus A320neo | 6     | B           | 0         |
| Airbus A320neo | 6     | C           | 0         |
| Airbus A320neo | 6     | D           | 0         |
| Airbus A320neo | 6     | E           | 0         |
| Airbus A320neo | 6     | F           | 0         |
| Airbus A320neo | 7     | A           | 0         |
| Airbus A320neo | 7     | B           | 0         |
| Airbus A320neo | 7     | C           | 0         |
| Airbus A320neo | 7     | D           | 0         |
| Airbus A320neo | 7     | E           | 0         |
| Airbus A320neo | 7     | F           | 0         |
| Airbus A320neo | 8     | A           | 0         |
| Airbus A320neo | 8     | B           | 0         |
| Airbus A320neo | 8     | C           | 0         |
| Airbus A320neo | 8     | D           | 0         |
| Airbus A320neo | 8     | E           | 0         |
| Airbus A320neo | 8     | F           | 0         |
| Airbus A320neo | 9     | A           | 0         |
| Airbus A320neo | 9     | B           | 0         |
| Airbus A320neo | 9     | C           | 0         |
| Airbus A320neo | 9     | D           | 0         |
| Airbus A320neo | 9     | E           | 0         |
| Airbus A320neo | 9     | F           | 0         |
| Airbus A320neo | 10    | A           | 0         |
| Airbus A320neo | 10    | B           | 0         |
| Airbus A320neo | 10    | C           | 0         |
| Airbus A320neo | 10    | D           | 0         |
| Airbus A320neo | 10    | E           | 0         |
| Airbus A320neo | 10    | F           | 0         |
| Airbus A320neo | 11    | A           | 1         |
| Airbus A320neo | 11    | B           | 1         |
| Airbus A320neo | 11    | C           | 1         |
| Airbus A320neo | 11    | D           | 1         |
| Airbus A320neo | 11    | E           | 1         |
| Airbus A320neo | 11    | F           | 1         |
| Airbus A320neo | 12    | A           | 1         |
| Airbus A320neo | 12    | B           | 1         |
| Airbus A320neo | 12    | C           | 1         |
| Airbus A320neo | 12    | D           | 1         |
| Airbus A320neo | 12    | E           | 1         |
| Airbus A320neo | 12    | F           | 1         |
| Airbus A320neo | 13    | A           | 0         |
| Airbus A320neo | 13    | B           | 0         |
| Airbus A320neo | 13    | C           | 0         |
| Airbus A320neo | 13    | D           | 0         |
| Airbus A320neo | 13    | E           | 0         |
| Airbus A320neo | 13    | F           | 0         |
| Airbus A320neo | 14    | A           | 0         |
| Airbus A320neo | 14    | B           | 0         |
| Airbus A320neo | 14    | C           | 0         |
| Airbus A320neo | 14    | D           | 0         |
| Airbus A320neo | 14    | E           | 0         |
| Airbus A320neo | 14    | F           | 0         |
| Airbus A320neo | 15    | A           | 0         |
| Airbus A320neo | 15    | B           | 0         |
| Airbus A320neo | 15    | C           | 0         |
| Airbus A320neo | 15    | D           | 0         |
| Airbus A320neo | 15    | E           | 0         |
| Airbus A320neo | 15    | F           | 0         |
| Airbus A320neo | 16    | A           | 0         |
| Airbus A320neo | 16    | B           | 0         |
| Airbus A320neo | 16    | C           | 0         |
| Airbus A320neo | 16    | D           | 0         |
| Airbus A320neo | 16    | E           | 0         |
| Airbus A320neo | 16    | F           | 0         |
| Airbus A320neo | 17    | A           | 0         |
| Airbus A320neo | 17    | B           | 0         |
| Airbus A320neo | 17    | C           | 0         |
| Airbus A320neo | 17    | D           | 0         |
| Airbus A320neo | 17    | E           | 0         |
| Airbus A320neo | 17    | F           | 0         |
| Airbus A320neo | 18    | A           | 0         |
| Airbus A320neo | 18    | B           | 0         |
| Airbus A320neo | 18    | C           | 0         |
| Airbus A320neo | 18    | D           | 0         |
| Airbus A320neo | 18    | E           | 0         |
| Airbus A320neo | 18    | F           | 0         |
| Airbus A320neo | 19    | A           | 0         |
| Airbus A320neo | 19    | B           | 0         |
| Airbus A320neo | 19    | C           | 0         |
| Airbus A320neo | 19    | D           | 0         |
| Airbus A320neo | 19    | E           | 0         |
| Airbus A320neo | 19    | F           | 0         |
| Airbus A320neo | 20    | A           | 0         |
| Airbus A320neo | 20    | B           | 0         |
| Airbus A320neo | 20    | C           | 0         |
| Airbus A320neo | 20    | D           | 0         |
| Airbus A320neo | 20    | E           | 0         |
| Airbus A320neo | 20    | F           | 0         |
| Airbus A320neo | 21    | A           | 0         |
| Airbus A320neo | 21    | B           | 0         |
| Airbus A320neo | 21    | C           | 0         |
| Airbus A320neo | 21    | D           | 0         |
| Airbus A320neo | 21    | E           | 0         |
| Airbus A320neo | 21    | F           | 0         |
| Airbus A320neo | 22    | A           | 0         |
| Airbus A320neo | 22    | B           | 0         |
| Airbus A320neo | 22    | C           | 0         |
| Airbus A320neo | 22    | D           | 0         |
| Airbus A320neo | 22    | E           | 0         |
| Airbus A320neo | 22    | F           | 0         |
| Airbus A320neo | 23    | A           | 0         |
| Airbus A320neo | 23    | B           | 0         |
| Airbus A320neo | 23    | C           | 0         |
| Airbus A320neo | 23    | D           | 0         |
| Airbus A320neo | 23    | E           | 0         |
| Airbus A320neo | 23    | F           | 0         |
| Airbus A320neo | 24    | A           | 0         |
| Airbus A320neo | 24    | B           | 0         |
| Airbus A320neo | 24    | C           | 0         |
| Airbus A320neo | 24    | D           | 0         |
| Airbus A320neo | 24    | E           | 0         |
| Airbus A320neo | 24    | F           | 0         |
| Airbus A320neo | 25    | A           | 0         |
| Airbus A320neo | 25    | B           | 0         |
| Airbus A320neo | 25    | C           | 0         |
| Airbus A320neo | 25    | D           | 0         |
| Airbus A320neo | 25    | E           | 0         |
| Airbus A320neo | 25    | F           | 0         |
| Airbus A320neo | 26    | A           | 0         |
| Airbus A320neo | 26    | B           | 0         |
| Airbus A320neo | 26    | C           | 0         |
| Airbus A320neo | 26    | D           | 0         |
| Airbus A320neo | 26    | E           | 0         |
| Airbus A320neo | 26    | F           | 0         |
| Airbus A320neo | 27    | A           | 0         |
| Airbus A320neo | 27    | B           | 0         |
| Airbus A320neo | 27    | C           | 0         |
| Airbus A320neo | 27    | D           | 0         |
| Airbus A320neo | 27    | E           | 0         |
| Airbus A320neo | 27    | F           | 0         |
| Airbus A320neo | 28    | A           | 0         |
| Airbus A320neo | 28    | B           | 0         |
| Airbus A320neo | 28    | C           | 0         |
| Airbus A320neo | 28    | D           | 0         |
| Airbus A320neo | 28    | E           | 0         |
| Airbus A320neo | 28    | F           | 0         |
| Airbus A320neo | 29    | A           | 0         |
| Airbus A320neo | 29    | B           | 0         |
| Airbus A320neo | 29    | C           | 0         |
| Airbus A320neo | 29    | D           | 0         |
| Airbus A320neo | 29    | E           | 0         |
| Airbus A320neo | 29    | F           | 0         |
| Airbus A320neo | 30    | A           | 0         |
| Airbus A320neo | 30    | B           | 0         |
| Airbus A320neo | 30    | C           | 0         |
| Airbus A320neo | 30    | D           | 0         |
| Airbus A320neo | 30    | E           | 0         |
| Airbus A320neo | 30    | F           | 0         |
| Dash-8 100     | 1     | C           | 0         |
| Dash-8 100     | 1     | D           | 0         |
| Dash-8 100     | 2     | A           | 0         |
| Dash-8 100     | 2     | B           | 0         |
| Dash-8 100     | 2     | C           | 0         |
| Dash-8 100     | 2     | D           | 0         |
| Dash-8 100     | 3     | A           | 0         |
| Dash-8 100     | 3     | B           | 0         |
| Dash-8 100     | 3     | C           | 0         |
| Dash-8 100     | 3     | D           | 0         |
| Dash-8 100     | 4     | A           | 0         |
| Dash-8 100     | 4     | B           | 0         |
| Dash-8 100     | 4     | C           | 0         |
| Dash-8 100     | 4     | D           | 0         |
| Dash-8 100     | 5     | A           | 1         |
| Dash-8 100     | 5     | B           | 1         |
| Dash-8 100     | 5     | C           | 1         |
| Dash-8 100     | 5     | D           | 1         |
| Dash-8 100     | 6     | A           | 0         |
| Dash-8 100     | 6     | B           | 0         |
| Dash-8 100     | 6     | C           | 0         |
| Dash-8 100     | 6     | D           | 0         |
| Dash-8 100     | 7     | A           | 0         |
| Dash-8 100     | 7     | B           | 0         |
| Dash-8 100     | 7     | C           | 0         |
| Dash-8 100     | 7     | D           | 0         |
| Dash-8 100     | 8     | A           | 0         |
| Dash-8 100     | 8     | B           | 0         |
| Dash-8 100     | 8     | C           | 0         |
| Dash-8 100     | 8     | D           | 0         |
| Dash-8 100     | 9     | A           | 0         |
| Dash-8 100     | 9     | B           | 0         |
| Dash-8 100     | 9     | C           | 0         |
| Dash-8 100     | 9     | D           | 0         |
| Dash-8 100     | 10    | A           | 0         |
| Dash-8 100     | 10    | B           | 0         |
| Dash-8 100     | 10    | C           | 0         |
| Dash-8 100     | 10    | D           | 0         |
----------------------------------------------------

Innhold i tabellen 'BenytterType':
---------------------------------
| flyselskapID | flyTypeNavn    |
---------------------------------
| DY           | Boeing 737 800 |
| SK           | Airbus A320neo |
| WF           | Dash-8 100     |
---------------------------------

Innhold i tabellen 'Fly':
--------------------------------------------------------------------------------------
| regnr  | navn            | aarDrift | serienr | tilhorerSelskapID | erType         |
--------------------------------------------------------------------------------------
| LN-ENU | None            | 2015     | 42069   | DY                | Boeing 737 800 |
| LN-ENR | Jan Bålsrud     | 2018     | 42093   | DY                | Boeing 737 800 |
| LN-NIQ | Max Manus       | 2011     | 39403   | DY                | Boeing 737 800 |
| LN-ENS | None            | 2017     | 42281   | DY                | Boeing 737 800 |
| SE-RUB | Birger Viking   | 2020     | 9518    | SK                | Airbus A320neo |
| SE-DIR | Nora Viking     | 2023     | 11421   | SK                | Airbus A320neo |
| SE-RUP | Ragnhild Viking | 2024     | 12066   | SK                | Airbus A320neo |
| SE-RZE | Ebbe Viking     | 2024     | 12166   | SK                | Airbus A320neo |
| LN-WIH | Oslo            | 1994     | 383     | WF                | Dash-8 100     |
| LN-WIA | Nordland        | 1993     | 359     | WF                | Dash-8 100     |
| LN-WIL | Narvik          | 1995     | 298     | WF                | Dash-8 100     |
--------------------------------------------------------------------------------------

Innhold i tabellen 'RuteTil':
-------------------------------------
| fraFlyplassKode | tilFlyplassKode |
-------------------------------------
| TRD             | BOO             |
| BOO             | TRD             |
| TRD             | OSL             |
| OSL             | TRD             |
| TRD             | BGO             |
| BGO             | SVG             |
-------------------------------------

Innhold i tabellen 'Kunde':
--------------------------------------------------------------------------------
| kundeNr | telefonNr | epost                    | navn         | nasjonalitet |
--------------------------------------------------------------------------------
| 5252    | 94115890  | ola.nordmann@example.com | Ola Nordmann | Norsk        |
--------------------------------------------------------------------------------
Tabellen 'FordelsProgram' er tom.
Tabellen 'Medlem' er tom.

Innhold i tabellen 'Flyrute':
--------------------------------------------------------------------------------------------------------------------------------------
| flyRuteNr | ukedagsKode | oppstartsDato | sluttDato | startFlyplassKode | endeFlyplassKode | opereresAvFlySelskap | bruktFlyType   |
--------------------------------------------------------------------------------------------------------------------------------------
| WF1311    | 12345       | 2018-01-01    | None      | TRD               | BOO              | WF            
       | Dash-8 100     |
| WF1302    | 12345       | 2018-01-01    | None      | BOO               | TRD              | WF            
       | Dash-8 100     |
| DY753     | 1234567     | 2018-01-01    | None      | TRD               | OSL              | DY            
       | Boeing 737 800 |
| SK332     | 1234567     | 2018-01-01    | None      | OSL               | TRD              | SK            
       | Airbus A320neo |
| SK888     | 12345       | 2018-01-01    | None      | TRD               | SVG              | SK            
       | Airbus A320neo |
--------------------------------------------------------------------------------------------------------------------------------------

Innhold i tabellen 'Delreise':
--------------------------------------------------------------------------------------------------
| flyRuteNr | delreiseNr | avgangstid | ankomsttid | delStartFlyplassKode | delSluttFlyplassKode |
--------------------------------------------------------------------------------------------------
| WF1311    | 1          | 15:15      | 16:20      | TRD                  | BOO                  |
| WF1302    | 1          | 07:35      | 08:40      | BOO                  | TRD                  |
| DY753     | 1          | 10:20      | 11:15      | TRD                  | OSL                  |
| SK332     | 1          | 08:00      | 09:05      | OSL                  | TRD                  |
| SK888     | 1          | 10:00      | 11:10      | TRD                  | BGO                  |
| SK888     | 2          | 11:40      | 12:10      | BGO                  | SVG                  |
--------------------------------------------------------------------------------------------------

Innhold i tabellen 'FaktiskFlyvning':
--------------------------------------------------------------
| flyrutenummer | lopenr | dato       | flyStatus | bruktFly |
--------------------------------------------------------------
| WF1302        | 1      | 2025-04-01 | planned   | LN-WIA   |
| DY753         | 2      | 2025-04-01 | planned   | LN-ENU   |
| SK888         | 3      | 2025-04-01 | planned   | SE-RUB   |
--------------------------------------------------------------

Innhold i tabellen 'FlyvningSegment':
-------------------------------------------------------------------------------------------------------      
| flyrutenummer | lopenr | flyvningsegmentnr | faktiskAvgangTid    | faktiskAnkomstTid   | delreiseNr |      
-------------------------------------------------------------------------------------------------------      
| WF1302        | 1      | 1                 | 2025-04-01 07:35:00 | 2025-04-01 08:40:00 | 1          |
| DY753         | 2      | 1                 | 2025-04-01 10:20:00 | 2025-04-01 11:15:00 | 1          |      
| SK888         | 3      | 1                 | 2025-04-01 10:00:00 | 2025-04-01 11:10:00 | 1          |      
| SK888         | 3      | 2                 | 2025-04-01 11:40:00 | 2025-04-01 12:10:00 | 2          |      
-------------------------------------------------------------------------------------------------------      

Innhold i tabellen 'BillettKjop':
-----------------------------------------------------------
| referanseNr | innsjekkTid | erTurRetur | kjoptAvKundeNr |
-----------------------------------------------------------
| 1001        | None        | 0          | 5252           |
| 1002        | None        | 0          | 5252           |
| 1003        | None        | 0          | 5252           |
| 1004        | None        | 0          | 5252           |
| 1005        | None        | 0          | 5252           |
| 1006        | None        | 0          | 5252           |
| 1007        | None        | 0          | 5252           |
| 1008        | None        | 0          | 5252           |
| 1009        | None        | 0          | 5252           |
| 1010        | None        | 0          | 5252           |
-----------------------------------------------------------

Innhold i tabellen 'DelBillett':
-----------------------------------------------------------------------------------------------------------------------------------------------------
| billettID | delPris | delAvBilletKjop | BooketflyTypeNavn | BooketradNr | Booketsetebokstav | Flyrutenummer | lopenr | flyvningsegmentnr | prisID |
-----------------------------------------------------------------------------------------------------------------------------------------------------
| 1         | 2018    | 1001            | Dash-8 100        | 1           | C                 | WF1302        | 1      | 1                 | 4      |
| 2         | 2018    | 1002            | Dash-8 100        | 1           | D                 | WF1302        | 1      | 1                 | 4      |
| 3         | 2018    | 1003            | Dash-8 100        | 2           | A                 | WF1302        | 1      | 1                 | 4      |
| 4         | 2018    | 1004            | Dash-8 100        | 2           | B                 | WF1302        | 1      | 1                 | 4      |
| 5         | 2018    | 1005            | Dash-8 100        | 2           | C                 | WF1302        | 1      | 1                 | 4      |
| 6         | 2018    | 1006            | Dash-8 100        | 2           | D                 | WF1302        | 1      | 1                 | 4      |
| 7         | 2018    | 1007            | Dash-8 100        | 3           | A                 | WF1302        | 1      | 1                 | 4      |
| 8         | 2018    | 1008            | Dash-8 100        | 3           | B                 | WF1302        | 1      | 1                 | 4      |
| 9         | 2018    | 1009            | Dash-8 100        | 3           | C                 | WF1302        | 1      | 1                 | 4      |
| 10        | 2018    | 1010            | Dash-8 100        | 3           | D                 | WF1302        | 1      | 1                 | 4      |
-----------------------------------------------------------------------------------------------------------------------------------------------------
Tabellen 'Bagasje' er tom.

Innhold i tabellen 'Nasjonalitet':
---------------------------------------
| produsentNavn       | nasjonalitet  |
---------------------------------------
| The Boeing Company  | USA           |
| Airbus Group        | Frankrike     |
| Airbus Group        | Tyskland      |
| Airbus Group        | Spania        |
| Airbus Group        | Storbritannia |
| De Havilland Canada | Canada        |
---------------------------------------

Innhold i tabellen 'Prisliste':
-------------------------------------------------------------------------
| prisID | priskategori | pris | gyldigfraDato | flyRuteNr | delreiseNr |
-------------------------------------------------------------------------
| 1      | okonomi      | 2018 | 2025-01-01    | WF1311    | 1          |
| 2      | premium      | 899  | 2025-01-01    | WF1311    | 1          |
| 3      | budsjett     | 599  | 2025-01-01    | WF1311    | 1          |
| 4      | okonomi      | 2018 | 2025-01-01    | WF1302    | 1          |
| 5      | premium      | 899  | 2025-01-01    | WF1302    | 1          |
| 6      | budsjett     | 599  | 2025-01-01    | WF1302    | 1          |
| 7      | okonomi      | 1500 | 2025-01-01    | DY753     | 1          |
| 8      | premium      | 1000 | 2025-01-01    | DY753     | 1          |
| 9      | budsjett     | 500  | 2025-01-01    | DY753     | 1          |
| 10     | okonomi      | 1500 | 2025-01-01    | SK332     | 1          |
| 11     | premium      | 1000 | 2025-01-01    | SK332     | 1          |
| 12     | budsjett     | 500  | 2025-01-01    | SK332     | 1          |
| 13     | okonomi      | 2200 | 2025-01-01    | SK888     | None       |
| 14     | premium      | 1700 | 2025-01-01    | SK888     | None       |
| 15     | budsjett     | 1000 | 2025-01-01    | SK888     | None       |
| 16     | okonomi      | 2000 | 2025-01-01    | SK888     | 1          |
| 17     | premium      | 1500 | 2025-01-01    | SK888     | 1          |
| 18     | budsjett     | 800  | 2025-01-01    | SK888     | 1          |
| 19     | okonomi      | 1000 | 2025-01-01    | SK888     | 2          |
| 20     | premium      | 700  | 2025-01-01    | SK888     | 2          |
| 21     | budsjett     | 350  | 2025-01-01    | SK888     | 2          |
-------------------------------------------------------------------------


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
