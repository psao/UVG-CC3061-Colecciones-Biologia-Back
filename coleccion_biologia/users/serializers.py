from rest_framework import serializers

from . import models

class UserSerializer(serializers.ModelSerializer):
    '''User Object Serializer'''

    class Meta:
        model = models.Users
        fields = (
            'id',
            'email',
            'password',
            'first_name',
            'last_name',
            'is_staff',
        )
        extra_kwargs = {'password': {'write_only': True}}
    
    def create(self, validate_data):
        '''Create and return new user'''

        # try:
        #     user_type = validate_data['user_type']
        # except KeyError:
        #     user_type=None
        
        user = models.Users(
            email=validate_data['email'],
            first_name=validate_data['first_name'],
            last_name=validate_data['last_name']
            # user_type=validate_data['user_type']
        )

        user.set_password(validate_data['password'])
        user.save()

        return user