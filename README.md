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



