import sqlite3
con = sqlite3.connect('flydatabaser.db')
cur = con.cursor()
cur.execute('CREATE TABLE Airlines (flyid INTEGER PRIMARY KEY, flytype TEXT, flytime TEXT, flydate TEXT, flyfrom TEXT, flyto TEXT, flyprice INTEGER)')