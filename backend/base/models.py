from django.db import models
import random
import string
from django.contrib.auth.models import AbstractUser, BaseUserManager, Group, Permission
from django.utils import timezone
import uuid
import secrets

class Role(models.TextChoices):
    ADMIN = 'admin', "Admin"
    HR = 'hr', 'HR'
    STUDENTS = 'student', 'student'
    TEACHERS = 'teacher', 'Teacher'
    BURSARY = 'bursary', 'Bursary'
    STORE_KEEPER = 'store_keeper', 'Store Keeper'
    RESULT_OFFICER = 'result_officer', "Result Officer"
    ACADEMIC_OFFICER = 'academic_officer', "Academic officer"
    OTHER_STAFF = 'other_staff', 'Other_staff'
    
class CustomAccountManager(BaseUserManager):
    def create_user(self, first_name, last_name, email,  **extra_fields):
        if not email:
            return ValueError("The Email field must be set")
        email = self.normalize_email(email)
        extra_fields.setdefault('role', Role.OTHER_STAFF)
        user = self.model(first_name=first_name, last_name=last_name, email=email,  **extra_fields)
        user.set_password(user.password)
        user.save(using=self._db)
        return user
    
    def create_superuser(self, first_name, last_name, email, password,  **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('role', Role.ADMIN)
        
        return self.create_user(first_name, last_name, email,  password=password, **extra_fields)
    
# -------------------------------- Registering  Users  ------------------------------ 

# users model
class Users(AbstractUser):
    
    ACCOUNT_STATUS = [
        ('active', 'ACTIVE'),
        ('disabled', 'DISABLED')
    ]
    SEX = [
        ("male", "MALE"),
        ("female", "FEMALE")
    ]
    
    RELIGIONS = [
        ("christian", "CHRISTIAN"),
        ("muslim", "MUSLIM"),
        ("others", "OTHERS")
    ]
    
    DISABILITY = [
        ('yes', 'YES'),
        ('no', 'NO'),
    ]

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False) 
    userID = models.CharField(max_length=20, unique=True, blank=True)
    first_name = models.CharField(max_length=50, null=True, blank=True)
    last_name = models.CharField(max_length=50, null=True, blank=True)
    date_of_birth = models.DateField(null=True, blank=True)
    home_address = models.TextField(null= True, blank=True)
    email = models.EmailField(unique=True)
    state_of_origin = models.CharField(max_length=100, blank=True, null=True)
    religion = models.CharField(max_length=30,  choices=RELIGIONS)
    phone_number = models.CharField(max_length=15, null=True, blank=True)
    disability = models.CharField(max_length=20,  choices=DISABILITY)
    disability_note = models.TextField(null=True, blank=True)
    city_or_town = models.CharField(max_length=255, blank=True, null=True)
    failed_login_attempts = models.IntegerField(default=0)
    role = models.CharField(max_length=20, choices=Role.choices, default=Role.OTHER_STAFF)
    account_status = models.CharField(max_length=20, choices=ACCOUNT_STATUS, default='active')
    date_joined = models.DateTimeField(default=timezone.now)
    groups = models.ManyToManyField(Group, related_name="custom_user_groups", blank=True)
    user_permissions = models.ManyToManyField(Permission, related_name="custom_user_permissions", blank=True)
    USERNAME_FIELD = "username"
    REQUIRED_FIELDS = ["first_name", "last_name", "email", "role"]
    objects = CustomAccountManager()
    
    def save(self, *args, **kwargs):
        if not self.userID:
            self.userID = self.generate_userID()
            
        if self.pk is None or not self.password.startswith('pbkdf2_'):
            self.set_password(self.password)
        super().save(*args, **kwargs)
    
    
    def generate_userID(self):
        role_prefix = {
            "student": "stu",
            "teacher": "tch",
            "bursary": "bur",
            "store_keeper": "skp",
            "hr": "hmr",
            'exam_officer': "exf",
            "other_staff": "oth",
        }
        
        prefix = role_prefix.get(self.role, 'oth')
        last_name_part = self.last_name[:3].lower() if self.last_name else "xxx"
        random_digits = "".join(random.choices(string.digits, k=3))
        return f"{prefix}{last_name_part}{random_digits}"
    

