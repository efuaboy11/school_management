from .models import *
from rest_framework import serializers
from decimal import Decimal
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer, TokenRefreshSerializer
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.exceptions import AuthenticationFailed
from django.contrib.contenttypes.models import ContentType

class UsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = [
            'id',
            'username',
            'first_name',
            'last_name',
            'date_of_birth',
        ]
        
class StaffSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    class Meta:
        model = Staff
        
        fields = [
            'id',
            'userID',
            'username',
            'first_name',
            'last_name',
            'date_of_birth',
            'email',
            'state_of_origin',
            'religion',
            'phone_number',
            'disability',
            'disability_note',
            'city_or_town',
            'role',
            'department',
            'employment_type',
            'maritial_status',
            'years_of_experience',
            'computer_skills',
            'flsc',
            'waec_neco_nabteb_gce',
            'degree',
            'other_certificates',
            'teacher_speech',
            'passport',
            'password'
        ]
    
    def create(self, validated_data):
        password = validated_data.pop('password', None)
        staff = Staff(**validated_data)
        if password:
            staff.set_password(password)
        staff.save()
        return staff  
        
        

class HRSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    class Meta:
        model = HR
        
        fields = [
            'id',
            'userID',
            'username',
            'first_name',
            'last_name',
            'date_of_birth',
            'email',
            'state_of_origin',
            'religion',
            'phone_number',
            'disability',
            'disability_note',
            'city_or_town',
            'role',
            'office_location',
            'qualification',
            'passport',
            'password'
        ]
    
    def create(self, validated_data):
        password = validated_data.pop('password', None)
        hr = HR(**validated_data)
        if password:
            hr.set_password(password)
        hr.save()
        return hr
        


        
class StudentSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    class Meta:
        model = Student
        fields = [
            'id',
            'userID',
            'username',
            'first_name',
            'last_name',
            'date_of_birth',
            'email',
            'father_name',
            'mother_name',
            'gurdian_name',
            'state_of_origin',
            'religion',
            'phone_number',
            'disability',
            'disability_note',
            'city_or_town',
            'role',
            'admission_number',
            'student_class',
            'passport',
            'password'
        ]
        
        
    def create(self, validated_data):
        password = validated_data.pop('password', None)
        student = Student(**validated_data)
        if password:
            student.set_password(password)
        student.save()
        return student  
        
        
class ParentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Parent
        fields = [
            'id',
            'name',
            'phone_number',
            'email',
            'image',
            'address',
            'children_name'
        ]       
#  --------------------------- Login  --------------------------------
class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField(write_only=True, min_length=8)
    

class CustomTokenObtainSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        user = self.user
        data['role'] = user.role
        data['user_id'] = user.id
        
        return data
    
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        profile_id = None
        
        try:
            profile = UserProfile.objects.get(user=user)
            profile_id = profile.id
        except UserProfile.DoesNotExist:
            pass
        
        token['profile_id'] = profile_id
        token['role'] = user.role
        
        return token
    
    
class CustomTokenRefreshSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        data = super().validate(attrs)
        refresh = RefreshToken(attrs['refresh'])
        access = refresh.access_token
        
        data['refresh'] = str(refresh)
        data['access'] = str(access)
        user_id = refresh.get('user_id')
        
        if not user_id:
            raise AuthenticationFailed('Invalid token')
        
        try:
            user = Users.objects.get(id=user_id)
        except Users.DoesNotExist:
            raise AuthenticationFailed('User not found', code='user_not_found')
        
        profile_id = None
        
        try:
            profile = UserProfile.objects.get(user=user)
            profile_id = profile.id
        except UserProfile.DoesNotExist:
            pass
        
        data['profile_id'] = profile_id
        data['role'] = user.role
        
        return data 
            
class RequestToChangePasswordFormSerializer(serializers.Serializer):
    username = serializers.CharField()
    
class RequestToChangePasswordSerializer(serializers.ModelSerializer):
    class Meta:
        model = RequestToChangePassword
        fields = [
            'id',
            'user',
            'request_date',
            'approved_status',
            'approved_date',
            'token',
            'token_expiry'
        ]
        
class RequestToChangePasswordStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = RequestToChangePassword
        fields = ['approved_status']
            
            
class ChangePasswordFormSerializer(serializers.Serializer):
    token = serializers.CharField()
    new_username = serializers.CharField()
    new_password = serializers.CharField()
    
    
class LogoutSerializer(serializers.Serializer):
    refresh_token  = serializers.CharField()
    
    
            
# Admin or HR Notification
class AdminorHRNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = AdminorHRNotification
        fields = [
            'id',
            'text',
            'date'
        ]
        
# Email
class EmailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Email
        fields = [
            'id',
            'to',
            'subject',
            'body',
            'delivery_status',
            'date',
        ]
        
        
#Subjects
class SubjectsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subjects
        fields = [
            'id',
            'name',
            'sections',
            'description',
            'created_at'
        ]
    
    
#Student Classes    
class StudentClassSerializer(serializers.ModelSerializer):
    class Meta:
        model = StudentClass
        fields = [
            'id',
            'name',
            'subjects',
        ]
  
# Terms      
class TermSerializer(serializers.ModelSerializer):
    class Meta:
        model = Term
        fields = [
            'id',
            'name'
        ]
        
# Session
class SessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Session
        fields = [
            'id',
            'name',
            'term',
        ]
        
# School Notification
class SchoolNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = SchoolNotification
        fields = [
            'id',
            'text',
            'date'
        ]
        
        
# class Notifcation
class ClassNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ClassNotification
        fields = [
            'id',
            'teacher',
            'student_class',
            'text',
            'date',
        ]
        
# School Events
class SchoolEventSerializer(serializers.ModelSerializer):
    class Meta:
        model = SchoolEvent
        fields = [
            'id',
            'title',
            'description',
            'date',
            'created_at',
        ]
        
        
# --------------------------------------------- Result ---------------------- #

# Generator of scratch Card 
class GenerateScratchCardSerializer(serializers.Serializer):
    amount = serializers.IntegerField(min_value=1, max_value=100, help_text="How many scratch cards to generate")
    
    
# Subject Result 
class SubjectResultSerializer(serializers.ModelSerializer):
    subject_name = serializers.SerializerMethodField()
    class Meta:
        model = SubjectResult
        fields = [
            'id',
            'student_result',
            'subject',
            'total_ca',
            'exam',
            'total',
            'grade',
            'position'
            'cgpa'
        ]
    
    def get_subject_name(self, obj):
        subject = obj.subject
        serializer = SubjectsSerializer(instance=subject, many=False)
        return serializer.data
    
    
# Student Result
class StudentResultSerializer(serializers.ModelSerializer):
    subject_result = SubjectResultSerializer(many=True)
    student_name = serializers.SerializerMethodField()
    term_name = serializers.SerializerMethodField()
    session_name = serializers.SerializerMethodField()
    class_name = serializers.SerializerMethodField()
    
    class Meta:
        model = StudentResult
        fields = [
            'id',
            'student',
            'stuent_name',
            'student_class',
            'class_name',
            'term',
            'term_name',
            'session',
            'session_name',
            'total_marks_obtain',
            'student_average',
            'class_average',
            'students',
            'position',
            'decision',
            'agility',
            'caring',
            'communication',
            'loving',
            'puntuality',
            'seriousness',
            'socialization',
            'attentiveness',
            'handling_of_tools',
            'honesty',
            'leadership',
            'music',
            'neatness',
            'perserverance',
            'politeness',
            'tools',
            'teacher_comment',
            'principal_comment',
            'next_term_begins',
            'subject_results',
            
            
        ]
