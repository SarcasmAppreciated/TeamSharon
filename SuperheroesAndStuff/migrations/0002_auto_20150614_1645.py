# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('SuperheroesAndStuff', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='appearsin',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='book',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='creates',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='creator',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='distributesmedium',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='distributor',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='fight',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='kharacter',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='makesup',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='movie',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='participatesin',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='team',
            options={'managed': True},
        ),
        migrations.AlterModelOptions(
            name='tvseries',
            options={'managed': True},
        ),
        migrations.AlterUniqueTogether(
            name='appearsin',
            unique_together=set([('charName', 'comicAge', 'mName')]),
        ),
        migrations.AlterUniqueTogether(
            name='creates',
            unique_together=set([('charName', 'charComicAge', 'crName', 'crType')]),
        ),
        migrations.AlterUniqueTogether(
            name='creator',
            unique_together=set([('fullName', 'variant')]),
        ),
        migrations.AlterUniqueTogether(
            name='fight',
            unique_together=set([('description', 'comicAge')]),
        ),
        migrations.AlterUniqueTogether(
            name='kharacter',
            unique_together=set([('charName', 'comicAge')]),
        ),
        migrations.AlterUniqueTogether(
            name='makesup',
            unique_together=set([('teamName', 'teamComicAge', 'charName', 'charComicAge')]),
        ),
        migrations.AlterUniqueTogether(
            name='participatesin',
            unique_together=set([('fightDesc', 'fightComicAge', 'charName', 'charComicAge')]),
        ),
        migrations.AlterUniqueTogether(
            name='team',
            unique_together=set([('teamName', 'comicAge')]),
        ),
    ]
