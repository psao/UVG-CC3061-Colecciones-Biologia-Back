from rest_framework import serializers

from . import models

class DepartamentoSerializer(serializers.ModelSerializer):
    '''Departamento Serializer'''

    class Meta:
        model = models.Departamento
        fields = (
            'id',
            'country',
            'description',
            'is_active'
        )