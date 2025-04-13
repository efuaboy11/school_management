from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import generics, status, permissions
from rest_framework.permissions import IsAdminUser, IsAuthenticated, AllowAny
from rest_framework_simplejwt.tokens import RefreshToken, TokenError
from .models import *
from .serializers import *
from .permission import *
from .verification import *
from datetime import datetime
from django.template.loader import render_to_string
from django.utils.crypto import get_random_string
from .smpt import *
# Create your views here.
@api_view(['GET'])
def endpoints(request):
    data = [
        "users/",
    ]
    return Response(data)

class UsersView(generics.ListAPIView):
    permission_classes = [IsAdminUser]
    queryset = Users.objects.all()
    serializer_class = UsersSerializer
    
    
class StudentView(generics.ListCreateAPIView):
    permission_classes = [IsAdminOrHR]
    queryset = Student.objects.all()
    serializer_class = StudentSerializer
    
    def post(self, request):
        reg_serializer = self.get_serializer(data=request.data)
        
        if reg_serializer.is_valid():
            instance = reg_serializer.save()
 
            email = instance.email
            
            
            
            student = reg_serializer.save()
            
            if student:
                return Response(reg_serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(reg_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
        
        
class StaffView(generics.ListCreateAPIView):
    permission_classes = [IsAdminOrHR]
    queryset = Staff.objects.all()
    serializer_class = StaffSerializer
    
    def post(self, request):
        reg_serializer = self.get_serializer(data=request.data)
        
        if reg_serializer.is_valid():
            instance = reg_serializer.save()
 
            email = instance.email
            
            staff = reg_serializer.save()
            
            if staff:
                return Response(reg_serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(reg_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
    
    
class HRView(generics.ListCreateAPIView):
    permission_classes = [IsAdminUser]
    queryset = HR.objects.all()
    serializer_class = HRSerializer
    
    def post(self, request):
        reg_serializer = self.get_serializer(data=request.data)
        
        if reg_serializer.is_valid():
            instance = reg_serializer.save()
 
            email = instance.email
        
            
            hr = reg_serializer.save()
            
            if hr:
                return Response(reg_serializer.data, status=status.HTTP_201_CREATED)
        
        return Response(reg_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
 
class TeachersView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    
    def get_queryset(self):
        return Staff.objects.filter(role="teacher")       
    
class BursaryView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    
    def get_queryset(self):
        return Staff.objects.filter(role="bursary")
  
class StoreKeeperView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    
    def get_queryset(self):
        return Staff.objects.filter(role="store_keeper")
    
class OtherStaffView(generics.ListAPIView):
    serializer_class = StaffSerializer
    permission_classes = [IsAdminOrHR]
    
    def get_queryset(self):
        return Staff.objects.filter(role="other_staff")  
    
    
class ParentViews(generics.ListCreateAPIView):
    serializer_class = ParentSerializer
    permission_classes = [IsAdminOrHR]
    queryset = Parent.objects.all()
    
    
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
            
class CustomRefreshTokenView(TokenRefreshSerializer):
    serializers_class = CustomTokenRefreshSerializer
    
    
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
            domain = "https://yourdomain.com"
            url = f"{domain}/change-password/{instance.token}/"
            
        
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
   
   
# Email         
class EmailView(generics.ListCreateAPIView):
    serializer_class = EmailSerializer
    permission_classes = [IsAdminOrHR]
    queryset =   Email.objects.all()
    
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
    

#Subjects
class SubjectsView(generics.ListCreateAPIView):
    serializer_class = SubjectsSerializer
    permission_classes = [IsAuthenticated]
    queryset = Subjects.objects.all()
    
class SubjectsRetriveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SubjectsSerializer
    permission_classes = [IsAdminOrAcademicOfficer]
    queryset = Subjects.objects.all()
    lookup_field = 'pk'
    

# Students Classes
class StudentClassView(generics.ListCreateAPIView):
    serializer_class = StudentClassSerializer
    permission_classes = [IsAuthenticated]
    queryset = StudentClass.objects.all()

class StudentClassRetriveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = StudentClassSerializer
    permission_classes = [IsAdminOrAcademicOfficer]
    queryset = StudentClass.objects.all()
    lookup_field = 'pk'                
 

# Terms

class TermView(generics.ListCreateAPIView):
    serializer_class = TermSerializer
    permission_classes = [IsAuthenticated]
    queryset = Term.objects.all()

class TermRetriveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = TermSerializer
    permission_classes = [IsAdminOrAcademicOfficer]
    queryset = Term.objects.all()
    lookup_field = 'pk'                
 
 
# Session
class SessionView(generics.ListCreateAPIView):
    serializer_class = SessionSerializer
    permission_classes = [IsAuthenticated]
    queryset = Session.objects.all()

class SessionRetriveUpdateDestory(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = SessionSerializer
    permission_classes = [IsAdminOrAcademicOfficer]
    queryset = Session.objects.all()
    lookup_field = 'pk'                
 
 
class AdminorHRNotificationView(generics.ListCreateAPIView):
    serializer_class = AdminorHRNotificationSerializer
    permission_classes = [IsAdminOrHR]
    queryset = AdminorHRNotification.objects.all()
    
    
class AdminorHRNotificationRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = AdminorHRNotificationSerializer
    permission_classes = [IsAdminOrHR]
    queryset = AdminorHRNotification.objects.all()
    lookup_field = 'pk'
    
class SchoolNotificationView(generics.ListCreateAPIView):
    serializer_class = SchoolNotificationSerializer
    permission_classes = [IsAuthenticated]
    queryset = SchoolNotification.objects.all()
    
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
    
class ClassNotificationView(generics.ListCreateAPIView):
    serializer_class = ClassNotificationSerializer
    permission_classes = [IsAdminOrTeacherorStudent]
    queryset = ClassNotification.objects.all()
    
    def post(self, request, *args, **kwargs):
        user = request.user
        
        if(user.role == "admin" or user.role == "teacher"):
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response({"error": "You do not have permission to create a notification."}, status=status.HTTP_403_FORBIDDEN)

class ClassNotificationRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ClassNotificationSerializer
    permission_classes = [IsAdminOrTeacher]
    queryset = ClassNotification.objects.all()
    lookup_field = 'pk'
    
class FilteredClassNotification(generics.ListAPIView):
    permission_classes = [IsAdminOrTeacherorStudent]
    serializer_class = ClassNotificationSerializer
    
    def get_queryset(self):
        student_class = self.request.query_params.get('student_class')
        
        if student_class:
            return ClassNotification.objects.filter(student_class=student_class)    
        return ClassNotification.objects.none()
    
    def list(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        if not queryset.exists():
            return Response({"message": "No notifications found for this class."}, status=status.HTTP_404_NOT_FOUND)
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
        
        

class SchoolEventView(generics.ListCreateAPIView):
    serializer_class = SchoolEventSerializer
    permission_classes = [IsAuthenticated]
    queryset = SchoolEvent.objects.all()
    
    
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
    permission_classes = [IsAdminOrTeacher]
    queryset = SchoolEvent.objects.all()
    lookup_field = 'pk'
    
# --------------------------------------------- Result ---------------------- #

# Generator of scratch Card 
class GenerateScratchCardView(generics.GenericAPIView):
    serializer_class =  GenerateScratchCardSerializer
    permission_classes = [IsAdminOrExamOfficer]
    
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