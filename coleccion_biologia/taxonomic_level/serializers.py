from rest_framework import serializers

from . import models

class TaxonomicLevelSerializer(serializers.ModelSerializer):
    '''Taxonomic Level Serializer'''

    class Meta:
        model = models.TaxonomicLevel
        fields = (
            'id',
            'description',
            'order',
            'is_active'
        )