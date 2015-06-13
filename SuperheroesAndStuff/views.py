from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render
	
def response(request):	
	return JsonResponse({'foo':'LOL'})

def index(request):
    return render(request, 'SuperheroesAndStuff/index.html')
	
# if __name__ == '__main__': 
#	response()

