import sqlite3
import BrukerTilfeller as bt
import ExtraFunctions as ef
import os
from BrukerTilfeller import tilfelle2

print(tilfelle2)  # Ctrl + Click on tilfelle2 to see the function definition

databaseFile = "Flydatabase.db"

if  os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()

    ef.printTabell(cur, "Flyselskap")
    print("\n \n \n")

    ef.printTabell(cur, "Flytype")
    print("\n \n \n")

    ef.printTabell(cur, "Fly")


    #Vi oppretter nasjonalitet tabell, men kommer ikke fram i tabellene her. 
    #Legge inn en måte å se nasjonalitet på Flyselskap tabellen???
    
    conn.close()

else:
    print("Database file does not exist. initilizing database i flydatabase.py")