from django.db import OperationalError
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render
from SuperheroesAndStuff import models
import sqlite3
import json


## Variables coming from UI (with default values):
query_cat = ""

characterIncludeCharName = False
characterIncludeSpecies = False
characterIncludeOriginPlanet = False
characterIncludePersonName = False
characterIncludePower = False
characterPowerString = ""
characterCreatorString = ""
characterDirectedByString = ""

movieIncludeMName = False
movieIncludeTotalRevenue = False
movieIncludeAverageRevenue = False
movieIncludingNameString = ""
movieNameExactlyString = ""

bookIncludeCount = False
bookIncludeAverage = False
bookWithMoreThanXCharacters = 0

deletecharacterCreatorString = ""
deleteCharacterString = ""

updateRevenueValue = 0
updateMovieString = ""


def response(request):
    returnArray = {}
    query_cat = request.GET['query_cat']
    
#    print ("HERE")
#    if ("True"):
#        print("YAY")

    if(query_cat == "character"):
        characterIncludeCharName = request.GET['cname']
        characterIncludeSpecies = request.GET['species']
        characterIncludeOriginPlanet = request.GET['origin']
        characterIncludePersonName = request.GET['aname']
        characterIncludePower = request.GET['powerc']
        characterPowerString = request.GET['power']
        characterCreatorString = request.GET['creator']
        characterDirectedByString = request.GET['director']
    elif (query_cat == "movie"):
        movieIncludeMName = request.GET['m_name']
        movieIncludeTotalRevenue = request.GET['total_rev']
        movieIncludeAverageRevenue = request.GET['avg_rev']
        movieIncludingNameString = request.GET['miname']
        movieNameExactlyString = request.GET['mename']
    elif (query_cat == "book"):
        bookIncludeCount = request.GET['bcount']
        bookIncludeAverage = Frequest.GET['b_avg']
        bookWithMoreThanXCharacters = request.GET['less_than']
    elif (query_cat == "delete"):
        deletecharacterCreatorString = request.GET['d_creator']
        deleteCharacterString = request.GET['d_count']
    elif (query_cat == "update"):
        updateRevenueValue = request.GET['revenue']
        updateMovieString = request.GET['u_movie']
    else:
        err_message = "unknown category"
	
    returnArray = {'items':[{'name':'1'},{'name':'2'}]}


######### Character ##################
    ## Convert 'true' to 'True' and 'false' to 'False':
    cname = cname == 'true'
    species = species == 'true'
    origin = origin == 'true'
    
    ## Declare changes to affect global variables:
    global characterIncludeCharName
    global characterIncludeSpecies
    global characterIncludeOriginPlanet
    global characterIncludePersonName
    global characterIncludePower
    global characterPowerString
    global characterCreatorString
    global characterDirectedByString
    
    ## Set global variables with data from UI:
    characterIncludeCharName = cname
    characterIncludeSpecies = species
    characterIncludeOriginPlanet = origin
    characterIncludePersonName = False
    characterIncludePower = False
    characterPowerString = "Genius"
    characterCreatorString = ""
    characterDirectedByString = ""

#    kharacterRows = executeKharacterQuery()
#    kharacterJsonObject = json.dumps(kharacterRows)
#    #.....
#    for r in kharacterRows:
#        print(r)
#    print(kharacterJsonObject)
#    #....
########################################
    
    
    
########### Movie ######################
    ## Convert 'true' to 'True' and 'false' to 'False':
    #.....
    
    ## Declare changes to affect global variables:
    global movieIncludeMName
    global movieIncludeTotalRevenue
    global movieIncludeAverageRevenue
    global movieIncludingNameString
    global movieNameExactlyString
    
    ## Set global variables with data from UI:
    movieIncludeMName = False
    movieIncludeTotalRevenue = True
    movieIncludeAverageRevenue = False
    movieIncludingNameString = "X-Men"
    movieNameExactlyString = ""

