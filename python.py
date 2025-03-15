import sqlite3
con = sqlite3.connect()
cur = con.cursor()
cur.execute('CREATE TABLE Airlines (flyid INTEGER PRIMARY KEY, flytype TEXT, flytime TEXT, flydate TEXT, flyfrom TEXT, flyto TEXT, flyprice INTEGER)')

#CRUD: Create, Read, Update, Delete
#Create data into the databse 


cur.execute("""
Insert 
""")

cur.execute("SELECT * FROM Airlines WHERE name = ?")
print(cur.fetchall())

#INNER JOIN operation 
cur.execute("SELECT * FROM Airlines INNER JOIN Airports ON Airlines.flyfrom = Airports.airportid")
print(cur.fetchall())

#Bruk forskjellige typer kunnskaper 


con.close()