# Generated by Django 5.1.2 on 2025-04-08 17:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0007_adminorhrnotification_disableaccount_disabled_at_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='adminorhrnotification',
            name='seen',
            field=models.BooleanField(default=False),
        ),
    ]
