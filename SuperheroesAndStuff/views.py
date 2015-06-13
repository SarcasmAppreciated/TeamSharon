# from django.http import HttpResponse
from django.shortcuts import render
import sqlite3

def index(request):
    return render(request, 'SuperheroesAndStuff/index.html')


def query_to_string(arg1, arg2, arg3):
    return "SELECT " + arg1 + "FROM " + arg2 + "WHERE " + arg3

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

connection.close()