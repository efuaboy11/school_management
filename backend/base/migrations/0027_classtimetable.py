# Generated by Django 5.1.2 on 2025-04-18 07:24

import django.db.models.deletion
import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0026_remove_assignmentsubmission_assignment'),
    ]

    operations = [
        migrations.CreateModel(
            name='ClassTimetable',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('class_timetable', models.FileField(blank=True, null=True, upload_to='class_timetable')),
                ('Created_at', models.DateTimeField(default=django.utils.timezone.now)),
                ('student_class', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='base.studentclass')),
                ('teacher', models.ForeignKey(limit_choices_to={'role': 'teacher'}, on_delete=django.db.models.deletion.CASCADE, to='base.staff')),
            ],
        ),
    ]
