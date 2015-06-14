from django.db import OperationalError
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render
from SuperheroesAndStuff import models
import sqlite3
	
def response(request):
	data = {}
	data = request.GET['name']
	return HttpResponse(data)

def index(request):
    return render(request, 'SuperheroesAndStuff/index.html')

# if __name__ == '__main__': 
#	response()


# def query_to_string(arg1, arg2, arg3):
#     return "SELECT * FROM SuperheroesAndStuff_kharacter WHERE charName = 'Superman'"
#
# # the following code was adapted from the following source:
# # http://www.cdotson.com/2014/06/generating-json-documents-from-sqlite-databases-in-python/
# def dict_factory(cursor, row):
#     d = {}
#     for idx, col in enumerate(cursor.description):
#         d[col[0]] = row[idx]
#     return d
#
connection = sqlite3.connect("db.sqlite3")
# connection.row_factory = dict_factory

cursor = connection.cursor()
# Open and read the file as a single buffer
fd = open('Superheroes.sql', 'r')
sqlFile = fd.read()
fd.close()

# all SQL commands (split on ';')
sqlCommands = sqlFile.split(';')

# Execute every command from the input file
for command in sqlCommands:
    # This will skip and report errors
    # For example, if the tables do not yet exist, this will skip over
    # the DROP TABLE commands
    try:
        connection.execute(command)
    except OperationalError, msg:
        print "Command skipped: ", msg

# fetch all or one we'll go for all.
results = cursor.fetchall()

print "Hello"

connection.close()