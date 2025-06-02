from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.views import APIView
from rest_framework import generics, status, permissions, filters
from rest_framework.permissions import IsAdminUser, IsAuthenticated, AllowAny
from rest_framework_simplejwt.tokens import RefreshToken, TokenError
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .models import *
from .serializers import *
from .permission import *
from .verification import *
from datetime import datetime
from django.template.loader import render_to_string
from django.utils.crypto import get_random_string
from .smpt import *
from .paystack import *
from rest_framework.filters import SearchFilter
import json
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator

# Create your views here.
@api_view(['GET'])
def endpoints(request):
    data = [
        "users/",
    ]
    return Response(data)

class ExactSearchFilter(SearchFilter):
    def get_search_terms(self, request):
        # Do not split the query by whitespace
        params = request.query_params.get(self.search_param, '')
        return [params]
    
    
class UsersView(generics.ListAPIView):
    permission_classes = [IsAdminUser]
    queryset = Users.objects.all()
    serializer_class = UsersSerializer
    
    
class StudentView(generics.ListCreateAPIView):
    permission_classes = [IsAdminOrHR]
    queryset = Student.objects.all()
    serializer_class = StudentSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID', 'student_class__name']
    
    def post(self, request):
        reg_serializer = self.get_serializer(data=request.data)
        
        if reg_serializer.is_valid():
            instance = reg_serializer.save()
 
            email = instance.email
            
            
            
            student = reg_serializer.save()
            
            if student:
                return Response(reg_serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(reg_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        

class StudentRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAdminOrHrOrStudent]
    queryset = Student.objects.all()
    serializer_class = StudentSerializer
    lookup_field = 'pk'
    
        
    def delete(self, request, *args, **kwargs):
        user = request.user
        if(user.role == "admin" or user.role == "hr"):
            return super().delete(request, *args, **kwargs)
        else:
            return Response({"error": "You do not have permission to delete this student."}, status=status.HTTP_403_FORBIDDEN)
          

class DeleteMultipleStudentsView(generics.GenericAPIView):
    permission_classes = [IsAdminOrHR]
    serializer_class = DeleteMultipleUUIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Student.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} students deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    

   
