import sqlite3
import ExtraFunctions as ef
import os
from BrukerTilfeller import tilfelle5  # Ctrl + Click on tilfelle6 to see the function definition


databaseFile = "Flydatabase.db"

if  os.path.exists(databaseFile):
    conn = sqlite3.connect(databaseFile)
    cur = conn.cursor()

    tilfelle5(cur)

else:
    print("Database file does not exist. initilizing database i flydatabase.py")