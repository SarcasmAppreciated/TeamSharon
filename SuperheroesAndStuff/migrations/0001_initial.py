# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='appearsIn',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('charName', models.CharField(max_length=45)),
                ('comicAge', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='book',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('ISBN', models.CharField(max_length=20)),
                ('author', models.CharField(max_length=45)),
                ('publishDate', models.DateField()),
                ('category', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='creates',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('charName', models.CharField(max_length=45)),
                ('charComicAge', models.CharField(max_length=45)),
                ('crName', models.CharField(max_length=45)),
                ('crType', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='creator',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=45)),
                ('type', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='distributesMedium',
            fields=[
                ('mName', models.CharField(max_length=45, serialize=False, primary_key=True)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='distributor',
            fields=[
                ('name', models.CharField(max_length=45, serialize=False, primary_key=True)),
                ('type', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='fight',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('description', models.CharField(max_length=100)),
                ('comicAge', models.CharField(max_length=45)),
                ('victor', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='kharacter',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=48)),
                ('comicAge', models.CharField(max_length=45)),
                ('personName', models.CharField(max_length=45)),
                ('species', models.CharField(max_length=45)),
                ('alignment', models.CharField(max_length=45)),
                ('gender', models.CharField(max_length=45)),
                ('power', models.CharField(max_length=450)),
                ('originPlanet', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='makesUp',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('teamName', models.CharField(max_length=45)),
                ('teamComicAge', models.CharField(max_length=45)),
                ('charComicAge', models.CharField(max_length=45)),
                ('charName', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='movie',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('director', models.CharField(max_length=45)),
                ('releaseDate', models.DateField()),
                ('isAnimated', models.CharField(max_length=45)),
                ('revenue', models.BigIntegerField()),
                ('mName', models.ForeignKey(to='SuperheroesAndStuff.distributesMedium')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='participatesIn',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('fightDesc', models.CharField(max_length=100)),
                ('fightComicAge', models.CharField(max_length=45)),
                ('charName', models.CharField(max_length=45)),
                ('charComicAge', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='team',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=45)),
                ('comicAge', models.CharField(max_length=45)),
                ('alignment', models.CharField(max_length=45)),
                ('HQ', models.CharField(max_length=45)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='tvSeries',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('initialAirDate', models.DateField()),
                ('director', models.CharField(max_length=45)),
                ('mName', models.ForeignKey(to='SuperheroesAndStuff.distributesMedium')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.AddField(
            model_name='distributesmedium',
            name='distName',
            field=models.ForeignKey(to='SuperheroesAndStuff.distributor'),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='book',
            name='mName',
            field=models.ForeignKey(to='SuperheroesAndStuff.distributesMedium'),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='appearsin',
            name='mName',
            field=models.ForeignKey(to='SuperheroesAndStuff.distributesMedium'),
            preserve_default=True,
        ),
    ]
