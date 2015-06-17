from django.db import OperationalError
from django.http import HttpResponse
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
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


def makeBool(b):
    return b == "True"

@csrf_exempt
def response(request):
    returnArray = {}

    if request.method == 'POST' and request.POST:
        query_cat = request.POST['query_cat']
    elif request.method == "GET" and request.GET:
        query_cat = request.GET['query_cat']
    
    print query_cat
    
    global characterIncludeCharName
    global characterIncludeSpecies
    global characterIncludeOriginPlanet
    global characterIncludePersonName
    global characterIncludePower
    global characterPowerString
    global characterCreatorString
    global characterDirectedByString
    global movieIncludeMName
    global movieIncludeTotalRevenue
    global movieIncludeAverageRevenue
    global movieIncludingNameString
    global movieNameExactlyString
    global bookIncludeCount
    global bookIncludeAverage
    global bookWithMoreThanXCharacters
    global deletecharacterCreatorString
    global deleteCharacterString
    global updateRevenueValue
    global updateMovieString


    if(query_cat == "character"):
        characterIncludeCharName = makeBool(request.GET['cname'])
        characterIncludeSpecies = makeBool(request.GET['species'])
        characterIncludeOriginPlanet = makeBool(request.GET['origin'])
        characterIncludePersonName = makeBool(request.GET['aname'])
        characterIncludePower = makeBool(request.GET['powerc'])
        characterPowerString = request.GET['power']
        characterCreatorString = request.GET['creator']
        characterDirectedByString = request.GET['director']
        kharacterRows = executeKharacterQuery()
        returnJson = json.dumps(kharacterRows)
        print returnJson
    elif (query_cat == "movie"):
        movieIncludeMName = makeBool(request.GET['m_name'])
        movieIncludeTotalRevenue = makeBool(request.GET['total_rev'])
        movieIncludeAverageRevenue = makeBool(request.GET['avg_rev'])
        movieIncludingNameString = request.GET['miname']
        movieNameExactlyString = request.GET['mename']
        movieRows = executeMovieQuery()
        returnJson = json.dumps(movieRows)
        print returnJson
    elif (query_cat == "book"):
        bookIncludeCount = makeBool(request.GET['bcount'])
        bookIncludeAverage = makeBool(request.GET['b_avg'])
        bookWithMoreThanXCharacters = request.GET['less_than']
        bookRows = executeBookQuery()
#       cursor.execute("CREATE VIEW counts AS SELECT DISTINCT b.mName AS name, COUNT(k.charName) AS num FROM kharacter k INNER JOIN appearsIn a ON k.charName=a.charName AND k.comicAge=a.comicAge INNER JOIN book b ON a.mName=b.mName GROUP BY k.charName, k.comicAge HAVING COUNT(*) <2;")
        returnJson = json.dumps(bookRows)
        print returnJson
    elif (query_cat == "delete"):
        deletecharacterCreatorString = request.POST['d_creator']
        deleteCharacterString = request.POST['d_count']
        executeDeleteQuery()
        returnJson = {'request':'Sucessful'}
    elif (query_cat == "update"):
        updateRevenueValue = request.POST['revenue']
        updateMovieString = request.POST['u_movie']
        executeUpdateQuery()
        returnJson = {'request':'Sucessful'}
    else:
        err_message = "unknown category"
    
    return JsonResponse(returnJson, safe=False)

def index(request):
    return render(request, 'SuperheroesAndStuff/index.html')


# Define row format
def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

# Connect to db
connection = sqlite3.connect("db.sqlite3", check_same_thread=False)
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
def addSelectedFieldsToKharacterQuery():
    attributes = []
    query = ""
    
    if (characterIncludeCharName):
        attributes.append("k.charName")
    if (characterIncludeSpecies):
        attributes.append("k.species")
    if (characterIncludePersonName):
        attributes.append("k.personName")
    if (characterIncludePower):
        attributes.append("k.power")
    if (characterIncludeOriginPlanet):
        attributes.append("k.originPlanet")

    if (len(attributes) == 0):
        query = "*"
    elif (len(attributes) == 1):
        query = attributes[0]
    else:
        query = attributes[0]
        for a in attributes:
            query += ", "
            query += a
    return query

def makeKharacterQuery():
    query = "SELECT "
    query += addSelectedFieldsToKharacterQuery()
    query += " FROM kharacter k"
    if (characterPowerString != ""):
        query += " WHERE k.power LIKE '%"
        query += characterPowerString
        query += "%'"
    elif (characterCreatorString != ""):
        query += " INNER JOIN creates c ON k.charName=c.charName AND k.comicAge=c.charComicAge INNER JOIN creator w ON c.crName=w.fullName AND c.crType=w.variant WHERE w.fullName='"
        query += characterCreatorString
        query += "'"
    elif (characterDirectedByString != ""):
        query += " WHERE NOT EXISTS (SELECT m.mName FROM movie m WHERE m.director='"
        query += characterDirectedByString
        query += "' EXCEPT SELECT DISTINCT m.mName FROM appearsIn a INNER JOIN movie m ON a.mName=m.mName WHERE k.charName=a.charName AND k.comicAge=a.comicAge)"
    query += ";"
    return query

def executeKharacterQuery():
    kharacterQuery = makeKharacterQuery()
    try:
        cursor.execute(kharacterQuery)
        rows = cursor.fetchall()
    except Exception, msg:
        print msg
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
        query = "SELECT SUM(m.revenue) AS sumMovie FROM movie m WHERE m.mName LIKE "
        query += "'%"
        query += movieIncludingNameString
        query += "%';"
    elif (movieIncludeAverageRevenue):
        query = "SELECT AVG(m.revenue) AS avgMovie FROM movie m WHERE m.mName LIKE "
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
    query = "CREATE VIEW counts AS SELECT DISTINCT b.mName AS name, COUNT(k.charName) AS num FROM kharacter k INNER JOIN appearsIn a ON k.charName=a.charName AND k.comicAge=a.comicAge INNER JOIN book b ON a.mName=b.mName GROUP BY k.charName, k.comicAge HAVING COUNT(*) <"
    query += str(bookWithMoreThanXCharacters)
    query += ";"
    return query

def makeBookQuery():
    if (bookIncludeCount):
        query = "SELECT COUNT(*) AS cBook FROM counts c;"
    elif (bookIncludeAverage):
        query = "SELECT AVG(num) AS avgBook FROM counts c;"
    return query

def executeBookQuery():
    bookCountViewQuery = makeBookCountViewQuery()
    cursor.execute("DROP VIEW IF EXISTS counts;");
    cursor.execute(bookCountViewQuery)
    bookQuery = makeBookQuery()
    try:
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






