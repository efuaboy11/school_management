# Generated by Django 5.1.2 on 2025-04-19 16:32

import django.db.models.deletion
import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0030_eresult'),
    ]

    operations = [
        migrations.CreateModel(
            name='PaymentMethod',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, max_length=100, null=True)),
                ('description', models.TextField(blank=True, null=True)),
                ('created_at', models.DateTimeField(default=django.utils.timezone.now)),
            ],
        ),
        migrations.CreateModel(
            name='SchoolFees',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('fee_choice', models.CharField(blank=True, choices=[('school fees', 'School Fees'), ('P.T.A', 'P.T.A'), ('acceptance fees', 'Acceptance Fees')], max_length=100, null=True)),
                ('amount', models.FloatField(blank=True, null=True)),
                ('description', models.TextField(blank=True, null=True)),
                ('date', models.DateTimeField(default=django.utils.timezone.now)),
                ('session', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='base.session')),
                ('student_class', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='base.studentclass')),
                ('term', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='base.term')),
            ],
        ),
        migrations.CreateModel(
            name='PaymentSchoolFees',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('transaction_id', models.CharField(blank=True, max_length=100, null=True)),
                ('fee_receipt', models.FileField(blank=True, null=True, upload_to='bill_receipt')),
                ('status', models.CharField(choices=[('Pending', 'Pending'), ('Approved', 'Approved'), ('Declined', 'Declined')], default='Pending', max_length=10)),
                ('date_of_payment', models.DateTimeField(default=django.utils.timezone.now)),
                ('payment_method', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='base.paymentmethod')),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='base.student')),
                ('fee_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='base.schoolfees')),
            ],
        ),
    ]
