import sqlite3

def hent_flyplasser(cursor):
    """
    Henter en liste over flyplassnavn fra tabellen Flyplass.
    Forutsetter at tabellen Flyplass har en kolonne 'navn'.
    """
    cursor.execute("SELECT navn FROM Flyplass")
    return [row[0] for row in cursor.fetchall()]

def vis_flyplasser(airports):
    print("Tilgjengelige flyplasser:")
    for idx, airport in enumerate(airports, start=1):
        print(f"{idx}. {airport}")

def main():
    # Koble til databasen
    conn = sqlite3.connect("Flydatabase.db")
    cur = conn.cursor()
    
    # Hent og vis tilgjengelige flyplasser
    flyplasser = hent_flyplasser(cur)
    if not flyplasser:
        print("Ingen flyplasser funnet i databasen.")
        return
    vis_flyplasser(flyplasser)
    
    # La brukeren velge flyplass
    valg = input("Velg flyplassnummer (eller skriv navnet direkte): ").strip()
    if valg.isdigit():
        index = int(valg) - 1
        if index < 0 or index >= len(flyplasser):
            print("Ugyldig valg.")
            return
        valgt_flyplass = flyplasser[index]
    else:
        valgt_flyplass = valg
    
    # Spør om ukedag og interesse (avganger eller ankomster)
    ukedag = input("Oppgi ukedag (f.eks. mandag, tirsdag, ...): ").strip().lower()
    interesse = input("Er du interessert i 'avganger' eller 'ankomster'? ").strip().lower()
    
    # Bygg spørringen ut fra brukerens valg.
    # Her forutsettes at det finnes en tabell Flyrute med feltene:
    # - rutenummer, ukedag, avgangstid, ankomsttid, 
    #   og at det finnes en relasjonstabell RuteFlyplass med flyplassene ruten besøker.
    #
    # Det antas også at flyruten har et felt som indikerer hvilken flyplass
    # som er avgangs- (f.eks. avgangsflyplass) eller ankomstflyplass (f.eks. ankomstflyplass).
    
    if interesse == "avganger":
        sql = """
            SELECT f.rutenummer, f.avgangstid,
                   GROUP_CONCAT(r.flyplass, ' -> ') AS stopp
            FROM Flyrute f
            JOIN RuteFlyplass r ON f.rutenummer = r.rutenummer
            WHERE f.avgangsflyplass = ?
              AND lower(f.ukedag) = ?
            GROUP BY f.rutenummer, f.avgangstid
        """
        tid_label = "Avgangstid"
    elif interesse == "ankomster":
        sql = """
            SELECT f.rutenummer, f.ankomsttid,
                   GROUP_CONCAT(r.flyplass, ' -> ') AS stopp
            FROM Flyrute f
            JOIN RuteFlyplass r ON f.rutenummer = r.rutenummer
            WHERE f.ankomstflyplass = ?
              AND lower(f.ukedag) = ?
            GROUP BY f.rutenummer, f.ankomsttid
        """
        tid_label = "Ankomsttid"
    else:
        print("Ugyldig valg. Skriv 'avganger' eller 'ankomster'.")
        conn.close()
        return

    # Utfør spørringen med brukerens valg som parametre
    cur.execute(sql, (valgt_flyplass, ukedag))
    flyruter = cur.fetchall()

    if flyruter:
        print(f"\nFlyruter for {valgt_flyplass} på {ukedag}:")
        for rute in flyruter:
            rutenummer, tid, stopp = rute
            print(f"Rutenummer: {rutenummer} | {tid_label}: {tid} | Flyplasser: {stopp}")
    else:
        print("Ingen flyruter funnet for dine kriterier.")
    
    conn.close()

if __name__ == '__main__':
    main()
