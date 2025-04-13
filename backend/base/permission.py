from rest_framework import permissions

class IsAdminOrStudent(permissions.BasePermission):
    """
    Custom permission to only allow admins or student to access the view.
    """

    def has_permission(self, request, view):
        return request.user.is_authenticated and (request.user.role in ["admin", "student"])
    
    
class IsAdminOrHR(permissions.BasePermission):
    """
    Custom permission to only allow admins or HR to access the view.
    """

    def has_permission(self, request, view):
        return request.user.is_authenticated and (request.user.role in ["admin", "hr"])

class IsAdminOrStaff(permissions.BasePermission):
    """
    Custom permission to only allow admins or staff to access the view.
    """

    def has_permission(self, request, view):
        return request.user.is_authenticated and (request.user.role in ["admin", "staff"])
    

class IsAdminOrTeacher(permissions.BasePermission):
    """
    Custom permission to only allow admins or teachers to access the view.
    """

    def has_permission(self, request, view):
        return request.user.is_authenticated and (request.user.role in ["admin", "teacher"])
    
class IsAdminorBursary(permissions.BasePermission):
    """
    Custom permission to only allow admins or bursary to access the view.
    """

    def has_permission(self, request, view):
        return request.user.is_authenticated and (request.user.role in ["admin", "bursary"])    
 
class IsAdminOrStoreKeeper(permissions.BasePermission):
    """
    Custom permission to only allow admins or store keepers to access the view.
    """

    def has_permission(self, request, view):
        return request.user.is_authenticated and (request.user.role in ["admin", "store_keeper"])

   
class IsAdminOrOtherStaff(permissions.BasePermission):
    """
    Custom permission to only allow admins or other staff to access the view.
    """

    def has_permission(self, request, view):
        return request.user.is_authenticated and (request.user.role in ["admin", "other_staff"])
    
    
    
class IsAdminOrTeacherorStudent(permissions.BasePermission):
    """
    Custom permission to only allow admins or other staff to access the view.
    """

    def has_permission(self, request, view):
        return request.user.is_authenticated and (request.user.role in ["admin", "student", 'teacher'])