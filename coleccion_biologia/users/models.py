import uuid
from django.db import models
from django.contrib.auth.models import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.models import BaseUserManager

from user_type.models import UserType

class UserProfileManager(BaseUserManager):
    '''Helps Django to work with our custom model'''

    def create_user(self, email, first_name, last_name, password=None):
        '''Create a new user profile object.'''

        if not email:
            raise ValueError('User must have an email address.')

        email = self.normalize_email(email)
        user = self.model(email=email, first_name=first_name, last_name=last_name)

        user.set_password(password)
        user.save(using=self._db)

        return user
    
    def create_superuser(self, email, first_name, last_name, password):
        '''Creates and saves new superuser with given details'''

        # user_type = UserType.objects.get(pk=user_type)

        user = self.create_user(email, first_name, last_name, password)

        user.is_superuser = True
        user.is_staff = True

        user.save(using=self._db)

        return user

class Users(AbstractBaseUser, PermissionsMixin):
    '''User Model'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    email = models.EmailField(max_length=255, unique=True)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    # user_type = models.ForeignKey(UserType, on_delete=models.PROTECT, null = False)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = UserProfileManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['first_name', 'last_name']

    def get_full_name(self):
        '''Get user's full name'''
        return '{0} {1}'.format(self.first_name, self.last_name)

    def get_short_name(self):
        '''Get user's full name'''
        return self.first_name

    def __str__(self):
        '''To String'''
        return self.email