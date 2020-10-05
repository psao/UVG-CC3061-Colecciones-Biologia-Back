import uuid
from django.db import models

from country.models import Country

class Departamento(models.Model):
    '''Departamento'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    country = models.ForeignKey(Country, on_delete=models.PROTECT, null = False)
    description = models.CharField(max_length=50)
    is_active = models.BooleanField(default=True)

    REQUIRED_FIELDS = ['country', 'description']