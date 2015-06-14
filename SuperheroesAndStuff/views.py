from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render
import sqlite3

def response(request):	
    return JsonResponse({'foo':'LOL'})

def index(request):
    return render(request, 'SuperheroesAndStuff/index.html')

# if __name__ == '__main__': 
#	response()


def query_to_string(arg1, arg2, arg3):
    return "SELECT * FROM SuperheroesAndStuff_kharacter"

# the following code was adapted from the following source:
# http://www.cdotson.com/2014/06/generating-json-documents-from-sqlite-databases-in-python/
def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d

connection = sqlite3.connect("db.sqlite3")
connection.row_factory = dict_factory

cursor = connection.cursor()
cursor.execute(query_to_string("* ", "SuperheroesAndStuff_kharacter ", "charName = 'Superman'"))

# fetch all or one we'll go for all.
results = cursor.fetchall()
print results
print "Hello"

connection.close()