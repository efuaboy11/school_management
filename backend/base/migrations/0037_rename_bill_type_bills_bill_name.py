# Generated by Django 5.1.2 on 2025-04-20 03:18

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0036_rename_date_of_payment_billpayment_date'),
    ]

    operations = [
        migrations.RenameField(
            model_name='bills',
            old_name='bill_type',
            new_name='bill_name',
        ),
    ]