# staff modelb
class Staff(Users):
    MARITIAL_STATUS = [
        ("married", "MARRIED"),
        ("single", "SINGLE")
    ]
    COMPUTER_SKILLS = [
        ("yes", "YES"),
        ("no", "NO")
    ]
    EMPLOYMENT_TYPE =[
        ("full_time", "Full Time"),
        ("part_time", "Part Time"),
    ]
    
    department = models.CharField(max_length=100, blank=True, null=True)    
    employment_type = models.CharField(max_length=50, choices=EMPLOYMENT_TYPE,  blank=True, null=True)
    maritial_status = models.CharField(max_length=20,  blank=True, null=True, choices=MARITIAL_STATUS)
    years_of_experience = models.CharField(max_length=50, null=True, blank=True)
    computer_skills = models.CharField(max_length=20,  blank=True, null=True, choices=COMPUTER_SKILLS)
    assigned_class = models.ForeignKey('StudentClass', on_delete=models.CASCADE, related_name="assigned_class", null=True, blank=True)
    passport = models.ImageField(upload_to="staff_passport", null=True)
    flsc = models.FileField(upload_to="staff_flsc", null=True)
    waec_neco_nabteb_gce = models.FileField(upload_to="staff_waec_neco_nabteb_gce", null=True)
    degree = models.FileField(upload_to="staff_degree", null=True)
    other_certificates = models.FileField(upload_to="staff_other_certificates", null=True)
    cv = models.FileField(upload_to="staff_cv", null=True, blank=True)
    staff_speech = models.TextField(null=True, blank=True)
    
    class Meta:
        verbose_name_plural = "Staffs"
        
    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    

# HR model
class HR(Users):
    office_location = models.CharField(max_length=100, blank=True, null=True)
    passport = models.ImageField(upload_to="hr_passport", null=True)
    qualification = models.FileField(upload_to="hr_qualification", null=True)

#students model
class Student(Users):
    
    father_name = models.CharField(max_length=255, blank=True, null=True)
    mother_name = models.CharField(max_length=255, blank=True, null=True)
    gurdian_name = models.CharField(max_length=255, blank=True, null=True)
    admission_number = models.CharField(max_length=20, unique=True)
    student_class = models.ForeignKey('StudentClass', on_delete=models.CASCADE, related_name="students", null=True)
    passport = models.ImageField(upload_to="student_passport", null=True)
    
    class Meta:
        verbose_name_plural = "Students"
    
    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    
    
class Parent(models.Model):
    name = models.CharField(max_length=255, null=True, blank=True)
    phone_number = models.CharField(max_length=15, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    image = models.ImageField(
        upload_to="parents_images", null=True, blank=True)
    address = models.TextField(null=True, blank=True)
    children_name = models.TextField(null=True, blank=True)

    class Meta:
        verbose_name_plural = "Parents"

    def __str__(self):
        return self.name
    
# Disable account 
class DisableAccount(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE,)
    reason = models.TextField(max_length=200, null=True, blank=True)
    disabled_at = models.DateTimeField(default=timezone.now) 
    
    def save(self, *args, **kwargs):
        user = Users.objects.get(id=self.user.id)
        user.account_status = 'disabled'
        user.save()
        super(DisableAccount, self).save(*args, **kwargs)
        
    

class RequestToChangePassword(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('canceled', 'Canceled'),
        ('approved', 'Approved'),
    ]
    user = models.ForeignKey(Users, on_delete=models.CASCADE)
    request_date = models.DateTimeField(default=timezone.now)
    approved_status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='pending')
    approved_date = models.DateTimeField(null=True, blank=True)
    
    # Add fields for token and expiry
    token = models.UUIDField(default=uuid.uuid4, unique=True)
    token_expiry = models.DateTimeField(null=True, blank=True)
    
    def is_token_valid(self):
        return self.token_expiry and timezone.now() <= self.token_expiry
    
    def __str__(self):
        return f"Password Change Request for {self.user.username}"

# Admin or HR notification
class AdminorHRNotification(models.Model):
    text = models.TextField(max_length=200, null=True, blank=True)
    seen = models.BooleanField(default=False)
    date = models.DateTimeField(default=timezone.now) 
    
    
# Email 
class Email(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('failed', 'Failed'),
        ('delivered', 'Delivered'),
    ]
    
    to = models.EmailField(blank=True, null=True)
    subject = models.CharField(max_length=100, null=True, blank=True)
    body = models.TextField(null=True, blank=True)
    delivery_status =  models.CharField(max_length=10, choices=STATUS_CHOICES, default='pending')
    date = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"Email to {self.to}"
   
   
   

class Subjects(models.Model):
    
    SECTIONS = [
        ('general', 'General'),
        ('pre_school', 'Pre School'),
        ('nursery', 'Nursery'),
        ('primary', 'Primary'),
        ('junior_secondary', 'Junior Secondary'),
        ('senior_secondary', 'Senior Secondary'),
        ('others', 'Others'),
    ]
    
    
    name =  models.CharField(max_length=100, null=True, blank=True)
    sections =  models.CharField(max_length=50, choices=SECTIONS, default='others')
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(default=timezone.now) 
    
    class Meta:
        verbose_name_plural = "Subjects"

    def __str__(self):
        return self.name
    
    
