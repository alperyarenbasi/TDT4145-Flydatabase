import sqlite3
import ExtraFunctions as ef
import os
from BrukerTilfeller import tilfelle4 

print(tilfelle4)  # Ctrl + Click on tilfelle4 to see the function definition


databaseFile = "Flydatabase.db"

if  os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()

    ef.printTabell(cur, "FaktiskFlyvning")
    print("\n \n \n")

    ef.printTabell(cur, "FlyvningSegment")
    print("\n \n \n")


    conn.close()

else:
    print("Database file does not exist. initilizing database i flydatabase.py")