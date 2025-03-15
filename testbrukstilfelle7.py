import sqlite3

def test_brukstilfelle7():
    # Koble til databasen
    conn = sqlite3.connect("Flydatabase.db")
    cur = conn.cursor()
    
    # Sjekk antall bestillinger for WF1302 den 1. april 2025
    cur.execute("""
        SELECT COUNT(*) 
        FROM DelBillett db
        JOIN BillettKjop bk ON db.delAvBilletKjop = bk.referanseNr
        JOIN FaktiskFlyvning ff ON db.Flyrutenummer = ff.flyrutenummer AND db.lopenr = ff.lopenr
        WHERE ff.flyrutenummer = 'WF1302' AND ff.dato = '2025-04-01'
    """)
    antall_bestillinger = cur.fetchone()[0]
    
    # Sjekk antall unike seter for disse bestillingene
    cur.execute("""
        SELECT COUNT(DISTINCT db.BooketradNr || db.Booketsetebokstav)
        FROM DelBillett db
        JOIN FaktiskFlyvning ff ON db.Flyrutenummer = ff.flyrutenummer AND db.lopenr = ff.lopenr
        WHERE ff.flyrutenummer = 'WF1302' AND ff.dato = '2025-04-01'
    """)
    antall_unike_seter = cur.fetchone()[0]
    
    # Lukk databaseforbindelsen
    conn.close()
    
    # Sjekk om testene passerer
    if antall_bestillinger == 10 and antall_unike_seter == 10:
        print("Test for brukstilfelle 7: PASSED")
    else:
        print("Test for brukstilfelle 7: FAILED")
        print(f"Antall bestillinger: {antall_bestillinger}, Antall unike seter: {antall_unike_seter}")



def print_billettkjop_og_seter():
    # Koble til databasen
    conn = sqlite3.connect("Flydatabase.db")
    cur = conn.cursor()
    
    # Hent og print BillettKjop-tabellen
    print("Innhold i BillettKjop-tabellen:")
    cur.execute("SELECT * FROM BillettKjop")
    billettkjop_rows = cur.fetchall()
    for row in billettkjop_rows:
        print(row)
    
    # Hent og print seter fra DelBillett for WF1302 den 1. april 2025
    print("\nSeter reservert for WF1302 den 1. april 2025:")
    cur.execute("""
        SELECT db.billettID, db.BooketradNr, db.Booketsetebokstav, db.Flyrutenummer, ff.dato
        FROM DelBillett db
        JOIN FaktiskFlyvning ff ON db.Flyrutenummer = ff.flyrutenummer AND db.lopenr = ff.lopenr
        WHERE ff.flyrutenummer = 'WF1302' AND ff.dato = '2025-04-01'
    """)
    seter_rows = cur.fetchall()
    for row in seter_rows:
        print(row)
    
    # Lukk databaseforbindelsen
    conn.close()


# Kjør testfunksjonen
#test_brukstilfelle7()


# Kjør funksjonen
print_billettkjop_og_seter()