#    movieRows = executeMovieQuery()
#    movieJsonObject = json.dumps(movieRows)
#    #.....
#    for r in movieRows:
#        print(r)
#    print(movieJsonObject)
#    #....
########################################

    

########### Book ######################
    ## Convert 'true' to 'True' and 'false' to 'False':
    #.....

    ## Declare changes to affect global variables:
    global bookIncludeCount
    global bookIncludeAverage
    global bookWithMoreThanXCharacters
    
    ## Set global variables with data from UI:
    bookIncludeCount = True
    bookIncludeAverage = False
    bookWithMoreThanXCharacters = 2

#    bookRows = executeBookQuery()
#    bookJsonObject = json.dumps(bookRows)
#    #.....
#    for r in bookRows:
#        print(r)
#    print(bookJsonObject)
#    #....
########################################



########### DELETE ######################
    ## Convert 'true' to 'True' and 'false' to 'False':
    #.....

    ## Declare changes to affect global variables:
    global deletecharacterCreatorString
    global deleteCharacterString
    
    ## Set global variables with data from UI:
    deletecharacterCreatorString = "Stan Lee"
    deleteCharacterString = ""
    
#    executeDeleteQuery()
########################################
#
#    rows = connection.execute("SELECT charName FROM creates WHERE crName='Stan Lee';")
#    for r in rows:
#        print(r)
#    executeDeleteQuery()
#    rows = connection.execute("SELECT charName FROM creates WHERE crName='Stan Lee';")
#    for r in rows:
#        print(r)

    
    
########### UPDATE ######################
    ## Convert 'true' to 'True' and 'false' to 'False':
    #.....
    
    ## Declare changes to affect global variables:
    global updateRevenueValue
    global updateMovieString
    
    ## Set global variables with data from UI:
    updateRevenueValue = 100
    updateMovieString = "X-Men"
    
#    executeUpdateQuery()
########################################
    
#    rows = connection.execute("SELECT mName, revenue FROM movie WHERE mName='X-Men';")
#    for r in rows:
#        print(r)
#    executeUpdateQuery()
#    rows = connection.execute("SELECT mName, revenue FROM movie WHERE mName='X-Men';")
#    for r in rows:
#        print(r)



    
    return JsonResponse(returnArray, safe=False)

def index(request):
    return render(request, 'SuperheroesAndStuff/index.html')


# Define row format
def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

# Connect to db
connection = sqlite3.connect("db.sqlite3")
connection.row_factory = dict_factory
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


##### kharacter Queries ######################################
def addSelectedFieldsToKharacterQuery(query):
    if (characterIncludeCharName):
        query += " k.charName"
        if (characterIncludePersonName):
            if (characterIncludeCharName):
                query += ","
            query += " k.personName"
    if (characterIncludePower):
        if (characterIncludeCharName | characterIncludePersonName):
            query += ","
            query += " k.power"
    if (characterIncludeSpecies):
        if (characterIncludeCharName | characterIncludePersonName | characterIncludePower):
            query += ","
        query += " k.species"
    if (characterIncludeOriginPlanet):
        if (characterIncludeCharName | characterIncludePersonName | characterIncludePower | characterIncludeOriginPlanet):
            query += ","
        query += " k.originPlanet"
    return query


def makeKharacterQuery():
    if (characterPowerString != ""):
        query = "SELECT"
        query = addSelectedFieldsToKharacterQuery(query)
        query += " FROM kharacter k"
        query += " WHERE k.power LIKE '%"
        query += characterPowerString
        query += "%';"
    elif (characterCreatorString != ""):
        query = "SELECT"
        query = addSelectedFieldsToKharacterQuery(query)
        query += " FROM kharacter k"
        query += " INNER JOIN creates c ON k.charName=c.charName AND k.comicAge=c.charComicAge INNER JOIN creator w ON c.crName=w.fullName AND c.crType=w.variant WHERE w.fullName='"
        query += characterCreatorString
        query += "';"
    elif (characterDirectedByString != ""):
        query = "SELECT"
        query = addSelectedFieldsToKharacterQuery(query)
        query += " FROM kharacter k"
        query += " WHERE NOT EXISTS (SELECT m.mName FROM movie m WHERE m.director='"
        query += characterDirectedByString
        query += "' EXCEPT SELECT DISTINCT m.mName FROM appearsIn a INNER JOIN movie m ON a.mName=m.mName WHERE k.charName=a.charName AND k.comicAge=a.comicAge);"
    else:
        query = ""
    return query

