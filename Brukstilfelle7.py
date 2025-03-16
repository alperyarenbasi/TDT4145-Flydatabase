import sqlite3
import ExtraFunctions as ef
import os
from BrukerTilfeller import tilfelle7

print(tilfelle7)  # Ctrl + Click on tilfelle7 to see the function definition



databaseFile = "Flydatabase.db"

if  os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()

    ef.printTabell(cur, "BillettKjop")
    print("\n \n \n")
    ef.printTabell(cur, "DelBillett")


else:
    print("Database file does not exist. initilizing database i flydatabase.py")