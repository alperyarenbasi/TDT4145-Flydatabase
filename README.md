# TDT4145-Flydatabase

**TDT4145: Datamodellering og databasesystemer**

## Beskrivelse

Dette prosjektet implementerer en enkel flydatabase med støtte for ulike brukerhistorier (1–8). Databasen bygges opp fra en SQL-skriptfil og fylles med eksempeldata. Python-skriptet `main.py` gir en interaktiv meny for å kjøre brukerhistoriene.

## Forfattere

- Pakalon Nirmalan
- Pabilan Sivanathan
- Alper Yarenbasi

## Komme i gang

### Forutsetninger

- Python 3.x  
- SQLite (ingår som standard i Python)

### Installasjon

1. Klon depotet:
   ```bash
   git clone <repo-url>
   cd TDT4145-Flydatabase
   ```
2. (Valgfritt) Opprett og aktiver et virtuelt miljø:
   ```bash
   python -m venv venv
   source venv/bin/activate   # Linux/macOS
   venv\Scripts\activate      # Windows
   ```
3. Installer eventuelle Python-avhengigheter:
   ```bash
   pip install -r requirements.txt
   ```

## Bruksanvisning

Kjør programmet fra rotmappen:

```bash
python main.py
```

### Oppstart

- `flydatabase.sql` kjøres automatisk for å opprette og resette tabellene.  
- Brukerhistoriene 1, 2, 3, 4 og 7 initialiseres og fylles med eksempeldata.

### Hovedmeny

Velg en handling:

```
5     - Kjør brukerhistorie 5 (Flyselskap–flytype-oversikt)
6     - Kjør brukerhistorie 6 (Avganger/ankomster)
8     - Kjør brukerhistorie 8 (Booking)
print - Vis alle tabeller (1,2,3,4,7)
q     - Avslutt programmet
```

Skriv valget ditt (5, 6, 8, print eller q).

## Brukertilfeller

### 5. Flyselskap–flytype-oversikt

Viser hvor mange fly hvert flyselskap opererer:

```text
--- Flyselskap Flytype Oversikt ---
Flyselskap    Flytype            Antall fly
------------------------------------------
Norwegian     Boeing 737-800    4
SAS           Airbus A320neo    4
Widerøe       Dash-8 100        3
```

### 6. Avganger og ankomster

1. Velg flyplass (kode): f.eks. `OSL`  
2. Angi ukedag (f.eks. `mandag`)  
3. Velg `avganger` eller `ankomster`

Eksempel:
```text
Du har valgt Oslo lufthavn, Gardermoen (OSL)
Ukedag: mandag
Viser ankomster:
Flynr   Avgang   Ankomst   Stopp
--------------------------------
DY753   10:20    11:15     TRD → OSL
```

### 8. Booking

1. Velg dato (YYYY-MM-DD) for tilgjengelige flyvinger.  
2. Velg ett av de listede alternativene.  
3. Systemet viser ledige seter per delflyvning.

```text
*** FLYRUTE BOOKING SYSTEM ***
1: WF1302, 2025-04-01, BOO → TRD
2: DY753,   2025-04-01, TRD → OSL
3: SK888,   2025-04-01, TRD → SVG
Skriv nummeret på flyvningen du vil velge: 2

Valgt: DY753 fra TRD til OSL den 2025-04-01 (LN-ENU)

Ledige seter for hver delflyvning:
[Liste over flytype, rad og sete]
```

## Endringslogg

1. Opprettet `PrisListe`-klasse for 4NF og enklere prisstyring.  
2. Oppdatert constraints i `DelBillett` slik at billetter kun kan kjøpes for planlagte flyvninger.  
3. Hindret dobbeltbestilling av samme sete på samme segment.  
4. Fjernet triggere; all logikk håndteres i Python-kode.  
5. Endret `flyselskapID` fra `INT` til `VARCHAR(3)` og justerte referanser.  
6. Implementert `AUTOINCREMENT` der nødvendig.  
7. Fokusert på de viktigste constraints; testet og utbedret kjente svakheter.  
8. Fjernet produsentnavn fra `Fly` (allerede i `Flytype`).  
9. `Prisliste` knyttet til både `Delreise` og `Flyrute` via kategori.  
10. Lagt til `DROP TABLE IF EXISTS` i `flydatabase.sql` for reset.

## Filforklaring

- **flydatabase.sql**  
  SQL-skript for å opprette og slette tabeller.  
- **main.py**  
  Hovedprogram som kjører brukerhistoriene.  
- **ExtraFunctions.py**  
  Hjelpefunksjoner for utskrift og datamanipulering.  
- **Brukertilfeller.py**  
  Implementasjon av datainnsatte operasjoner for brukerhistoriene.

## Eksempeldata

- **1,2,3,4,7**: Velg `print` for å vise alle tabeller.  
- **5**: Velg `5` for flyselskap–flytype-oversikt.  
- **6**: Velg `6`, deretter flyplasskode, ukedag og `avganger`/`ankomster`.  
- **8**: Velg `8`, dato (f.eks. `2025-04-01`) og flyvningsnummer.

