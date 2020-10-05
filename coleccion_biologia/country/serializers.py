from rest_framework import serializers

from . import models

class CountrySerializer(serializers.ModelSerializer):
    '''Country Serializer'''

    class Meta:
        model = models.Country
        fields = (
            'id',
            'description',
            'is_active'
        )