# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('SuperheroesAndStuff', '0002_auto_20150614_1645'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='book',
            name='id',
        ),
        migrations.RemoveField(
            model_name='movie',
            name='id',
        ),
        migrations.RemoveField(
            model_name='tvseries',
            name='id',
        ),
        migrations.AlterField(
            model_name='book',
            name='mName',
            field=models.ForeignKey(primary_key=True, default='', serialize=False, to='SuperheroesAndStuff.distributesMedium'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='movie',
            name='mName',
            field=models.ForeignKey(primary_key=True, default='', serialize=False, to='SuperheroesAndStuff.distributesMedium'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='tvseries',
            name='mName',
            field=models.ForeignKey(primary_key=True, default='', serialize=False, to='SuperheroesAndStuff.distributesMedium'),
            preserve_default=False,
        ),
    ]
