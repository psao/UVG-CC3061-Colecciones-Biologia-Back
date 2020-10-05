from rest_framework import serializers

from . import models

class LifeStageSerializer(serializers.ModelSerializer):
    '''Life Stage Serializer'''

    class Meta:
        model = models.LifeStage
        fields = (
            'id',
            'description',
            'is_active'
        )