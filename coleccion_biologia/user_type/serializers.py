from rest_framework import serializers

from . import models

class UserTypeSerializer(serializers.ModelSerializer):
    '''User Type Serializer'''

    class Meta:
        model = models.UserType
        fields = (
            'id',
            'description'
        )

'''
{
    'id': asdf-asdf-asdf,
    'description': "Administrador"
}
'''