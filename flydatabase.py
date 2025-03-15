import sqlite3
import BrukerTilfeller as bt
import ExtraFunctions as ef
import os

#Filenavn for SQLite-databasen
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
#bt.tilfelle6(cur) Implementer denne. Løs evt i egen fil.
bt.tilfelle7(cur)
# opg 8 er gjort tror jeg. Tror den er i BrukerTilfeller.py


ef.printTabell(cur, "Fly")

conn.close()
