from django.db import models

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


class creator(models.Model):
    fullName = models.CharField(max_length=45)
    variant = models.CharField(max_length=45, default='')

    def __unicode__(self):
        return self.fullName

    class Meta:
        unique_together = ("fullName", "variant")
        managed = True


class distributor(models.Model):
    fullName = models.CharField(max_length=45, primary_key=True)
    variant = models.CharField(max_length=45, default='')

    def __unicode__(self):
        return self.fullName

    class Meta:
        managed = True


class fight(models.Model):
    description = models.CharField(max_length=100)
    comicAge = models.CharField(max_length=45)
    victor = models.CharField(max_length=45)

    def __unicode__(self):
        return self.description

    class Meta:
        unique_together = ("description", "comicAge")
        managed = True


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


class distributesMedium(models.Model):
    mName = models.CharField(max_length=45, primary_key=True)
    distName = models.ForeignKey('distributor', null=True)

    def __unicode__(self):
        return self.mName

    class Meta:
        managed = True


class book(models.Model):
    mName = models.ForeignKey('distributesMedium')
    ISBN = models.CharField(max_length=20)
    author = models.CharField(max_length=45)
    publishDate = models.DateField()
    variant = models.CharField(max_length=45, default='')

    def __unicode__(self):
        return self.mName.__unicode__()

    class Meta:
        managed = True


class movie(models.Model):
    mName = models.ForeignKey('distributesMedium')
    director = models.CharField(max_length=45)
    releaseDate = models.DateField()
    isAnimated = models.CharField(max_length=45)
    revenue = models.BigIntegerField()

    def __unicode__(self):
        return self.mName.__unicode__()

    class Meta:
        managed = True


class tvSeries(models.Model):
    mName = models.ForeignKey('distributesMedium')
    initialAirDate = models.DateField()
    director = models.CharField(max_length=45)

    def __unicode__(self):
        return self.mName.__unicode__()

    class Meta:
        managed = True


class creates(models.Model):
    charID = models.ForeignKey('kharacter')
    charName = models.CharField(max_length=45)
    charComicAge = models.CharField(max_length=45)
    crID = models.ForeignKey('creator')
    crName = models.CharField(max_length=45)
    crType = models.CharField(max_length=45)

    def __unicode__(self):
        return self.charName + " " + self.crName

    class Meta:
        unique_together = ("charID", "crID")
        managed = True


class makesUp(models.Model):
    teamID = models.ForeignKey('team')
    teamName = models.CharField(max_length=45)
    teamComicAge = models.CharField(max_length=45)
    charID = models.ForeignKey('kharacter')
    charComicAge = models.CharField(max_length=45)
    charName = models.CharField(max_length=45)

    def __unicode__(self):
        return self.teamName + " " + self.charName

    class Meta:
        unique_together = ("teamID", "charID")
        managed = True


class participatesIn(models.Model):
    fightID = models.ForeignKey('fight')
    fightDesc = models.CharField(max_length=100)
    fightComicAge = models.CharField(max_length=45)
    charID = models.ForeignKey('kharacter')
    charName = models.CharField(max_length=45)
    charComicAge = models.CharField(max_length=45)

    def __unicode__(self):
        return self.fightDesc + " " + self.charName

    class Meta:
        unique_together = ("fightID", "charID")
        managed = True


class appearsIn(models.Model):
    charID = models.ForeignKey('kharacter')
    charName = models.CharField(max_length=45)
    comicAge = models.CharField(max_length=45)
    mName = models.ForeignKey('distributesMedium')

    def __unicode__(self):
        return self.charName + " " + self.mName.__unicode__()

    class Meta:
        unique_together = ("charID", "mName")
        managed = True
