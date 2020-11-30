from rest_framework import serializers

from . import models

class OrganismTaxonomySerializer(serializers.ModelSerializer):
    '''Organism Taxonomy Serializer'''

    class Meta:
        model = models.OrganismTaxonomy
        fields = (
            'id',
            'description',
            'organism',
            'taxonomic_level'
        )