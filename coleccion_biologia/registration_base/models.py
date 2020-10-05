import uuid
from django.db import models

class RegistrationBase(models.Model):
    '''Registration Base Model'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    description = models.CharField(max_length=50)
    is_active = models.BooleanField(default=True)

    REQUIRED_FIELDS = ['description']