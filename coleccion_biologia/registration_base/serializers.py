from rest_framework import serializers

from . import models

class RegistrationBaseSerializer(serializers.ModelSerializer):
    '''Registration Base Serializer'''

    class Meta:
        model = models.RegistrationBase
        fields = (
            'id',
            'description',
            'is_active'
        )