class StudentClass(models.Model):
    name = models.CharField(max_length=50, null=True, blank=True)
    subjects = models.ManyToManyField(
        Subjects, blank=True, related_name='classes')

    class Meta:
        verbose_name_plural = "Class"

    def __str__(self):
        return self.name


class Term(models.Model):
    TERMS = [
        ("first term", "FIRST TERM"),
        ("second term", "SECOND TERM"),
        ("third term", "THIRD TERM")
    ]
    name = models.CharField(max_length=50, blank=True,
                            null=True, choices=TERMS)

    def __str__(self):
        return self.name
    
    
class Session(models.Model):
    name = models.CharField(max_length=100, null=True, blank=True)
    term = models.ManyToManyField(Term,  related_name="terms")

    def __str__(self):
        return self.name

    
# School Notification
class SchoolNotification(models.Model):
    text = models.TextField(max_length=200, null=True, blank=True)
    date = models.DateTimeField(default=timezone.now) 
    

# Class Notification
class ClassNotification(models.Model):
    teacher = models.ForeignKey(Staff, on_delete=models.CASCADE, limit_choices_to={'role': 'teacher'} )
    student_class = models.ForeignKey(StudentClass, on_delete=models.CASCADE, related_name="class_notification")
    text = models.TextField(max_length=200, null=True, blank=True)
    date = models.DateTimeField(default=timezone.now)
    
    def __str__(self):
        return f"Notification for {self.student_class.name} by {self.teacher.first_name} {self.teacher.last_name}"
    
    
# School Event
class SchoolEvent(models.Model):
    title = models.CharField(max_length=100, null=True, blank=True)
    description = models.TextField(null=True, blank=True)
    start_date = models.DateTimeField(default=timezone.now)
    end_date = models.DateTimeField(default=timezone.now)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.title
    
# ---------------------------------------------- Result ------------------------------------------- #

