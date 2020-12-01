from rest_framework import serializers

from . import models

class OrganismSerializer(serializers.ModelSerializer):
    '''Organism Serializer'''

    class Meta:
        model = models.Organism
        fields = (
            'id',
            'scientific_name',
            'kingdom',
            'phile',
            'clase',
            'family',
            'common_name',
            'colector',
            'country',
            'departamento',
            'municipio',
            'location',
            'latitud',
            'longitud',
            'altitud',
            'gps_uncertainty',
            'habitat',
            'sex',
            'life_stage',
            'collector_comments',
            'date_of_collection',
            'organism_conservation',
            'registration_base',
            'information',
            'published',
        )