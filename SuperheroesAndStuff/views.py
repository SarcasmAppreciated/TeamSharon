from django.db import OperationalError
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render
from SuperheroesAndStuff import models
import sqlite3

def response(request):
    returnArray = {}
    cname = request.GET['cname']
    species = request.GET['species']
    origin = request.GET['origin']
    #returnArray = {'name': cname, 'species':species, 'origin':origin}
    returnArray = {'items':[{'name':'1'},{'name':'2'}]}
    return JsonResponse(returnArray, safe=False)

def index(request):
    return render(request, 'SuperheroesAndStuff/index.html')

# if __name__ == '__main__': 
#	response()

#
#def query_to_string(arg1, arg2, arg3):
#
# # the following code was adapted from the following source:
# # http://www.cdotson.com/2014/06/generating-json-documents-from-sqlite-databases-in-python/
# def dict_factory(cursor, row):
#     d = {}
#     for idx, col in enumerate(cursor.description):
#         d[col[0]] = row[idx]
#     return d
#
# connection.row_factory = dict_factory



connection = sqlite3.connect("db.sqlite3")
cursor = connection.cursor()

# Open and read the file as a single buffer
fd = open('Superheroes.sql', 'r')
sqlFile = fd.read()
fd.close()

# all SQL commands (split on ';')
sqlCommands = sqlFile.split(';')

# Execute every command from the input file
for command in sqlCommands:
    connection.execute(command)

#rows = connection.execute("SELECT * FROM kharacter;")
#for r in rows:
#    print("r")
#    print(r)

#rows = connection.execute("SELECT * FROM kharacter WHERE charName = 'Superman';")
#for r in rows:
#    print("r")
#    print(r)


##...........
## Coming from UI:
includeCharName = True
includePersonName = False
includePower = False
includeSpecies = True
includeOriginPlanet = False

filterPower = True
powerString = "Genius"

filterCreator = False
creatorString = "Stan Lee"

filterDirectedBy = False
directedByString = "Bryan Singer"
##...........



def addSelectedFieldsToKharacterQuery(query):
    if (includeCharName):
        query += " k.charName"
        if (includePersonName):
            if (includeCharName):
                query += ","
            query += " k.personName"
    if (includePower):
        if (includeCharName | includePersonName):
            query += ","
            query += " k.power"
    if (includeSpecies):
        if (includeCharName | includePersonName | includePower):
            query += ","
        query += " k.species"
    if (includeOriginPlanet):
        if (includeCharName | includePersonName | includePower | includeOriginPlanet):
            query += ","
        query += " k.originPlanet"
    return query


def makeKharacterQuery():
    if (filterPower):
        query = "SELECT"
        query = addSelectedFieldsToKharacterQuery(query)
        query += " FROM kharacter k"
        query += " WHERE k.power LIKE '%"
        query += powerString
        query += "%';"
    if (filterCreator):
        query = "SELECT"
        query = addSelectedFieldsToKharacterQuery(query)
        query += " FROM kharacter k"
        query += " INNER JOIN creates c ON k.charName=c.charName AND k.comicAge=c.charComicAge INNER JOIN creator w ON c.crName=w.fullName AND c.crType=w.variant WHERE w.fullName='"
        query += creatorString
        query += "';"
    if (filterDirectedBy):
        query = "SELECT"
        query = addSelectedFieldsToKharacterQuery(query)
        query += " FROM kharacter k"
        query += " WHERE NOT EXISTS (SELECT m.mName FROM movie m WHERE m.director='"
        query += directedByString
        query += " EXCEPT SELECT DISTINCT m.mName FROM appearsIn a INNER JOIN movie m ON a.mName=m.mName WHERE k.charName=a.charName AND k.comicAge=a.comicAge);"
    return query



kharacterQuery = makeKharacterQuery()
rows = connection.execute(kharacterQuery)
for r in rows:
    print(r)

