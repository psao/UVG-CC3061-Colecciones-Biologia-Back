import uuid
from django.db import models
from django.contrib.auth.models import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.contrib.auth.models import BaseUserManager

class TaxonomicLevel(models.Model):
    '''Taxonomic Level Model'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    description = models.CharField(max_length=50)
    order = models.IntegerField()
    is_active = models.BooleanField(default=True)

    REQUIRED_FIELDS = ['description', 'order']