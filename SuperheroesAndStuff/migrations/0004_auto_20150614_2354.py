# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('SuperheroesAndStuff', '0003_auto_20150614_1707'),
    ]

    operations = [
        migrations.AddField(
            model_name='appearsin',
            name='charID',
            field=models.ForeignKey(default=0, to='SuperheroesAndStuff.kharacter'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='book',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, default=0, serialize=False, verbose_name='ID'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='creates',
            name='charID',
            field=models.ForeignKey(default=0, to='SuperheroesAndStuff.kharacter'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='creates',
            name='crID',
            field=models.ForeignKey(default=0, to='SuperheroesAndStuff.creator'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='makesup',
            name='charID',
            field=models.ForeignKey(default=0, to='SuperheroesAndStuff.kharacter'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='makesup',
            name='teamID',
            field=models.ForeignKey(default=0, to='SuperheroesAndStuff.team'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='movie',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, default=0, serialize=False, verbose_name='ID'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='participatesin',
            name='charID',
            field=models.ForeignKey(default=0, to='SuperheroesAndStuff.kharacter'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='participatesin',
            name='fightID',
            field=models.ForeignKey(default=0, to='SuperheroesAndStuff.fight'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='tvseries',
            name='id',
            field=models.AutoField(auto_created=True, primary_key=True, default=0, serialize=False, verbose_name='ID'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='book',
            name='mName',
            field=models.ForeignKey(to='SuperheroesAndStuff.distributesMedium'),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='movie',
            name='mName',
            field=models.ForeignKey(to='SuperheroesAndStuff.distributesMedium'),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='tvseries',
            name='mName',
            field=models.ForeignKey(to='SuperheroesAndStuff.distributesMedium'),
            preserve_default=True,
        ),
        migrations.AlterUniqueTogether(
            name='appearsin',
            unique_together=set([('charID', 'mName')]),
        ),
        migrations.AlterUniqueTogether(
            name='creates',
            unique_together=set([('charID', 'crID')]),
        ),
        migrations.AlterUniqueTogether(
            name='makesup',
            unique_together=set([('teamID', 'charID')]),
        ),
        migrations.AlterUniqueTogether(
            name='participatesin',
            unique_together=set([('fightID', 'charID')]),
        ),
    ]
