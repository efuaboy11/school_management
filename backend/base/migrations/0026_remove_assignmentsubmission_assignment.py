# Generated by Django 5.1.2 on 2025-04-17 23:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0025_assignmentsubmission_teacher_assignment'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='assignmentsubmission',
            name='assignment',
        ),
    ]
