import sqlite3
import BrukerTilfeller as bt
import ExtraFunctions as ef
import os
from BrukerTilfeller import tilfelle3 

print(tilfelle3)  # Ctrl + Click on tilfelle3 to see the function definition

databaseFile = "Flydatabase.db"

if  os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()

    ef.printTabell(cur, "Flyrute")
    print("\n \n \n")

    ef.printTabell(cur, "Delreise")
    print("\n \n \n")

    ef.printTabell(cur, "Prisliste")

    conn.close()

else:
    print("Database file does not exist. initilizing database i flydatabase.py")

