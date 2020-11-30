from rest_framework import serializers

from . import models

class AuthorizeOrganismSerializer(serializers.ModelSerializer):
    '''Authorize Organism Serializer'''

    class Meta:
        model = models.AuthorizeOrganism
        fields = (
            'id',
            'authorizing_user',
            'organism',
            "authorization_date"
        )