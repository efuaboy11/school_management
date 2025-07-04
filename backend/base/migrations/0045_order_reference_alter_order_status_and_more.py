# Generated by Django 5.1.2 on 2025-05-30 01:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0044_staff_cv'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='reference',
            field=models.CharField(blank=True, max_length=255, null=True, unique=True),
        ),
        migrations.AlterField(
            model_name='order',
            name='status',
            field=models.CharField(choices=[('pending', 'Pending'), ('processing', 'Processing'), ('completed', 'Completed'), ('failed', 'Failed')], default='pending', max_length=20),
        ),
        migrations.AlterField(
            model_name='schoolfees',
            name='fee_choice',
            field=models.CharField(blank=True, choices=[('school fees', 'School Fees'), ('P.T.A', 'P.T.A')], max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='users',
            name='role',
            field=models.CharField(choices=[('admin', 'Admin'), ('hr', 'HR'), ('student', 'student'), ('teacher', 'Teacher'), ('bursary', 'Bursary'), ('store_keeper', 'Store Keeper'), ('result_officer', 'Result Officer'), ('academic_officer', 'Academic officer'), ('other_staff', 'Other_staff')], default='other_staff', max_length=20),
        ),
    ]