#1.	Display the name and the person name of all characters that are geniuses.
#print("-------------------------------")
#rows1 = connection.execute("SELECT k.charName, k.personName, k.power FROM kharacter k WHERE k.power LIKE '%Genius%';")
#rows1 = connection.execute(query1)
#for r in rows1:
#    print(r)
#
#2.	Find the names and species of all the characters created by Stan Lee.
#print("-------------------------------")
#rows2 = connection.execute("SELECT k.charName, k.species FROM kharacter k INNER JOIN creates c ON k.charName=c.charName AND k.comicAge=c.charComicAge INNER JOIN creator w ON c.crName=w.fullName AND c.crType=w.variant WHERE w.fullName='Stan Lee';")
#rows2 = connection.execute(query2)
#for r in rows2:
#    print(r)
#
##3.	Find the person names of all characters who appeared in all movies directed by Brian Singer.
#print("-------------------------------")
#rows3 = connection.execute("SELECT k.personName FROM kharacter k WHERE NOT EXISTS (SELECT m.mName FROM movie m WHERE m.director='Bryan Singer' EXCEPT SELECT DISTINCT m.mName FROM appearsIn a INNER JOIN movie m ON a.mName=m.mName WHERE k.charName=a.charName AND k.comicAge=a.comicAge);")
#for r in rows3:
#    print(r)
#
##4.	Find the total revenue of all the X-Men movies (i.e. the movie has X-Men in the title).
#print("-------------------------------")
#rows4 = connection.execute("SELECT SUM(m.revenue) FROM movie m WHERE m.mName LIKE '%X-Men%';")
#for r in rows4:
#    print(r)
#
##5.	Among comic books with at least 2 characters, find the one with the largest number of characters appearing in it.
#print("-------------------------------")
#connection.execute("DROP VIEW IF EXISTS counts;")
#connection.execute("CREATE VIEW counts AS SELECT b.mName AS name, COUNT (k.charName) AS num FROM kharacter k INNER JOIN appearsIn a ON k.charName = a.charName AND k.comicAge=a.comicAge INNER JOIN book b ON a.mName=b.mName GROUP BY k.charName, k.comicAge HAVING COUNT (k.charName) > 1;")
#rows5 = connection.execute("SELECT c.name, MAX (c.num) FROM counts c;")
##rows5 = connection.execute("SELECT c.name FROM counts c;")
#for r in rows5:
#    print(r)
#
#
##6.	Delete Stan Lee from database.
#print("-------------------------------")
#rows6 = connection.execute("SELECT * FROM creator ORDER BY fullName;")
#for r in rows6:
#    print(r)
#print("- - - ")
#connection.execute("DELETE FROM creator WHERE fullName='Stan Lee';")
#rows6 = connection.execute("SELECT * FROM creator ORDER BY fullName;")
#for r in rows6:
#    print(r)
#
#
##7.	Subtract 1 billion from the revenues of all movies (fails). Subtract 1 million from the revenues of all movies (succeeds).
#print("-------------------------------")
#rows7 = connection.execute("SELECT revenue FROM movie ORDER BY revenue;")
#for r in rows7:
#    print(r)
#print("- - - ")
#try:
#    connection.execute("UPDATE movie SET Revenue=revenue-1000000000;")
#    rows7 = connection.execute("SELECT revenue FROM movie ORDER BY revenue;")
#    for r in rows7:
#        print(r)
#except sqlite3.IntegrityError as e:
#    print(e)
#print("- - - ")
#connection.execute("UPDATE movie SET Revenue=revenue-1000000;")
#rows7 = connection.execute("SELECT revenue FROM movie ORDER BY revenue;")
#for r in rows7:
#    print(r)
#
#
#
#
#rowsx = connection.execute("SELECT * FROM appearsIn;")
##rowsx = connection.execute("SELECT DISTINCT a.mName FROM appearsIn a, book b WHERE a.mName=b.mName;")
##### ? Returns : (u'The Superman Chronicles: Volume 2',)
#for r in rowsx:
#    print(r)

print("-------------------------------")















