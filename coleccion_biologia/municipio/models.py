import uuid
from django.db import models

from departamento.models import Departamento

class Municipio(models.Model):
    '''Municipio'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    departamento = models.ForeignKey(Departamento, on_delete=models.PROTECT, null = False)
    description = models.CharField(max_length=150)
    is_active = models.BooleanField(default=True)

    REQUIRED_FIELDS = ['departamento', 'description']