class StaffView(generics.ListCreateAPIView):
    permission_classes = [IsAdminOrHR]
    queryset = Staff.objects.all()
    serializer_class = StaffSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID']
    
    def post(self, request):
        reg_serializer = self.get_serializer(data=request.data)
        
        if reg_serializer.is_valid():
            instance = reg_serializer.save()
 
            email = instance.email
            
            staff = reg_serializer.save()
            
            if staff:
                return Response(reg_serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(reg_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class DeleteMultipleStaffView(generics.GenericAPIView):
    permission_classes = [IsAdminOrHR]
    serializer_class = DeleteMultipleUUIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Staff.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    


class StaffRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAdminOrHrOrTeacher]
    queryset = Staff.objects.all()
    serializer_class = StaffSerializer
    lookup_field = 'pk'
    
        
    def delete(self, request, *args, **kwargs):
        user = request.user
        if(user.role == "admin" or user.role == "hr"):
            return super().delete(request, *args, **kwargs)
        else:
            return Response({"error": "You do not have permission to delete this staff."}, status=status.HTTP_403_FORBIDDEN)
    
class HRView(generics.ListCreateAPIView):
    permission_classes = [IsAdminUser]
    queryset = HR.objects.all()
    serializer_class = HRSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID']
    
    def post(self, request):
        reg_serializer = self.get_serializer(data=request.data)
        
        if reg_serializer.is_valid():
            instance = reg_serializer.save()
 
            email = instance.email
        
            
            hr = reg_serializer.save()
            
            if hr:
                return Response(reg_serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(reg_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
 
class HRRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAdminOrHR]
    queryset = HR.objects.all()
    serializer_class = HRSerializer
    lookup_field = 'pk'
    
        
    def delete(self, request, *args, **kwargs):
        user = request.user
        if(user.role == "admin" or user.role == "hr"):
            return super().delete(request, *args, **kwargs)
        else:
            return Response({"error": "You do not have permission to delete this staff."}, status=status.HTTP_403_FORBIDDEN)
        

class DeleteMultipleHRView(generics.GenericAPIView):
    permission_classes = [IsAdminOrHR]
    serializer_class = DeleteMultipleUUIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = HR.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
      

class TeachersView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID']
    
    def get_queryset(self):
        return Staff.objects.filter(role="teacher")       
    
class BursaryView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID']
    
    def get_queryset(self):
        return Staff.objects.filter(role="bursary")
  
class StoreKeeperView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID']
    
    def get_queryset(self):
        return Staff.objects.filter(role="store_keeper")

class ResultOfficerView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID']
    
    def get_queryset(self):
        return Staff.objects.filter(role="result_officer")
    
class AcademicOfficerView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID']
    
    def get_queryset(self):
        return Staff.objects.filter(role="academic_officer")
    
class OtherStaffView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    filter_backends = [ExactSearchFilter]
    search_fields = ['first_name', 'last_name', 'email', 'phone_number', 'userID']
    
    def get_queryset(self):
        return Staff.objects.filter(role="other_staff")  
    
    
class ParentViews(generics.ListCreateAPIView):
    serializer_class = ParentSerializer
    permission_classes = [IsAdminOrHR]
    queryset = Parent.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['name',  'email', 'phone_number',]

class ParentRetrieveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ParentSerializer
    permission_classes = [IsAuthenticated]
    queryset = Parent.objects.all()
    lookup_field = 'pk'
class DeleteMultipleParentsView(generics.GenericAPIView):
    permission_classes = [IsAdminOrHR]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Parent.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
   
    
class LoginView(generics.GenericAPIView):
    serializer_class = LoginSerializer
    permission_classes = [AllowAny]
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        username = serializer.validated_data['username']
        password = serializer.validated_data['password']
        
        try:
            user = Users.objects.get(username=username)
            
            if DisableAccount.objects.filter(user=user).exists():
                return Response({"error": "This account is disabled."}, status=status.HTTP_403_FORBIDDEN)
            
            user_auth = authenticate(username=username, password=password)
            if user_auth is None:
                user.failed_login_attempts += 1
                user.save()
                
                if user.failed_login_attempts >= 3:
                    DisableAccount.objects.get_or_create(user=user, reason="Too many failed login attempts.")
                    AdminorHRNotification.objects.get_or_create(text=f"User {user.username} has been disabled due to multiple failed login attempts.")
                    return Response({"error": "Your account has been disabled due to multiple failed login attempts."}, status=status.HTTP_403_FORBIDDEN)
                return Response({"error": "Invalid credentials."}, status=status.HTTP_401_UNAUTHORIZED)
            
            user.failed_login_attempts = 0
            user.save()
            
            token_serializer = CustomTokenObtainSerializer(data={'username': username, 'password': password})
            token_serializer.is_valid(raise_exception=True)
            return Response(token_serializer.validated_data, status=status.HTTP_200_OK)
        except Users.DoesNotExist:
            return Response({"error": "User does not exist."}, status=status.HTTP_404_NOT_FOUND)
            
class CustomRefreshTokenView(TokenRefreshView):
    serializer_class = CustomTokenRefreshSerializer
    
    
class RequestToChangePasswordFormView(generics.GenericAPIView):
    serializer_class = RequestToChangePasswordFormSerializer
    permission_classes = [AllowAny]
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        
        username = serializer.validated_data['username']
        
        try:
            user = Users.objects.get(username=username)
            request_to_change_password = RequestToChangePassword.objects.create(user=user)
            request_to_change_password.save()
            AdminorHRNotification.objects.create(text=f"Password change request for {user.username} has been requested.")
            return Response({"message": "Password change request has been sent."}, status=status.HTTP_200_OK)
        except Users.DoesNotExist:
            return Response({"error": "User does not exist."}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
            
class RequestToChangePasswordView(generics.ListAPIView):
    permission_classes = [IsAdminOrHR]
    queryset = RequestToChangePassword.objects.all()
    serializer_class = RequestToChangePasswordSerializer
    
    
class RequestToChangePasswordStatusView(generics.RetrieveUpdateAPIView):
    queryset = RequestToChangePassword.objects.all()
    serializer_class = RequestToChangePasswordStatusSerializer
    permission_classes = [IsAdminOrHR]
    
    def put(self, request, *args, **kwargs):
        instance = self.get_object()
        previous_status = instance.approved_status
        
        print("Previous status:", previous_status) 
        
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        
        updated_status = serializer.validated_data.get('approved_status')
        print("Previous status:", previous_status) 
        if updated_status == 'approved' and previous_status != 'approved':
            print("✅ Status is newly approved — executing logic")
            instance.approved_date = timezone.now()
            instance.token_expiry = timezone.now() + timezone.timedelta(minutes=45)
            instance.save()
            
            user = instance.user
            domain = "http://localhost:3000"
            url = f"{domain}/change-password/{instance.token}"
            
        
            subject = 'Resetting Password'
            user_email = user.email
            
            html_content = render_to_string('email/reset_password.html', {
                'url' : url,
                'year': datetime.now().year
            })
            
            send_email(to_email=user_email, message=html_content, subject=subject)
            
            return Response({
                "message": "Status updated to approved and password reset link sent.",
                "reset_link": url
            })
        elif updated_status == 'declined':
            print("❌ Status is declined")
            return Response({"message": "Status updated to declined. No link sent."})
        print("⚠️ Status was already approved, no new action taken.")
        return Response({"message": f"Status updated to {updated_status}."})

         
         
class ChangePasswordFormSerializer(generics.GenericAPIView):
    serializer_class = ChangePasswordFormSerializer
    permission_classes = [AllowAny]  
    
    def post(self, request):
        token = request.data.get("token")
        new_username = request.data.get('new_username')
        new_password = request.data.get('new_password')
        
        try: 
            change_request = RequestToChangePassword.objects.get(token=token)
            
            if not change_request.is_token_valid():
                return Response({"error": "Token expired or invalid."}, status=400) 
            
            user = change_request.user
            
            user.username = new_username
            user.set_password(new_password)
            user.save()
            
            change_request.token_expiry = timezone.now()
            change_request.save()
            
            return Response({"message": "Password and username updated successfully."})
        except RequestToChangePassword.DoesNotExist:
            return Response({"error": "Invalid token."}, status=404)
         
         
class LogoutView(generics.GenericAPIView):
    serializer_class = LogoutSerializer 
    permission_classes = [permissions.IsAuthenticated]
    
    def post(self, request):
        refresh_token = request.data.get("refresh")
        
        if refresh_token is None:
            return Response({"error": "Refresh token required"}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            token = RefreshToken(refresh_token)
            token.blacklist()
            return Response({"message": "Logout successful, token blacklisted"}, status=status.HTTP_200_OK)
        except TokenError as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
   
class DisableAccountView(generics.ListCreateAPIView):
    serializer_class = DisableAccountSerializer
    permission_classes = [IsAdminOrHR]
    filter_backends = [ExactSearchFilter]
    search_fields = ['user__first_name', 'user__last_name', 'reason', 'disabled_at']
    
    def get_queryset(self):
        queryset = DisableAccount.objects.all()
        user_role = self.request.query_params.get('user_role')
        if(user_role):
            if(user_role == 'staff'):
                queryset = queryset.exclude(user__role__in=['student', 'hr'])
            else:
                queryset = queryset.filter(user__role=user_role)
        return queryset
    
class DisableAccountRetrieveDestory(generics.RetrieveDestroyAPIView):
    serializer_class = DisableAccountSerializer
    permission_classes = [IsAdminOrHR]
    queryset =   DisableAccount.objects.all()
    lookup_field = 'pk'
    

# Email         
class EmailView(generics.ListCreateAPIView):
    serializer_class = EmailSerializer
    permission_classes = [IsAdminOrHR]
    queryset =   Email.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['to', 'subject', 'delivery_status', 'date']
    
    def post(self, request, *args, **kwargs):
       try:
           email = request.data.get('to')
           subject = request.data.get('subject')
           text = request.data.get('body')
           is_bulk = request.data.get('is_bulk', False)
           
           html_content = render_to_string('email/send_mail.html', {
                'email' : email,
                'subject': subject,
                'text': text,
                'year': '2025'
           })
           
           delivery_results = send_bulk_email(email, html_content, subject, text, is_bulk)
            
           if delivery_results:
                return Response({"message": "Email(s) sent successfully."}, status=status.HTTP_200_OK)
           else:
                return Response({"error": "Failed to send email(s)."}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            
       except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)

           
            
    
class EmailRetrieveDestory(generics.RetrieveDestroyAPIView):
    serializer_class = EmailSerializer
    permission_classes = [IsAdminOrHR]
    queryset =   Email.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleEmailsView(generics.GenericAPIView):
    permission_classes = [IsAdminOrHR]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Email.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
#Subjects
class SubjectsView(generics.ListCreateAPIView):
    serializer_class = SubjectsSerializer
    permission_classes = [IsAuthenticated]
    queryset = Subjects.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['name', 'sections']
    
class SubjectsRetriveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SubjectsSerializer
    permission_classes = [IsAdminOrAcademicOfficer]
    queryset = Subjects.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleSubjectsView(generics.GenericAPIView):
    permission_classes = [IsAdminOrAcademicOfficer]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Subjects.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
# Students Classes
class StudentClassView(generics.ListCreateAPIView):
    serializer_class = StudentClassSerializer
    permission_classes = [IsAuthenticated]
    queryset = StudentClass.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['name']
    

class StudentClassRetriveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = StudentClassSerializer
    permission_classes = [IsAuthenticated]
    queryset = StudentClass.objects.all()
    lookup_field = 'pk'   
    
    def put(self, request, *args, **kwargs):
        user = request.user
        
        if(user.role == "admin" or user.role == "academic_officer"):
            return super().put(request, *args, **kwargs)
        else:
            return Response({"error": "You do not have permission to update this class."}, status=status.HTTP_403_FORBIDDEN)
        
    def delete(self, request, *args, **kwargs):
        user = request.user
        if(user.role == "admin" or user.role == "academic_officer"):
            return super().delete(request, *args, **kwargs)
        else:
            return Response({"error": "You do not have permission to delete this class."}, status=status.HTTP_403_FORBIDDEN)
    
    
class DeleteMultipleStudentClassView(generics.GenericAPIView):
    permission_classes = [IsAdminOrAcademicOfficer]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = StudentClass.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
     


# Terms

class TermView(generics.ListCreateAPIView):
    serializer_class = TermSerializer
    permission_classes = [IsAuthenticated]
    queryset = Term.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['name']
    
    

class TermRetriveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = TermSerializer
    permission_classes = [IsAdminOrAcademicOfficer]
    queryset = Term.objects.all()
    lookup_field = 'pk'                
 
class DeleteMultipleTermView(generics.GenericAPIView):
    permission_classes = [IsAdminOrAcademicOfficer]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Term.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
     


# Session
class SessionView(generics.ListCreateAPIView):
    serializer_class = SessionSerializer
    permission_classes = [IsAuthenticated]
    queryset = Session.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['name']

class SessionRetriveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SessionSerializer
    permission_classes = [IsAdminOrAcademicOfficer]
    queryset = Session.objects.all()
    lookup_field = 'pk'                

class DeleteMultipleSessionView(generics.GenericAPIView):
    permission_classes = [IsAdminOrAcademicOfficer]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Session.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
 
class AdminorHRNotificationView(generics.ListCreateAPIView):
    serializer_class = AdminorHRNotificationSerializer
    permission_classes = [IsAdminOrHR]
    queryset = AdminorHRNotification.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['text', 'date']
    
    
class AdminorHRNotificationRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = AdminorHRNotificationSerializer
    permission_classes = [IsAdminOrHR]
    queryset = AdminorHRNotification.objects.all()
    lookup_field = 'pk'

class DeleteMultipleAdminorHRNotificationView(generics.GenericAPIView):
    permission_classes = [IsAdminOrHR]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = AdminorHRNotification.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
     
   
class SchoolNotificationView(generics.ListCreateAPIView):
    serializer_class = SchoolNotificationSerializer
    permission_classes = [IsAuthenticated]
    queryset = SchoolNotification.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['text', 'date']
    
    
    def post(self, request, *args, **kwargs):
        user = request.user
        
        if(user.role == "admin" or user.role == "hr"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a notification."}, status=status.HTTP_403_FORBIDDEN)
    
class SchoolNotificationRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SchoolNotificationSerializer
    permission_classes = [IsAdminOrHR]
    queryset = SchoolNotification.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleSchoolNotificationView(generics.GenericAPIView):
    permission_classes = [IsAdminOrHR]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = SchoolNotification.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
class ClassNotificationView(generics.ListCreateAPIView):
    serializer_class = ClassNotificationSerializer
    permission_classes = [IsAdminOrTeacherorStudent]
    filter_backends = [ExactSearchFilter]
    search_fields = ['teacher__first_name', 'teacher__last_name', 'date']
    
    
        
    def get_queryset(self):
        user = self.request.user
        if user.role == 'admin':
            return ClassNotification.objects.all()
        elif user.role == 'teacher':
            return ClassNotification.objects.filter(teacher=user.id)
        elif user.role == 'student':
            
            try:
                student = Student.objects.get(id=user.id)
                student_class = student.student_class
            except Student.DoesNotExist:
                return Response({"error": "Student profile not found."}, status=status.HTTP_404_NOT_FOUND)
            
            return ClassNotification.objects.filter(student_class=student_class)

    
    # def post(self, request, *args, **kwargs):
    #     user = request.user
    #     teacher = request.data.get('teacher')  # Assuming 'teacher' is passed in the request data
    #     try:
    #         teacher = Staff.objects.get(id=teacher)  # Use .get() since it's one-to-one
    #     except Staff.DoesNotExist:
    #         return Response({"error": "Teacher profile not found."}, status=status.HTTP_404_NOT_FOUND)

    #     # Now get the assigned class ID
    #     teacher_class_id = teacher.assigned_class.id if teacher.assigned_class else None
    #     requested_class_id = request.data.get('student_class')  # Make sure this comes from the request

    #     # Check if teacher is allowed to post to this class
    #     if str(teacher_class_id) == str(requested_class_id):  # Cast to string to avoid type mismatch
    #         if user.role in ["admin", "teacher"]:
    #             serializer = self.get_serializer(data=request.data)
    #             serializer.is_valid(raise_exception=True)
    #             serializer.save()
    #             return Response(serializer.data, status=status.HTTP_201_CREATED)
    #         else:
    #             return Response({"error": "You do not have permission to create a notification."}, status=status.HTTP_403_FORBIDDEN)
    #     else:
    #         return Response({"error": "You do not have permission to create a notification for this class."}, status=status.HTTP_403_FORBIDDEN)

class ClassNotificationRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ClassNotificationSerializer
    permission_classes = [IsAdminOrTeacher]
    queryset = ClassNotification.objects.all()
    lookup_field = 'pk'
        
class DeleteMultipleClassNotificationView(generics.GenericAPIView):
    permission_classes = [IsAdminOrTeacher]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = ClassNotification.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
      
# class FilteredClassNotification(generics.ListAPIView):
#     permission_classes = [IsAdminOrTeacherorStudent]
#     serializer_class = ClassNotificationSerializer
    
#     def get_queryset(self):
#         query = self.request.query_params.get('query')
#         user = self.request.user
        
#         if user.role == 'teacher':
#             return ClassNotification.objects.filter(teacher=user.id)
#         elif user.role == 'student':
#             return ClassNotification.objects.filter
#         if student_class:
#             return ClassNotification.objects.filter(student_class=student_class)    
#         return ClassNotification.objects.none()
    
#     def list(self, request, *args, **kwargs):
#         queryset = self.get_queryset()
#         if not queryset.exists():
#             return Response({"message": "No notifications found for this class."}, status=status.HTTP_404_NOT_FOUND)
#         serializer = self.get_serializer(queryset, many=True)
#         return Response(serializer.data)
                      

class SchoolEventView(generics.ListCreateAPIView):
    serializer_class = SchoolEventSerializer
    permission_classes = [IsAuthenticated]
    queryset = SchoolEvent.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['title', 'description', 'date']
    
    
    
    
    def post(self, request, *args, **kwargs):
        user = request.user
        
        if(user.role == "admin" or user.role == "hr"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a notification."}, status=status.HTTP_403_FORBIDDEN)
        
        
class SchoolEventRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SchoolEventSerializer
    permission_classes = [IsAdminOrHR]
    queryset = SchoolEvent.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleSchoolEventView(generics.GenericAPIView):
    permission_classes = [IsAdminOrHR]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = SchoolEvent.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
# --------------------------------------------- Result ---------------------- #

# Generator of scratch Card 
class GenerateScratchCardView(generics.GenericAPIView):
    serializer_class =  GenerateScratchCardSerializer
    permission_classes = [IsAdminOrResultOfficer]
    
    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        amount = serializer.validated_data['amount']
        
        cards = []
        
        for _ in range(amount):
            pin = get_random_string(length=11, allowed_chars='0123456789') 
            while ScratchCard.objects.filter(pin=pin).exists():
                pin = get_random_string(length=11, allowed_chars='0123456789')
            card = ScratchCard.objects.create(pin=pin)
            cards.append(pin)
            
        return Response({
            "message": f"{amount} scratch cards generated successfully.",
            "pins": cards
        }, status=status.HTTP_201_CREATED)
        
        
class StudentResultListCreateApiView(generics.ListCreateAPIView):
    queryset = StudentResult.objects.all()
    serializer_class = StudentResultSerializer
    permission_classes = [IsAdminOrAcademicOfficerOrStudent]
    
    def post(self, request, *args, **kwargs):
        user = request.user
        
        if(user.role == "admin" or user.role == "academic_officer"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a result."}, status=status.HTTP_403_FORBIDDEN)
    
class StudentResultRetrieveUpdateDestroyApiView(generics.RetrieveUpdateDestroyAPIView):
    queryset = StudentResult.objects.all()
    serializer_class = StudentResultSerializer
    permission_classes = [IsAdminOrAcademicOfficer]
    lookup_field = 'pk'
    
    
class SubjectResultListCreateApiView(generics.ListCreateAPIView):
    queryset = SubjectResult.objects.all()
    serializer_class = SubjectResultSerializer
    permission_classes = [IsAdminOrAcademicOfficerOrStudent]
    def get_serializer(self, *args, **kwargs):
        if isinstance(data := kwargs.get("data", {}), list):
            kwargs["many"] = True
        return super().get_serializer(*args, **kwargs)
    
    def post(self, request, *args, **kwargs):
        user = request.user
        
        if(user.role == "admin" or user.role == "academic_officer"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a subject."}, status=status.HTTP_403_FORBIDDEN)


# E-result
class EResultView(generics.ListCreateAPIView):
    serializer_class = EResultSerializer
    permission_classes = [IsAdminOrResultOfficer]
    queryset = EResult.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['student__first_name', 'student__last_name', 'student_class__name', 'term__name', 'session__name']
    
    def post(self, request, *args, **kwargs):
        user = request.user
        
        if(user.role == "admin" or user.role == "result_officer"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a result."}, status=status.HTTP_403_FORBIDDEN)


class EResultRetrieveUpdateDestroyApiView(generics.RetrieveUpdateDestroyAPIView):
    queryset = EResult.objects.all()
    serializer_class = EResultSerializer
    permission_classes = [IsAdminOrResultOfficer]
class CheckEResultView(generics.ListCreateAPIView):
    permission_classes = [IsAdminOrResultOfficerOrStudent] 
    serializer_class = EResultSerializer
    
    def get_queryset(self):
        queryset = EResult.objects.all()
        student = self.request.query_params.get('student')
        student_class = self.request.query_params.get('student_class')
        term = self.request.query_params.get('term')
        session = self.request.query_params.get('session')

        if student:
            queryset = queryset.filter(student=student)
        if student_class:
            queryset = queryset.filter(student_class=student_class)
        if term:
            queryset = queryset.filter(term=term)
        if session:
            queryset = queryset.filter(session=session)

        return queryset
    
    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        if not queryset.exists():
            return Response({"message": "No result found for this student."}, status=status.HTTP_404_NOT_FOUND)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
        

class DeleteMultipleEResultView(generics.GenericAPIView):
    permission_classes = [IsAdminOrResultOfficer]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = EResult.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)

class SubjectResultRetrieveUpdateDestroyApiView(generics.RetrieveUpdateDestroyAPIView):
    queryset = SubjectResult.objects.all()
    serializer_class = SubjectResultSerializer
    lookup_field = "pk"
    permission_classes = [IsAdminOrAcademicOfficer]

         
         
class CheckStudentResultView(generics.ListCreateAPIView):
    queryset = StudentResult.objects.all()
    serializer_class = StudentResultSerializer
    permission_classes = [IsAdminOrAcademicOfficerOrStudent]
    
    
    def post(self, request, *args, **kwargs):
        student_id = request.data.get('student_id')
        pin = request.data.get('pin')
        class_id = request.data.get('class_id')
        term_id = request.data.get('term_id')
        session_id = request.data.get('session_id')

        try:
            scratch_card = ScratchCard.objects.get(pin=pin)
        except ScratchCard.DoesNotExist:
            return Response({"error": "Invalid Scratch Card Pin."}, status=status.HTTP_400_BAD_REQUEST)

        if not scratch_card.use(student_id):
            return Response({"error": "Scratch card has expired or has been used."}, status=status.HTTP_400_BAD_REQUEST)

        try:
            result = StudentResult.objects.get(
                student_id=student_id,
                student_class_id=class_id,
                term_id=term_id,
                session_id=session_id
            )
            return Response(StudentResultSerializer(result).data)
        except StudentResult.DoesNotExist:
            return Response({"error": "Result not found for the provided details."}, status=status.HTTP_404_NOT_FOUND)
        
        
        
class SchemeOfWorkView(generics.ListCreateAPIView):
    serializer_class = SchemeOfWorkSerializer
    permission_classes = [IsAdminOrTeacherorStudent]
    queryset = SchemeOfWork.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['term__name', 'student_class__name', 'subject__name', 'date']
    
    def post(self, request, *args, **kwargs):
        user = request.user
        term = request.data.get('term')  # Assuming 'term' is passed in the request data
        student_class = request.data.get('student_class')
        if SchemeOfWork.objects.filter(term=term, student_class=student_class).exists():
            return Response(
                {"error": "Scheme of work already exists for this term and class."},
                status=status.HTTP_400_BAD_REQUEST
            )
            
        
        if(user.role == "admin" or user.role == "teacher"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a scheme of work."}, status=status.HTTP_403_FORBIDDEN)
        
        
class SchemeOfWorkRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SchemeOfWorkSerializer
    permission_classes = [IsAdminOrTeacher]
    queryset = SchemeOfWork.objects.all()
    lookup_field = 'pk'
    
class FilteredSchemeOfWorkView(generics.ListAPIView):
    permission_classes = [IsAdminOrTeacherorStudent]
    serializer_class = SchemeOfWorkSerializer
    
    def get_queryset(self):
        term = self.request.query_params.get('term')    
        subject = self.request.query_params.get('subject')
        student_class = self.request.query_params.get('student_class')
        
        if term and subject and student_class:
            return SchemeOfWork.objects.filter(
                term=term,
                subject=subject,
                student_class=student_class
            )
        return SchemeOfWork.objects.none()
    
    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        if not queryset.exists():
            return Response({"message": "No scheme of work found for this term and class."}, status=status.HTTP_404_NOT_FOUND)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    
class DeleteMultipleSchemeOfWorkView(generics.GenericAPIView):
    permission_classes = [IsAdminOrTeacher]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = SchemeOfWork.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
     
    
# class Assignment
class AssignmentView(generics.ListCreateAPIView):
    serializer_class = AssignmentSerializer
    permission_classes = [IsAdminOrTeacherorStudent]
    filter_backends = [ExactSearchFilter]
    search_fields = ['teacher__first_name', 'teacher__last_name', 'subject__name', 'student_class__name', 'assignment_name', 'assignment_code', 'due_date']
    
    
    def get_queryset(self):
        user = self.request.user
        
        if user.role == 'admin':
            return Assignment.objects.all()
        elif user.role == 'teacher':
            return Assignment.objects.filter(teacher=user.id)
        elif user.role == 'student':
            try:
                student = Student.objects.get(id=user.id)
                student_class = student.student_class
            except Student.DoesNotExist:
                return Response({"error": "Student profile not found."}, status=status.HTTP_404_NOT_FOUND)
            
            return Assignment.objects.filter(student_class=student_class)
        
    def post(self, request, *args, **kwargs):
        user = request.user
        if(user.role == "admin" or user.role == "teacher"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create an assignment."}, status=status.HTTP_403_FORBIDDEN)
        
  
class AssignmentRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = AssignmentSerializer
    permission_classes = [IsAdminOrTeacher]
    queryset = Assignment.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleAssignmentView(generics.GenericAPIView):
    permission_classes = [IsAdminOrTeacher]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Assignment.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
     

class AssignmentSubmissionView(generics.ListCreateAPIView):
    serializer_class = AssignmentSubmissionSeralizer
    permission_classes = [IsAdminOrTeacherorStudent]
    filter_backends = [ExactSearchFilter]
    search_fields = ['teacher_assignment__first_name', 'teacher_assignment__last_name', 'student__first_name', 'student__last_name', 'assignment_code', 'grade']
    
    
    def get_queryset(self):
        user = self.request.user
        teacher_assignment = self.request.data.get('teacher_assignment')
        student = self.request.data.get('student')
        if user.role == 'admin':
            return AssignmentSubmission.objects.all()
        elif user.role == 'teacher':
            return AssignmentSubmission.objects.filter(teacher_assignment=teacher_assignment)
        elif user.role == 'student':
            return AssignmentSubmission.objects.filter(student=student)

class AssignmentSubmissionRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = AssignmentSubmissionSeralizer
    permission_classes = [IsAdminOrTeacher]
    queryset = AssignmentSubmission.objects.all()
    lookup_field = 'pk'
    
    
class UpdateAssignmentSubmissionView(generics.UpdateAPIView):
    serializer_class = UpdateAssignmentSubmissionSeralizer
    permission_classes = [IsAdminOrTeacher]
    
    def get_queryset(self):
        return AssignmentSubmission.objects.filter(pk=self.kwargs['pk'])
    
    def put(self, request, *args, **kwargs):   
        student_id = request.data.get('student') 
        student = Student.objects.get(id=student_id)
        student_email = student.email
        student_name = student.first_name + " " + student.last_name
        subject =  "Assigment Submission Feedback"
        grade = request.data.get('grade')
        feedback = request.data.get('feedback')
        
        instance = self.get_object()
        instance.grade = grade
        instance.feedback = feedback
        instance.save()
        
        
        
        try: 
            html_content = render_to_string('email/assignment_feedback.html', {
                'student_name': student_name,
                'grade': grade,
                'feedback': feedback,
                'year': datetime.now().year
            })
            
            send_email(to_email=student_email, message=html_content, subject=subject)
            return Response({"message": "Feedback email sent successfully."}, status=status.HTTP_200_OK)
        except Student.DoesNotExist:
            return Response({"error": "Student not found."}, status=status.HTTP_404_NOT_FOUND)
  
class DeleteMultipleAssignmentSubmssionView(generics.GenericAPIView):
    permission_classes = [IsAdminOrTeacher]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = AssignmentSubmission.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
         

class ClassTimetableView(generics.ListCreateAPIView):
    serializer_class = ClassTimetableSerializer
    permission_classes = [IsAdminOrTeacherorStudent]
    filter_backends = [ExactSearchFilter]
    search_fields = ['student_class__name','teacher__first_name', 'teacher__last_name']
    
    
    def get_queryset(self):
        user = self.request.user
        
        if user.role == 'admin':
            return ClassTimetable.objects.all()
        elif user.role == 'teacher':
            return ClassTimetable.objects.filter(teacher=user.id)
        elif user.role == 'student':
            try:
                student = Student.objects.get(id=user.id)
                student_class = student.student_class
            except Student.DoesNotExist:
                return Response({"error": "Student profile not found."}, status=status.HTTP_404_NOT_FOUND)
            
            return ClassTimetable.objects.filter(student_class=student_class)
    
    def post(self, request, *args, **kwargs):
        user = request.user
        if(user.role == "admin" or user.role == "teacher"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a timetable."}, status=status.HTTP_403_FORBIDDEN)
              
            
class ClassTimetableRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ClassTimetableSerializer
    permission_classes = [IsAdminOrTeacher]
    queryset = ClassTimetable.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleClassTimetableView(generics.GenericAPIView):
    permission_classes = [IsAdminOrTeacher]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = ClassTimetable.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    

# ------------------------------- Account ----------------------------#

class InitializePaymentView(generics.GenericAPIView):
    permission_classes = [AllowAny]
    serializer_class = InitializePaymentSerializer
    
    def post(self, request, *args, **kwargs):
        email = request.data.get('email')
        amount = request.data.get('amount')
        reference = str(uuid.uuid4())
        response = Paystack.initialize_payment(
            email=email,
            amount=amount,
            reference=reference
        )
        
        return Response({
            'payment_url': response['data']['authorization_url'],
            'reference': reference,
            'public_key': settings.PAYSTACK_PUBLIC_KEY
        })

class PaymentMethodView(generics.ListCreateAPIView):
    serializer_class = PaymentMethodSerializer
    permission_classes = [IsAdminOrBursaryOrStudent]
    queryset = PaymentMethod.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['name', 'description']
    
    def post(self, request, *args, **kwargs):
        user = request.user
        
        if(user.role == "admin" or user.role == "bursary"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        

class PaymentMethodRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):   
    serializer_class = PaymentMethodSerializer
    permission_classes = [IsAdminorBursary]
    queryset = PaymentMethod.objects.all()
    lookup_field = 'pk'
    
class DeleteMultiplePaymentMethodView(generics.GenericAPIView):
    permission_classes = [IsAdminorBursary]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = PaymentMethod.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
        



class SchoolFeesView(generics.ListCreateAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = SchoolFeesSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['student_class__name', 'session__name', 'term__name', 'fee_choice']
    
    
    def get_queryset(self):
        queryset = SchoolFees.objects.all()
        student_class = self.request.query_params.get('student_class')
        term = self.request.query_params.get('term')
        session = self.request.query_params.get('session')
        fee_type = self.request.query_params.get('fee_type')
 
        if student_class:
            queryset = queryset.filter(student_class=student_class)
        if term:
            queryset = queryset.filter(term=term)
        if session:
            queryset = queryset.filter(session=session)
        if fee_type:
            queryset = queryset.filter(fee_choice=fee_type)

        return queryset
    
    def post(self, request, *args, **kwargs):
        fee_choice = request.data.get('fee_choice')
        student_class = request.data.get('student_class')
        term = request.data.get('term')
        session = request.data.get('session')
        
        if SchoolFees.objects.filter(fee_choice=fee_choice, student_class=student_class, term=term, session=session).exists():
            return Response(
                {"error": "School fee already exists for this term and class."},
                status=status.HTTP_400_BAD_REQUEST
            )
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
       

class SchoolFeesRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SchoolFeesSerializer
    permission_classes = [IsAdminorBursary]
    queryset = SchoolFees.objects.all()
    lookup_field = 'pk'
    
    
class DeleteMultipleSchoolFeesView(generics.GenericAPIView):
    permission_classes = [IsAdminorBursary]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = SchoolFees.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)     
   
# class FilteredSchoolFees(generics.ListAPIView):
#     permission_classes = [IsAdminOrBursaryOrStudent]
#     serializer_class = SchoolFeesSerializer
#     filter_backends = [ExactSearchFilter]
#     search_fields = ['session__name', 'student_class__name', 'term__name']
    
#     def get_queryset(self):
#         return SchoolFees.objects.filter(fee_choice='school fees')
    
#     def list(self, request, *args, **kwargs):
#         queryset = self.get_queryset()
        
#         if not queryset.exists():
#             return Response({"detail": "No records found."},
#                 status=status.HTTP_404_NOT_FOUND)
#         serializer = self.get_serializer(queryset, many=True)
#         return Response(serializer.data)
            
# class FilteredSchoolFeesPTA(generics.ListAPIView):
#     permission_classes = [IsAdminOrBursaryOrStudent]
#     serializer_class = SchoolFeesSerializer
#     filter_backends = [ExactSearchFilter]
#     search_fields = ['session__name', 'student_class__name', 'term__name']
    
#     def get_queryset(self):
#         return SchoolFees.objects.filter(fee_choice='P.T.A')
    
#     def list(self, request, *args, **kwargs):
#         queryset = self.get_queryset()
        
#         if not queryset.exists():
#             return Response({"detail": "No records found."},
#                 status=status.HTTP_404_NOT_FOUND)
#         serializer = self.get_serializer(queryset, many=True)
#         return Response(serializer.data)
    
# class FilteredSchoolFeesAcceptance(generics.ListAPIView):
    # permission_classes = [IsAdminOrBursaryOrStudent]
    # serializer_class = SchoolFeesSerializer
    # filter_backends = [ExactSearchFilter]
    # search_fields = ['session__name', 'student_class__name', 'term__name']
    
    # def get_queryset(self):
    #     return SchoolFees.objects.filter(fee_choice='acceptance fees')
    
    # def list(self, request, *args, **kwargs):
    #     queryset = self.get_queryset()
        
    #     if not queryset.exists():
    #         return Response({"detail": "No records found."},
    #             status=status.HTTP_404_NOT_FOUND)
    #     serializer = self.get_serializer(queryset, many=True)
    #     return Response(serializer.data)
# class FilteredSchool  
       
class GetSchoolFeesAmountView(generics.GenericAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = GetSchoolFeesAmountSerializer
    
    def post(self, request, *args, **kwargs):
        student_class = request.data.get('student_class')
        term = request.data.get('term')
        session = request.data.get('session')
        fee_type = request.data.get('fee_type')
        
        try:
            school_fee = SchoolFees.objects.get(student_class=student_class, term=term, session=session, fee_choice=fee_type)
            return Response({'id': school_fee.id, 
                            "amount": school_fee.amount, 
                            'fee_choice': school_fee.fee_choice, 
                            'term': school_fee.term.name,  
                            'session': school_fee.session.name,
                            'student_class': school_fee.student_class.name,
                            'description': school_fee.description}, status=status.HTTP_200_OK)
        except SchoolFees.DoesNotExist:
            return Response({"error": "School fee not found for the provided details."}, status=status.HTTP_404_NOT_FOUND)
        
        

class PaymentSchoolFeesView(generics.ListCreateAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = PaymentSchoolFeesSerializer
    filter_backends = [ExactSearchFilter]
    search_fields =['student__first_name', 'student__last_name', 'payment_method__name', 'fee_type__fee_choice', 'fee_type__session__name', 'fee_type__term__name', 'fee_type__student_class__name', 'fee_type__amount', 'date']
    
    def get_queryset(self):
        user = self.request.user
        student_id = user.id
        if user.role == 'admin' or user.role == 'bursary':
            queryset = PaymentSchoolFees.objects.all()
            student = self.request.query_params.get('student')
            payment_method = self.request.query_params.get('payment_method')

            if student:
                queryset = queryset.filter(student=student)
            if payment_method:
                queryset = queryset.filter(payment_method=payment_method)

            return queryset
        return PaymentSchoolFees.objects.filter(student=student_id)
        
     
class PendingPaymentSchoolFeesView(generics.ListAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = PaymentSchoolFeesSerializer
    filter_backends = [ExactSearchFilter]
    search_fields =['student__first_name', 'student__last_name', 'payment_method__name', 'fee_type__fee_choice', 'fee_type__session__name', 'fee_type__term__name', 'fee_type__student_class__name', 'fee_type__amount', 'date']
    
    def get_queryset(self):
        user = self.request.user
        student_id = user.id
        if user.role == 'admin' or user.role == 'bursary':
            queryset = PaymentSchoolFees.objects.filter(status='pending')
            student = self.request.query_params.get('student')
            payment_method = self.request.query_params.get('payment_method')

            if student:
                queryset = queryset.filter(student=student, status='pending')
            if payment_method:
                queryset = queryset.filter(payment_method=payment_method, status='pending')

            return queryset 
        return PaymentSchoolFees.objects.filter(student=student_id, status='pending')
    
        
class DeclinedPaymentSchoolFeesView(generics.ListAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = PaymentSchoolFeesSerializer
    filter_backends = [ExactSearchFilter]
    search_fields =['student__first_name', 'student__last_name', 'payment_method__name', 'fee_type__fee_choice', 'fee_type__session__name', 'fee_type__term__name', 'fee_type__student_class__name', 'fee_type__amount', 'date']
    
    def get_queryset(self):
        user = self.request.user
        student_id = user.id
        if user.role == 'admin' or user.role == 'bursary':
            queryset = PaymentSchoolFees.objects.filter(status='declined')
            student = self.request.query_params.get('student')
            payment_method = self.request.query_params.get('payment_method')

            if student:
                queryset = queryset.filter(student=student, status='declined')
            if payment_method:
                queryset = queryset.filter(payment_method=payment_method, status='declined')

            return queryset 
        return PaymentSchoolFees.objects.filter(student=student_id, status='declined')   
    
    
    
class ApprovedPaymentSchoolFeesView(generics.ListAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = PaymentSchoolFeesSerializer
    filter_backends = [ExactSearchFilter]
    search_fields =['student__first_name', 'student__last_name', 'payment_method__name', 'fee_type__fee_choice', 'fee_type__session__name', 'fee_type__term__name', 'fee_type__student_class__name', 'fee_type__amount', 'date']
    
    def get_queryset(self):
        user = self.request.user
        student_id = user.id
        if user.role == 'admin' or user.role == 'bursary':
            queryset = PaymentSchoolFees.objects.filter(status='approved')
            student = self.request.query_params.get('student')
            payment_method = self.request.query_params.get('payment_method')

            if student:
                queryset = queryset.filter(student=student, status='approved')
            if payment_method:
                queryset = queryset.filter(payment_method=payment_method, status='approved')

            return queryset
        return PaymentSchoolFees.objects.filter(student=student_id, status='approved')         

class PaymentSchoolFeesRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = PaymentSchoolFeesSerializer
    permission_classes = [IsAdminorBursary]
    queryset = PaymentSchoolFees.objects.all()
    lookup_field = 'pk'
    
class DeleteMultiplePaymentSchoolFeesView(generics.GenericAPIView):
    permission_classes = [IsAdminorBursary]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = PaymentSchoolFees.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
    



class PaymentSchoolFeesUpdateView(generics.RetrieveUpdateAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = PaymentSchoolFeesUpdateStatusSerializer
    
    def get_queryset(self):
        return PaymentSchoolFees.objects.filter(pk=self.kwargs['pk'])
    
    def put(self, request, *args, **kwargs):
        payment_status = request.data.get('status')
        
        instance = self.get_object()
        instance.status = payment_status
        instance.save()
        
        return Response({"message": "Payment status updated successfully."}, status=status.HTTP_200_OK)
    
    
class BillsView(generics.ListAPIView):
    serializer_class = BillsSerializer
    permission_classes = [IsAdminOrBursaryOrStudent]
    queryset = Bills.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['bill_name', 'amount']
    
    def post(self, request, *args, **kwargs):
        bill_name = request.data.get('bill_name')
        
        if Bills.objects.filter(bill_name=bill_name).exists():
            return Response(
                {"error": "Bill already exists with this bill name"},
                status=status.HTTP_400_BAD_REQUEST 
            )
            
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
class BillsRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = BillsSerializer
    permission_classes = [IsAdminorBursary]
    queryset = Bills.objects.all()
    lookup_field = 'pk'
    
    
class DeleteMultipleBillsView(generics.GenericAPIView):
    permission_classes = [IsAdminorBursary]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Bills.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
    
class GetBillsAmountView(generics.GenericAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = GetBillsAmountSerializer
    
    def post(self, request, *args, **kwargs):
        bill_name = request.data.get('bill_name')
        
        try:
            bill = Bills.objects.get(bill_name=bill_name)
            return Response({'id': bill.id, "amount": bill.amount}, status=status.HTTP_200_OK)
        except Bills.DoesNotExist:
            return Response({"error": "Bill not found for the provided details."}, status=status.HTTP_404_NOT_FOUND)       
        

class BillsPaymentView(generics.ListCreateAPIView):
    serializer_class = BillPaymentSerializer
    permission_classes = [IsAdminOrBursaryOrStudent]
    filter_backends = [ExactSearchFilter]
    search_fields = ['student__first_name', 'student__last_name', 'bill__bill_name', 'bill__amount', 'status', 'date']
    
    def get_queryset(self):
        user = self.request.user
        
        if user.role == 'admin' or user.role == 'bursary':
            queryset = BillPayment.objects.all()
            student = self.request.query_params.get('student')
            bill_type = self.request.query_params.get('bill_type')

            if student:
                queryset = queryset.filter(student=student)
            if bill_type:
                queryset = queryset.filter(bill_type=bill_type)

            return queryset
        return BillPayment.objects.filter(student=user.id)
    
    
class PendingBillsPaymentView(generics.ListAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = BillPaymentSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['student__first_name', 'student__last_name', 'bill__bill_name'  , 'bill__amount', 'status', 'date']
    
    def get_queryset(self):
        user = self.request.user
        
        if user.role == 'admin' or user.role == 'bursary':
            queryset = BillPayment.objects.filter(status='pending')
            student = self.request.query_params.get('student')
            bill_type = self.request.query_params.get('bill_type')

            if student:
                queryset = queryset.filter(student=student, status='pending')
            if bill_type:
                queryset = queryset.filter(bill_type=bill_type, status='pending')

            return queryset 
        return BillPayment.objects.filter(student=user.id, status='pending')
    
    
class DeclinedBillsPaymentView(generics.ListAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = BillPaymentSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['student__first_name', 'student__last_name', 'bill__bill_name'  , 'bill__amount', 'status', 'date']
    
    def get_queryset(self):
        user = self.request.user
        
        if user.role == 'admin' or user.role == 'bursary':
            queryset = BillPayment.objects.filter(status='declined')
            student = self.request.query_params.get('student')
            bill_type = self.request.query_params.get('bill_type')

            if student:
                queryset = queryset.filter(student=student, status='declined')
            if bill_type:
                queryset = queryset.filter(bill_type=bill_type, status='declined')

            return queryset 
        return BillPayment.objects.filter(student=user.id, status='declined')
    

class ApprovedBillsPaymentView(generics.ListAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = BillPaymentSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['student__first_name', 'student__last_name', 'bill__bill_name'  , 'bill__amount', 'status', 'date']
    
    def get_queryset(self):
        user = self.request.user
        
        if user.role == 'admin' or user.role == 'bursary':
            queryset = BillPayment.objects.filter(status='approved')
            student = self.request.query_params.get('student')
            bill_type = self.request.query_params.get('bill_type')

            if student:
                queryset = queryset.filter(student=student, status='approved')
            if bill_type:
                queryset = queryset.filter(bill_type=bill_type, status='approved')

            return queryset 
        return BillPayment.objects.filter(student=user.id, status='approved')
    

class BillsPaymentRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = BillPaymentSerializer
    permission_classes = [IsAdminorBursary]
    queryset = BillPayment.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleBillsPaymentView(generics.GenericAPIView):
    permission_classes = [IsAdminorBursary]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = BillPayment.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
    
class BillsPaymentUpdateView(generics.RetrieveUpdateAPIView):
    permission_classes = [IsAdminOrBursaryOrStudent]
    serializer_class = BillPaymentUpdateStatusSerializer
    
    def get_queryset(self):
        return BillPayment.objects.filter(pk=self.kwargs['pk'])
    
    def put(self, request, *args, **kwargs):
        payment_status = request.data.get('status')
        
        instance = self.get_object()
        instance.status = payment_status
        instance.save()
        
        return Response({"message": "Payment status updated successfully."}, status=status.HTTP_200_OK)
    

class BankAccountView(generics.ListCreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = BankAccountSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['bank_name', 'account_number', 'account_name']
    
    
    def get_queryset(self):
        queryset = BankAccount.objects.all()
        status = self.request.query_params.get('status')
            
        if status:
            if status == 'active':
                queryset = queryset.filter(is_active=True)
            elif status == 'disable':
                queryset = queryset.filter(is_active=False)
        return queryset
    
    
    
    def post(self, request, *args, **kwargs):
        user = request.user
        if(user.role == 'admin' or user.role == 'bursary'):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a notification."}, status=status.HTTP_403_FORBIDDEN)
 
class BankAccountRetrieveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = BankAccountSerializer
    permission_classes = [IsAdminorBursary]
    queryset = BankAccount.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleBankAccountView(generics.GenericAPIView):
    permission_classes = [IsAdminorBursary]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = BankAccount.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
     
     
class ActiveBankAccountView(generics.ListAPIView):
    permission_classes = [AllowAny]
    serializer_class = BankAccountSerializer
    
    def get_queryset(self):
        return BankAccount.objects.filter(is_active=True)        

# --------------------------------------------- E commerce ------------------------------------ #
class ProductCategoriesView(generics.ListCreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = ProductCategoriesSerializer
    queryset = ProductCategories.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['name']
    
    
    def post(self, request, *args, **kwargs):
        user = request.user
        if(user.role == "admin" or user.role == "store_keeper"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a notification."}, status=status.HTTP_403_FORBIDDEN)
        
        
class ProductCategoriesRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ProductCategoriesSerializer
    permission_classes = [IsAdminOrStoreKeeper]
    queryset = ProductCategories.objects.all()
    lookup_field = 'pk'
    
class DeleteMultipleProductCategoriesView(generics.GenericAPIView):
    permission_classes = [IsAdminOrStoreKeeper]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = ProductCategories.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)
    
    
class ProductView(generics.ListCreateAPIView):
    permission_classes = [AllowAny]
    serializer_class = ProductSerializer
    filter_backends = [ExactSearchFilter]
    search_fields = ['name', 'product_id', 'category__name', 'price', 'discount_price', 'price']
    
    def get_queryset(self):
        queryset = Product.objects.all()
        product_category = self.request.query_params.get('product_category')
        status = self.request.query_params.get('status')
        
        if product_category:
            queryset = queryset.filter(category=product_category)
            
        if status:
            if status == 'active':
                queryset = queryset.filter(is_active=True)
            elif status == 'disable':
                queryset = queryset.filter(is_active=False)
        return queryset
        
    
    
    def post(self, request, *args, **kwargs):
        user = request.user
        if(user.role == "admin" or user.role == "store_keeper"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a notification."}, status=status.HTTP_403_FORBIDDEN)
   
   
class ProductRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ProductSerializer
    permission_classes = [IsAdminOrStoreKeeper]
    queryset = Product.objects.all()
    lookup_field = 'pk'
    
    
class DeleteMultipleProductView(generics.GenericAPIView):
    permission_classes = [IsAdminOrStoreKeeper]
    serializer_class = DeleteMultipleIDSerializer
    
    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        ids = serializer.validated_data['ids']
        deleted_count, _ = Product.objects.filter(id__in=ids).delete()
        return Response({"message": f"{deleted_count} data deleted successfully."}, status=status.HTTP_204_NO_CONTENT)


class FavoriteProductsView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = FavouriteProductSerializer
    queryset = FavouriteProduct.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['product__name']
    
    def get_queryset(self):
        user = self.request.user
        return FavouriteProduct.objects.filter(user=user)
    
    def post(self, request, *args, **kwargs):
        user = request.user
        product_id = request.data.get('product')
        
        if FavouriteProduct.objects.filter(user=user, product=product_id).exists():
            return Response({"error": "Product already in favorites."}, status=status.HTTP_400_BAD_REQUEST)
        
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(user=user)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
        
    
class FavoriteProductsRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated] 
    serializer_class = FavouriteProduct
    queryset = FavouriteProduct.objects.all()
    lookup_field = 'pk'        
    
class CartView(generics.ListCreateAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = CartSerializer
    queryset = Cart.objects.all()
    filter_backends = [ExactSearchFilter]
    search_fields = ['product__name']
    
    def get_queryset(self):
        user = self.request.user
        return Cart.objects.filter(user=user)
    
    def post(self, request, *args, **kwargs):
        user = request.user
        product_id = request.data.get('product') 
        
        if Cart.objects.filter(user=user, product=product_id).exists():
            return Response({"error": "Product already in cart."}, status=status.HTTP_400_BAD_REQUEST)
        
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save(user=user)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
         
         
class CartRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated] 
    serializer_class = CartSerializer
    queryset = Cart.objects.all()
    lookup_field = 'pk' 
    
class IncreaseCartProductQuantityView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]       
    serializer_class = EditingCartItemSerializer
    
    def post(self, request, *args, **kwargs):
        user = request.user
        product_id = request.data.get('product') 
        
        try:  
            cart = Cart.objects.get(user=user, product=product_id)
            cart.quantity += 1
            cart.save()
            return Response({"message": "Product quantity increased successfully."}, status=status.HTTP_200_OK)
        except Cart.DoesNotExist:
            Cart.objects.create(user=user, product=product_id, quantity=1)
            return Response({"error": "Product added to cart"}, status=status.HTTP_200_OK)
             
    
class DecreaseCartProductQuantityView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]       
    serializer_class = EditingCartItemSerializer
    
    def post(self, request, *args, **kwargs):
        user = request.user
        product_id = request.data.get('product') 
        
        try:
            cart = Cart.objects.get(user=user,  product=product_id)
        except Cart.DoesNotExist:
            return Response({"error": "Cart item not found."}, status=status.HTTP_404_NOT_FOUND)
        
        if cart.quantity > 1:
            cart.quantity -= 1
            cart.save()
        else:
            cart.delete()
            
        return Response({"message": "Product quantity decreased successfully."}, status=status.HTTP_200_OK)
                                                                                                                                                                                      
class RemoveCartProductView(generics.GenericAPIView):
    permission_classes = [IsAuthenticated]       
    serializer_class = EditingCartItemSerializer
    
    def post(self, request, *args, **kwargs):
        user = request.user
        product_id = request.data.get('product') 
        
        try:
            cart = Cart.objects.get(user=user,  product=product_id)
        except Cart.DoesNotExist:
            return Response({"error": "Cart item not found."}, status=status.HTTP_404_NOT_FOUND)
        
        cart.delete()
        
        return Response({"message": "Product removed from cart successfully."}, status=status.HTTP_200_OK)                                                                                                                                                                                                                                
                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                         

@method_decorator(csrf_exempt, name='dispatch')
class PaystackWebhookView(APIView):
    def post(self, request, *args, **kwargs):
        payload = json.loads(request.body)
        event = payload.get("event")

        if event == "charge.success":
            data = payload.get("data", {})
            reference = data.get("reference")

            try:
                order = Order.objects.get(reference=reference)
                order.status = "successful"
                order.save()
                return Response({"message": "Order updated to successful"}, status=status.HTTP_200_OK)
            except Order.DoesNotExist:
                return Response({"error": "Order not found"}, status=status.HTTP_404_NOT_FOUND)

        elif event == "charge.failed":
            data = payload.get("data", {})
            reference = data.get("reference")

            try:
                order = Order.objects.get(reference=reference)
                order.status = "failed"
                order.save()
                return Response({"message": "Order updated to failed"}, status=status.HTTP_200_OK)
            except Order.DoesNotExist:
                return Response({"error": "Order not found for failed payment"}, status=status.HTTP_404_NOT_FOUND)

        return Response({"message": "Unhandled event"}, status=status.HTTP_200_OK)
                                                                                                                                                                                                                                     
                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                         
                                                                                                                                                                                                                                         




class CreateOrderView(APIView):
    # serializer_class = CreateOrderSerializer
    permission_classes = [IsAuthenticated]
    
    def post(self, request):
        user = request.user
        cart_items = Cart.objects.filter(user=user)
        
        if not cart_items.exists():
            return  Response({"error": "Cart is empty"}, status=status.HTTP_400_BAD_REQUEST)
        
        product_data = []
        total_amount = 0
        
        for item in cart_items:
            price = item.product.discount_price if item.product.discount_price is not None else item.product.price
            total = item.total_price
            
            product_data.append({
                "product_id": item.product.product_id,
                "name": item.product.name,
                "quantity": item.quantity,
                "price": float(price),
                "total_price" : float(total)
            })
            
            total_amount += total
            
        reference = str(uuid.uuid4())
        email = user.email
        amount_in_kobo = int(total_amount * 1000)
        
        try:
            paystack_response = Paystack.initialize_payment(
                email=email,
                amount=amount_in_kobo,
                reference=reference    
            )
        except Exception as e:
            return Response({"error": "Payment initialization failed", "details": str(e)},
                            status=status.HTTP_502_BAD_GATEWAY)

        order = Order.objects.create(
            user=user,
            products=product_data,
            total_amount = total_amount,
            status='processing',
            reference=reference,
        )
        cart_items.delete()
        return Response({
            "message": "Order created successfully",
            "order_id": order.id,
            "payment_url": paystack_response['data']['authorization_url'],
            "reference": reference,
            "public_key": settings.PAYSTACK_PUBLIC_KEY
        }, status=status.HTTP_201_CREATED)
        
        
        

            
  
  
class CurrentUserView(APIView):
    permission_classes = [IsAuthenticated]
    
    def get(self, request):
        serializer = UsersSerializer(request.user)
        return Response(serializer.data)       