# Student Result
class StudentResult(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    student_class = models.ForeignKey(StudentClass, on_delete=models.CASCADE)
    term = models.ForeignKey(Term, on_delete=models.CASCADE)
    session = models.ForeignKey(Session, on_delete=models.CASCADE)
    
    sex = models.CharField(max_length=10, null=True, blank=True)
    total_marks_obtain = models.CharField(max_length=20, null=True, blank=True)
    student_average = models.CharField(max_length=20, null=True, blank=True)
    class_average = models.CharField(max_length=20, null=True, blank=True)
    students = models.CharField(max_length=20, null=True, blank=True)
    position = models.CharField(max_length=20, null=True, blank=True)
    decision = models.CharField(max_length=20, null=True, blank=True)

    # Affective domain (behavioral performance)
    agility = models.CharField(max_length=20, null=True, blank=True)
    caring = models.CharField(max_length=20, null=True, blank=True)
    communication = models.CharField(max_length=20, null=True, blank=True)
    loving = models.CharField(max_length=20, null=True, blank=True)
    puntuality = models.CharField(max_length=20, null=True, blank=True)
    seriousness = models.CharField(max_length=20, null=True, blank=True)
    socialization = models.CharField(max_length=20, null=True, blank=True)
    attentiveness = models.CharField(max_length=20, null=True, blank=True)
    handling_of_tools = models.CharField(max_length=20, null=True, blank=True)
    honesty = models.CharField(max_length=20, null=True, blank=True)
    leadership = models.CharField(max_length=20, null=True, blank=True)
    music = models.CharField(max_length=20, null=True, blank=True)
    neatness = models.CharField(max_length=20, null=True, blank=True)
    perserverance = models.CharField(max_length=20, null=True, blank=True)
    politeness = models.CharField(max_length=20, null=True, blank=True)
    tools = models.CharField(max_length=20, null=True, blank=True)

    teacher_comment = models.TextField(null=True, blank=True)
    principal_comment = models.TextField(null=True, blank=True)
    next_term_begins = models.TextField(null=True, blank=True)

    subjects = models.ManyToManyField('Subjects', through='SubjectResult')

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Result for {self.student} - {self.term} {self.session}"


class SubjectResult(models.Model):
    student_result = models.ForeignKey(StudentResult, on_delete=models.CASCADE)
    subject = models.ForeignKey('Subjects', on_delete=models.CASCADE)
    total_ca = models.FloatField(null=True, blank=True)
    exam = models.FloatField(null=True, blank=True)
    total = models.FloatField(null=True, blank=True)
    grade = models.CharField(max_length=5, null=True, blank=True)
    position = models.CharField(max_length=10, null=True, blank=True)
    cgpa = models.FloatField(null=True, blank=True)

    def __str__(self):
        return f"{self.student_result.student} - {self.subject}"



def generate_scratch_pin():
    return ''.join(random.choices(string.digits, k=11))

class ScratchCard(models.Model):
    pin = models.CharField(max_length=20, unique=True, default=generate_scratch_pin)
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    trials_left = models.IntegerField(default=5)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def use(self, student_id):
        if not self.is_active or self.trials_left <= 0:
            return False
        if self.student is None:
            self.student = student_id
        elif self.student.id != student_id:
            return False
        self.trials_left -= 1
        if self.trials_left == 0:
            self.is_active = False
        self.save()
        return True
    
    def __str__(self):
        return f"{self.pin} - {self.trials_left} trials"
    

# E-result
class EResult(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    student_class = models.ForeignKey(StudentClass, on_delete=models.CASCADE)
    term = models.ForeignKey(Term, on_delete=models.CASCADE)
    session = models.ForeignKey(Session, on_delete=models.CASCADE)
    result = models.FileField(upload_to="e_result", null=True, blank=True)
    date = models.DateTimeField(default=timezone.now) 
   
# Scheme work 
class SchemeOfWork(models.Model):
    teacher = models.ForeignKey(Staff, on_delete=models.CASCADE, limit_choices_to={'role': 'teacher'}, null=True, blank=True)
    term = models.ForeignKey(Term, on_delete=models.CASCADE)
    subject = models.ForeignKey(Subjects, on_delete=models.CASCADE)
    student_class = models.ForeignKey(StudentClass, on_delete=models.CASCADE)
    scheme = models.FileField(upload_to="scheme_of_work", null=True, blank=True)
    date = models.DateTimeField(default=timezone.now) 
    
    def __str__(self):
        return f"{self.subject} - {self.student_class} - {self.term}"


class Assignment(models.Model):
    teacher = models.ForeignKey(Staff, on_delete=models.CASCADE, limit_choices_to={'role': 'teacher'})
    subject = models.ForeignKey(Subjects, on_delete=models.CASCADE)
    student_class = models.ForeignKey(StudentClass, on_delete=models.CASCADE)
    assignment_name = models.CharField(max_length=100, null=True, blank=True)
    assignment_code = models.CharField(unique=True, max_length=20,  blank=True)
    instructions = models.TextField(null= True, blank=True)
    due_date = models.DateTimeField(default=timezone.now)
    points = models.CharField(max_length=20, null=True, blank=True)
    assignment_file = models.FileField(upload_to="assignment_file", null=True, blank=True)
    assignment_photo = models.ImageField(upload_to="assignment_photo", null=True, blank=True)
    

class AssignmentSubmission(models.Model):
    teacher_assignment = models.ForeignKey(Staff, on_delete=models.CASCADE, limit_choices_to={'role': 'teacher'}, null=True, blank=True)
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    assignment_code = models.CharField(unique=True, max_length=20,  blank=True)
    submission_file = models.FileField(upload_to="assignment_submission", null=True, blank=True)
    submission_photo = models.ImageField(upload_to="assignment_submission_photo", null=True, blank=True)
    date_submitted = models.DateTimeField(default=timezone.now)
    grade = models.CharField(max_length=20, null=True, blank=True)
    feedback = models.TextField(null=True, blank=True)
    
    def __str__(self):
        return f"{self.student} - {self.assignment}"

class ClassTimetable(models.Model):
    student_class = models.OneToOneField(StudentClass, on_delete=models.CASCADE,)
    teacher = models.ForeignKey(Staff, on_delete=models.CASCADE, limit_choices_to={'role': 'teacher'})
    class_timetable = models.FileField(upload_to="class_timetable", null=True, blank=True)  
    created_at = models.DateTimeField(default=timezone.now) 
    
    def __str__(self):
        return f"{self.student_class} - {self.subject} - {self.teacher}"
# user profile 
class UserProfile(models.Model):
    user = models.ForeignKey(Users, on_delete=models.CASCADE,)
    
    def __str__(self):
        return f"{self.user.full_name} Profile"
    
# ------------------------------------ Account --------------------------------------#
class PaymentMethod(models.Model):
    name = models.CharField(max_length=100, null=True, blank=True)
    description = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(default=timezone.now) 
    
    def __str__(self):
        return self.name
    
 
class SchoolFees(models.Model):
    FEES_CHOICES = [
        ('school fees', 'School Fees'),
        ('P.T.A', 'P.T.A'),
    ]
    fee_choice = models.CharField(max_length=100, choices=FEES_CHOICES, null=True, blank=True)
    amount = models.FloatField(null=True, blank=True)
    session = models.ForeignKey(Session, on_delete=models.CASCADE)
    term = models.ForeignKey(Term, on_delete=models.CASCADE)
    student_class = models.ForeignKey(StudentClass, on_delete=models.CASCADE)
    description = models.TextField(null=True, blank=True)
    date = models.DateTimeField(default=timezone.now)
    def __str__(self):
        return f"{self.student_class} - {self.session} - {self.term}"
    

class PaymentSchoolFees(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('declined', 'Declined'),
    ]
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    transaction_id = models.CharField(max_length=100, null=True, blank=True)
    fee_type = models.ForeignKey(SchoolFees, on_delete=models.CASCADE)
    payment_method = models.ForeignKey(PaymentMethod, on_delete=models.CASCADE)
    fee_receipt = models.FileField(upload_to="bill_receipt", null=True, blank=True)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='Pending')
    date = models.DateTimeField(default=timezone.now) 
    
    def generate_transaction_id(self):
        return secrets.token_hex(8).upper()
    
    def save(self, *args, **kwargs):
        if not self.transaction_id:
            self.transaction_id = self.generate_transaction_id()
        super(PaymentSchoolFees, self).save(*args, **kwargs)    
            

    
              
class Bills(models.Model):
    bill_name = models.CharField(max_length=100, null=True, blank=True)
    amount = models.FloatField(null=True, blank=True)
    description = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(default=timezone.now) 
    
    def __str__(self):
        return f"{self.bill_name}"
    
    
class BillPayment(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('declined', 'Declined'),
    ]
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    transaction_id = models.CharField(max_length=100, null=True, blank=True)
    bill = models.ForeignKey(Bills, on_delete=models.CASCADE)
    payment_method = models.ForeignKey(PaymentMethod, on_delete=models.CASCADE)
    bill_receipt = models.FileField(upload_to="bill_receipt", null=True, blank=True)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='Pending')
    date = models.DateTimeField(default=timezone.now) 
    
    def generate_transaction_id(self):
        return secrets.token_hex(8).upper()
    
    def save(self, *args, **kwargs):
        if not self.transaction_id:
            self.transaction_id = self.generate_transaction_id()
        super(BillPayment, self).save(*args, **kwargs)
       
    
    def __str__(self):
        return f"{self.user} - {self.bill}"
    


