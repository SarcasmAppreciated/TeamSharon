# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('SuperheroesAndStuff', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='creator',
            old_name='name',
            new_name='category',
        ),
        migrations.RenameField(
            model_name='creator',
            old_name='type',
            new_name='fullName',
        ),
        migrations.RenameField(
            model_name='distributor',
            old_name='type',
            new_name='category',
        ),
        migrations.RenameField(
            model_name='distributor',
            old_name='name',
            new_name='fullName',
        ),
        migrations.RenameField(
            model_name='kharacter',
            old_name='name',
            new_name='charName',
        ),
        migrations.RenameField(
            model_name='team',
            old_name='name',
            new_name='teamName',
        ),
    ]
