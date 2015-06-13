from django.conf.urls import patterns, url
from SuperheroesAndStuff import views

urlpatterns = patterns('',
        url(r'^$', views.index, name='index'),
		url(r'^response/$', views.response, name="response")
		)
