import sqlite3
import BrukerTilfeller as bt
import ExtraFunctions as ef
import os

databaseFile = "Flydatabase.db"
if not os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()
    ef.run_sql_script("Flydatabase.sql", cur, conn)
else:
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()

cur.execute("PRAGMA foreign_keys = ON;")
conn.autocommit = False






bt.tilfelle1(cur)

bt.tilfelle2(cur)

ef.generate_seats(cur) 

bt.tilfelle3(cur)
bt.tilfelle4(cur)
bt.tilfelle5(cur)

bt.tilfelle7(cur)
ef.printTabell(cur, "DelBillett")  # Viser innholdet i tabellen Flyselskap

# ef.printAllTables(cur)  # Viser innholdet i alle tabeller


# run_sql_script("brukstilfelle4.sql", cur, conn)
# run_sql_script("brukstilfelle5.sql", cur, conn)
# run_sql_script("brukstilfelle7.sql", cur, conn)




#Lukker databasen
conn.close()
