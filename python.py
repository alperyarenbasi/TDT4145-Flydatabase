import sqlite3
con = sqlite3.connect('flydatabaser.db')
#CRUD: Create, Read, Update, Delete
#Create data into the databse 


cur.execute("SELECT * FROM Airlines WHERE name = ?")
print(cur.fetchall())

#INNER JOIN operation 
cur.execute("SELECT * FROM Airlines INNER JOIN Airports ON Airlines.flyfrom = Airports.airportid")
print(cur.fetchall())

#Bruk forskjellige typer kunnskaper 


con.close()