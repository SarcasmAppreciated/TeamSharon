from django.db import models
from sqlalchemy import *

metadata = MetaData()

# Create your models here.

class kharacter(models.Model):
    charName = models.CharField(max_length=48)
    comicAge = models.CharField(max_length=45)
    personName = models.CharField(max_length=45)
    species = models.CharField(max_length=45)
    alignment = models.CharField(max_length=45)
    gender = models.CharField(max_length=45)
    power = models.CharField(max_length=450)
    originPlanet = models.CharField(max_length=45)

    def __unicode__(self):
        return self.name

# kharacter = Table('kharacter', metadata,
#                   Column('charName', String(48), primary_key=True),
#                   Column('comicAge', String(45), primary_key=True),
#                   Column('personName', String(45)),
#                   Column('species', String(20)),
#                   Column('alignment', String(45)),
#                   Column('gender', String(45)),
#                   Column('power', String(450)),
#                   Column('originPlanet', String(45))
#                   )


class creator(models.Model):
    fullName = models.CharField(max_length=45)
    category = models.CharField(max_length=45)

# creator = Table('creator', metadata,
#                 Column('fullName', String(45), primary_key=True),
#                 Column('category', String(45), primary_key=True)
#                 )


class distributor(models.Model):
    fullName = models.CharField(max_length=45, primary_key=True)
    category = models.CharField(max_length=45)

# distributor = Table('distributor', metadata,
#                     Column('fullName', String(45), primary_key=True),
#                     Column('category', String(45))
#                     )


class fight(models.Model):
    description = models.CharField(max_length=100)
    comicAge = models.CharField(max_length=45)
    victor = models.CharField(max_length=45)

# fight = Table('fight', metadata,
#               Column('description', String(100), primary_key=True),
#               Column('comicAge', String(45), primary_key=True),
#               Column('victor', String(45))
#               )


class team(models.Model):
    teamName = models.CharField(max_length=45)
    comicAge = models.CharField(max_length=45)
    alignment = models.CharField(max_length=45)
    HQ = models.CharField(max_length=45)

# team = Table('team', metadata,
#              Column('teamName', String(45), primary_key=True),
#              Column('comicAge', String(45), primary_key=True),
#              Column('alignment', String(45)),
#              Column('HQ', String(45))
#              )


class distributesMedium(models.Model):
    mName = models.CharField(max_length=45, primary_key=True)
    distName = models.ForeignKey(distributor)

# distributesMedium = Table('distributesMedium', metadata,
#                           Column('mName', String(45), primary_key=True),
#                           Column('distName', String(45), ForeignKey('distributor.fullName',
#                                  onupdate="CASCADE", ondelete="CASCADE"))
#                           )


class book(models.Model):
    mName = models.ForeignKey(distributesMedium)
    ISBN = models.CharField(max_length=20)
    author = models.CharField(max_length=45)
    publishDate = models.DateField()
    category = models.CharField(max_length=45)

# book = Table('book', metadata,
#              Column('mName', String(45), ForeignKey('distrbutesMedium.mName', onupdate="CASCADE", ondelete="CASCADE"),
#                     primary_key=True),
#              Column('ISBN', String(45)),
#              Column('author', String(45), nullable=False),
#              Column('publishDate', DateTime),
#              Column('category', String(45))
#              )


class movie(models.Model):
    mName = models.ForeignKey(distributesMedium)
    director = models.CharField(max_length=45)
    releaseDate = models.DateField()
    isAnimated = models.CharField(max_length=45)
    revenue = models.BigIntegerField()

# movie = Table('movie', metadata,
#               Column('mName', String(45), ForeignKey('distrbutesMedium.mName', onupdate="CASCADE", ondelete="CASCADE"),
#                      primary_key=True),
#               Column('director', String(45)),
#               Column('releaseDate', DateTime),
#               Column('isAnimated', String(10)),
#               Column('revenue', Integer)
#               )


class tvSeries(models.Model):
    mName = models.ForeignKey(distributesMedium)
    initialAirDate = models.DateField()
    director = models.CharField(max_length=45)

# tvSeries = Table('tvSeries', metadata,
#                  Column('mName', String(45), ForeignKey('distrbutesMedium.mName', onupdate="CASCADE", ondelete="CASCADE"),
#                         primary_key=True),
#                  Column('initialAirDate', DateTime),
#                  Column('director', String(45)),
#                  )


class creates(models.Model):
    charName = models.CharField(max_length=45)
    charComicAge = models.CharField(max_length=45)
    crName = models.CharField(max_length=45)
    crType = models.CharField(max_length=45)

# creates = Table('creates', metadata,
#                 Column('charName', String(45), primary_key=True),
#                 Column('charComicAge', String(45), primary_key=True),
#                 Column('crName', String(45), primary_key=True),
#                 Column('crType', String(45), primary_key=True),
#                 ForeignKeyConstraint(['charName', 'charComicAge'], ['kharacter.charName', 'kharacter.comicAge'],
#                                      onupdate="CASCADE", ondelete="CASCADE"),
#                 ForeignKeyConstraint(['crName', 'crType'], ['creator.fullName', 'creator.category'],
#                                      onupdate="CASCADE", ondelete="CASCADE")
#                 )


class makesUp(models.Model):
    teamName = models.CharField(max_length=45)
    teamComicAge = models.CharField(max_length=45)
    charComicAge = models.CharField(max_length=45)
    charName = models.CharField(max_length=45)

# makesUp = Table('makesUp', metadata,
#                 Column('teamName', String(45), primary_key=True),
#                 Column('teamComicAge', String(45), primary_key=True),
#                 Column('charComicAge', String(45), primary_key=True),
#                 Column('charName', String(45), primary_key=True),
#                 ForeignKeyConstraint(['teamName', 'teamComicAge'], ['team.name', 'team.comicAge'],
#                                      onupdate="CASCADE", ondelete="CASCADE"),
#                 ForeignKeyConstraint(['charName', 'charComicAge'], ['kharacter.charName', 'kharacter.comicAge'],
#                                      onupdate="CASCADE", ondelete="CASCADE"),
#                 )


class participatesIn(models.Model):
    fightDesc = models.CharField(max_length=100)
    fightComicAge = models.CharField(max_length=45)
    charName = models.CharField(max_length=45)
    charComicAge = models.CharField(max_length=45)

# participatesIn = Table('participatesIn', metadata,
#                        Column('fightDesc', String(45), primary_key=True),
#                        Column('fightComicAge', String(45), primary_key=True),
#                        Column('charName', String(45), primary_key=True),
#                        Column('charComicAge', String(45), primary_key=True),
#                        ForeignKeyConstraint(['fightDesc', 'fightComicAge'], ['fight.description', 'fight.comicAge'],
#                                             onupdate="CASCADE", ondelete="CASCADE"),
#                        ForeignKeyConstraint(['charName', 'charComicAge'], ['kharacter.charName', 'kharacter.comicAge'],
#                                             onupdate="CASCADE", ondelete="CASCADE"),
#                        )


class appearsIn(models.Model):
    charName = models.CharField(max_length=45)
    comicAge = models.CharField(max_length=45)
    mName = models.ForeignKey(distributesMedium)

# appearsIn = Table('appearsIn', metadata,
#                   Column('charName', String(45), primary_key=True),
#                   Column('comicAge', String(45), primary_key=True),
#                   Column('mName', String(45), ForeignKey('distributesMedia.mName'), primary_key=True),
#                   ForeignKeyConstraint(['charName', 'comicAge'], ['kharacter.charName', 'kharacter.comicAge'],
#                                        onupdate="CASCADE", ondelete="CASCADE")
#                   )