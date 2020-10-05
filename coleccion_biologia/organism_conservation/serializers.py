from rest_framework import serializers

from . import models

class OrganismConservationSerializer(serializers.ModelSerializer):
    '''Organism Conservation Serializer'''

    class Meta:
        model = models.OrganismConservation
        fields = (
            'id',
            'description',
            'is_active'
        )