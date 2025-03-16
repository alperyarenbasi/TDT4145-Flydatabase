import sqlite3
import ExtraFunctions as ef
import os
from BrukerTilfeller import tilfelle1 

print(tilfelle1)  # Ctrl + Click on tilfelle1 to see the function definition

databaseFile = "Flydatabase.db"

if  os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()

    ef.printTabell(cur, "Flyplass")
    
    
    conn.close()

else:
    print("Database file does not exist. initilizing database i flydatabase.py")