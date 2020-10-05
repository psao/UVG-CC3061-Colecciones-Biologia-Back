import uuid
from django.db import models
from django.contrib.auth.models import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.models import BaseUserManager

from user_type.models import UserType

class OrganismConservation(models.Model):
    '''Organism Conservation'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    description = models.CharField(max_length=50)
    is_active = models.BooleanField(default=True)

    REQUIRED_FIELDS = ['description']