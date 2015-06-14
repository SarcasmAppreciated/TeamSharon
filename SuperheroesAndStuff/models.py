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
        return self.charName

    class Meta:
        unique_together = ("charName", "comicAge")
        managed = True


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
    variant = models.CharField(max_length=45, default='')

    def __unicode__(self):
        return self.fullName

    class Meta:
        unique_together = ("fullName", "variant")
        managed = True

# creator = Table('creator', metadata,
#                 Column('fullName', String(45), primary_key=True),
#                 Column('category', String(45), primary_key=True)
#                 )


class distributor(models.Model):
    fullName = models.CharField(max_length=45, primary_key=True)
    variant = models.CharField(max_length=45, default='')

    def __unicode__(self):
        return self.fullName

    class Meta:
        managed = True

# distributor = Table('distributor', metadata,
#                     Column('fullName', String(45), primary_key=True),
#                     Column('category', String(45))
#                     )


class fight(models.Model):
    description = models.CharField(max_length=100)
    comicAge = models.CharField(max_length=45)
    victor = models.CharField(max_length=45)

    def __unicode__(self):
        return self.description

    class Meta:
        unique_together = ("description", "comicAge")
        managed = True

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

    def __unicode__(self):
        return self.teamName

    class Meta:
        unique_together = ("teamName", "comicAge")
        managed = True

# team = Table('team', metadata,
#              Column('teamName', String(45), primary_key=True),
#              Column('comicAge', String(45), primary_key=True),
#              Column('alignment', String(45)),
#              Column('HQ', String(45))
#              )


class distributesMedium(models.Model):
    mName = models.CharField(max_length=45, primary_key=True)
    distName = models.ForeignKey(distributor, null=True)

    def __unicode__(self):
        return self.mName

    class Meta:
        managed = True

# distributesMedium = Table('distributesMedium', metadata,
#                           Column('mName', String(45), primary_key=True),
#                           Column('distName', String(45), ForeignKey('distributor.fullName',
#                                  onupdate="CASCADE", ondelete="CASCADE"))
#                           )


class book(models.Model):
    mName = models.ForeignKey(distributesMedium, primary_key=True)
    ISBN = models.CharField(max_length=20)
    author = models.CharField(max_length=45)
    publishDate = models.DateField()
    variant = models.CharField(max_length=45, default='')

    def __unicode__(self):
        return self.mName

    class Meta:
        managed = True


# book = Table('book', metadata,
#              Column('mName', String(45), ForeignKey('distrbutesMedium.mName', onupdate="CASCADE", ondelete="CASCADE"),
#                     primary_key=True),
#              Column('ISBN', String(45)),
#              Column('author', String(45), nullable=False),
#              Column('publishDate', DateTime),
#              Column('category', String(45))
#              )


class movie(models.Model):
    mName = models.ForeignKey(distributesMedium, primary_key=True)
    director = models.CharField(max_length=45)
    releaseDate = models.DateField()
    isAnimated = models.CharField(max_length=45)
    revenue = models.BigIntegerField()

    def __unicode__(self):
        return self.mName

    class Meta:
        managed = True

# movie = Table('movie', metadata,
#               Column('mName', String(45), ForeignKey('distrbutesMedium.mName', onupdate="CASCADE", ondelete="CASCADE"),
#                      primary_key=True),
#               Column('director', String(45)),
#               Column('releaseDate', DateTime),
#               Column('isAnimated', String(10)),
#               Column('revenue', Integer)
#               )


class tvSeries(models.Model):
    mName = models.ForeignKey(distributesMedium, primary_key=True)
    initialAirDate = models.DateField()
    director = models.CharField(max_length=45)

    def __unicode__(self):
        return self.mName

    class Meta:
        managed = True

# tvSeries = Table('tvSeries', metadata,
#                  Column('mName', String(45), ForeignKey('distrbutesMedium.mName', onupdate="CASCADE", ondelete="CASCADE"),
#                         primary_key=True),
#                  Column('initialAirDate', DateTime),
#                  Column('director', String(45)),
#                  )


class creates(models.Model):
    charID = models.ForeignKey(kharacter)
    charName = models.CharField(max_length=45)
    charComicAge = models.CharField(max_length=45)
    crID = models.ForeignKey(creator)
    crName = models.CharField(max_length=45)
    crType = models.CharField(max_length=45)

    def __unicode__(self):
        return self.charName + " " + self.crName

    class Meta:
        unique_together = ("charID", "crID")
        managed = True

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
    teamID = models.ForeignKey(team)
    teamName = models.CharField(max_length=45)
    teamComicAge = models.CharField(max_length=45)
    charID = models.ForeignKey(kharacter)
    charComicAge = models.CharField(max_length=45)
    charName = models.CharField(max_length=45)

    def __unicode__(self):
        return self.teamName + " " + self.charName

    class Meta:
        unique_together = ("teamID", "charID")
        managed = True

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
    fightID = models.ForeignKey(fight)
    fightDesc = models.CharField(max_length=100)
    fightComicAge = models.CharField(max_length=45)
    charID = models.ForeignKey(kharacter)
    charName = models.CharField(max_length=45)
    charComicAge = models.CharField(max_length=45)

    def __unicode__(self):
        return self.fightDesc + " " + self.charName

    class Meta:
        unique_together = ("fightID", "charID")
        managed = True

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
    charID = models.ForeignKey(kharacter)
    charName = models.CharField(max_length=45)
    comicAge = models.CharField(max_length=45)
    mName = models.ForeignKey(distributesMedium, null=True)

    def __unicode__(self):
        return self.charName + " " + self.mName

    class Meta:
        unique_together = ("charID", "mName")
        managed = True

# appearsIn = Table('appearsIn', metadata,
#                   Column('charName', String(45), primary_key=True),
#                   Column('comicAge', String(45), primary_key=True),
#                   Column('mName', String(45), ForeignKey('distributesMedia.mName'), primary_key=True),
#                   ForeignKeyConstraint(['charName', 'comicAge'], ['kharacter.charName', 'kharacter.comicAge'],
#                                        onupdate="CASCADE", ondelete="CASCADE")
#                   )
