from rest_framework import serializers

from . import models

class MunicipioSerializer(serializers.ModelSerializer):
    '''Municipio Serializer'''

    class Meta:
        model = models.Municipio
        fields = (
            'id',
            'departamento',
            'description',
            'is_active'
        )