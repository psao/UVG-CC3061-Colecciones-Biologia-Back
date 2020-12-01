import uuid
from django.db import models

from country.models import Country
from departamento.models import Departamento
from municipio.models import Municipio
from life_stage.models import LifeStage
from organism_conservation.models import OrganismConservation
from registration_base.models import RegistrationBase

class Organism(models.Model):
    '''Organism Model'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    scientific_name = models.CharField(max_length=75)
    kingdom = models.CharField(max_length=75, null = True)
    phile = models.CharField(max_length=75, null = True)
    clase = models.CharField(max_length=75, null = True)
    family = models.CharField(max_length=75, null = True)
    common_name = models.CharField(max_length=75)
    colector = models.CharField(max_length=50)
    country = models.ForeignKey(Country, on_delete=models.PROTECT, null = False)
    departamento = models.ForeignKey(Departamento, on_delete=models.PROTECT, null = False)
    municipio = models.ForeignKey( Municipio, on_delete=models.PROTECT, null = False)
    location = models.CharField(max_length=255)
    latitud = models.DecimalField(decimal_places=7, max_digits=11)
    longitud = models.DecimalField(decimal_places=7, max_digits=11)
    altitud = models.DecimalField(decimal_places=7, max_digits=11)
    gps_uncertainty = models.DecimalField(decimal_places=7, max_digits=11)
    habitat = models.CharField(max_length=100)
    sex = models.CharField(max_length=1)
    life_stage = models.ForeignKey(LifeStage, on_delete=models.PROTECT, null = True)
    collector_comments = models.TextField()
    date_of_collection = models.DateTimeField()
    organism_conservation = models.ForeignKey(OrganismConservation, on_delete=models.PROTECT, null = True)
    registration_base = models.ForeignKey(RegistrationBase, on_delete=models.PROTECT, null = True)
    information = models.TextField()
    published = models.BooleanField(default=False)

    REQUIRED_FIELDS = ['scientific_name', 'common_name', 'country', 'departamento', 'municipio']