# ------------------------------------------------- E - commerce ----------------------------------- #

class ProductCategories(models.Model):
    category_id = models.CharField(max_length=100, null=True, blank=True)
    name = models.CharField(max_length=100, unique=True)
    description = models.TextField(blank=True, null=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.name
    
    def generate_category_id(self):
        return secrets.token_hex(8).upper()
    
    def save(self, *args, **kwargs):
        if not self.category_id:
            self.category_id = self.generate_category_id()
        super(ProductCategories, self).save(*args, **kwargs)    
            
    
    
class Product(models.Model):
    product_id = models.CharField(max_length=100, null=True, blank=True)
    category = models.ForeignKey(ProductCategories, on_delete=models.CASCADE, related_name='products')
    name = models.CharField(max_length=200)
    description = models.TextField(blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    discount_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    rating = models.FloatField(default=0)
    image = models.ImageField(upload_to='product_images/', blank=True, null=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.name
    
    def generate_product_id(self):
        return secrets.token_hex(8).upper()
    
    def save(self, *args, **kwargs):
        if not self.product_id:
            self.product_id = self.generate_product_id()
        super(Product, self).save(*args, **kwargs)    
            

  
class FavouriteProduct(models.Model):
    user = models.OneToOneField(Users,on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE) 
    created_at = models.DateTimeField(auto_now_add=True)
    
class Cart(models.Model):
    user = models.ForeignKey(Users,on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    total_price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    date = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"{self.quantity} of {self.product.name} in {self.user.userID}'s cart"
    
    def get_total_price(self):
        price = self.product.discount_price if self.product.discount_price is not None else self.product.price
        return self.quantity * price
    
    def save(self, *args, **kwargs):
        self.total_price = self.get_total_price()
        super(Cart, self).save(*args, **kwargs)
    
   

class Order(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('processing', 'Processing'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled'),
    ]
    
    user =models.ForeignKey(Users, on_delete=models.CASCADE)
    products = models.JSONField(default=list)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(default=timezone.now)
    
    def __str__(self):
        return f"Order #{self.id} - {self.user.userID}"
    
    