def executeKharacterQuery():
    kharacterQuery = makeKharacterQuery()
    try:
        cursor.execute(kharacterQuery)
        rows = cursor.fetchall()
    except:
        print("Bad Kharacter Query")
    return rows
##############################################################


##### Movie Queries ##########################################

def makeMovieQuery():
    if (movieIncludeMName):
        query = "SELECT m.mName FROM movie m WHERE m.mName"
        if (movieNameExactlyString != ""):
            query += "='"
            query += movieNameExactlyString
            query += "';"
        else:
            query += " LIKE '%"
            query += movieIncludingNameString
            query += "%';"
    elif (movieIncludeTotalRevenue):
        query = "SELECT SUM(m.revenue) FROM movie m WHERE m.mName LIKE "
        query += "'%"
        query += movieIncludingNameString
        query += "%';"
    elif (movieIncludeAverageRevenue):
        query = "SELECT AVG(m.revenue) FROM movie m WHERE m.mName LIKE "
        query += "'%"
        query += movieIncludingNameString
        query += "%';"
    return query

def executeMovieQuery():
    movieQuery = makeMovieQuery()
    try:
        cursor.execute(movieQuery)
        rows = cursor.fetchall()
    except:
        print("Bad Movie Query")
    return rows
##############################################################


##### Book Queries ###########################################
def makeBookCountViewQuery():
    query = "CREATE VIEW counts AS SELECT b.mName AS name, COUNT(k.charName) AS num FROM kharacter k INNER JOIN appearsIn a ON k.charName=a.charName AND k.comicAge=a.comicAge INNER JOIN book b ON a.mName=b.mName GROUP BY k.charName, k.comicAge HAVING COUNT(*) <"
    query += str(bookWithMoreThanXCharacters)
    query += ";"
    print(query)
    return query

def makeBookQuery():
    if (bookIncludeCount):
        query = "SELECT COUNT(*) FROM counts c;"
    if (bookIncludeAverage):
        query = "SELECT AVG(num) FROM counts c;"
    return query

def executeBookQuery():
    bookCountViewQuery = makeBookCountViewQuery()
    bookQuery = makeBookQuery()
    try:
        connection.execute("DROP VIEW IF EXISTS counts;");
        connection.execute(bookCountViewQuery)
        cursor.execute(bookQuery)
        rows = cursor.fetchall()
    except:
        print("Bad Book Query")
    return rows
################################################################



##### Delete Queries ###########################################

def executeDeleteQuery():
    if (deletecharacterCreatorString != ""):
        query = "DELETE FROM creator WHERE fullName='"
        query += deletecharacterCreatorString
        query += "';"
    if (deleteCharacterString != ""):
        query = "DELETE FROM appearsIn WHERE charName='"
        query += deleteCharacterString
        query += "';"
    try:
        connection.execute(query)
    except sqlite3.IntegrityError as e:
        print(e)
    except:
        print("Bad Delete Query")

##############################################################


##### Update Queries ###########################################

def executeUpdateQuery():
    query = "UPDATE movie SET revenue="
    query += str(updateRevenueValue)
    query += " WHERE mName='"
    query += updateMovieString
    query += "';"
    try:
        connection.execute(query)
    except sqlite3.IntegrityError as e:
        print(e)
    except:
        print("Bad Update Query")

##############################################################



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
#
#print("-------------------------------")













