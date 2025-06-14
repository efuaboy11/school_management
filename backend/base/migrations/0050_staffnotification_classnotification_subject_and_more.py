# Generated by Django 5.1.2 on 2025-06-05 13:06

import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0049_assignment_date'),
    ]

    operations = [
        migrations.CreateModel(
            name='StaffNotification',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('subject', models.CharField(blank=True, max_length=100, null=True)),
                ('text', models.TextField(blank=True, max_length=500, null=True)),
                ('date', models.DateTimeField(default=django.utils.timezone.now)),
            ],
        ),
        migrations.AddField(
            model_name='classnotification',
            name='subject',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AddField(
            model_name='schoolnotification',
            name='subject',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='schoolnotification',
            name='text',
            field=models.TextField(blank=True, max_length=500, null=True),
        ),
    ]
