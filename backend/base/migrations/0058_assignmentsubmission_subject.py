# Generated by Django 5.1.2 on 2025-06-17 11:04

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0057_assignmentsubmission_assignment_note'),
    ]

    operations = [
        migrations.AddField(
            model_name='assignmentsubmission',
            name='subject',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='base.subjects'),
        ),
    ]
