from django.contrib import admin
from .models import*
# Register your models here.
admin.site.site_header = "School Management System"
admin.site.register(Users)
admin.site.register(Staff)
admin.site.register(RequestToChangePassword)
admin.site.register(PaymentSchoolFees)