import uuid
from django.db import models

from organism.models import Organism
from taxonomic_level.models import TaxonomicLevel

class OrganismTaxonomy(models.Model):
    '''Organism Taxonomy Model'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    description = models.CharField(max_length=75)
    organism = models.ForeignKey(Organism, on_delete=models.PROTECT, null = False)
    taxonomic_level = models.ForeignKey(TaxonomicLevel, on_delete=models.PROTECT, null = False)

    REQUIRED_FIELDS = ['description', 'organism', 'taxonomic_level']
