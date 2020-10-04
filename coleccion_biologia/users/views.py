from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response

from . import models
from . import serializers
from permissions.services import APIPermissionClassFactory

class UserViewSet(viewsets.ModelViewSet):
    '''Handles creating, reading and updating user profiles'''

    queryset = models.Users.objects.all()
    serializer_class = serializers.UserSerializer
    permission_classes = [
        APIPermissionClassFactory(
            name='UserPermissions',
            permission_configuration={
                'base': {
                    'create': True,
                    'list': True,
                },
                'instance': {
                    'retrieve': True,
                    'destroy': True,
                    'update': True,
                    'partial_update': True,
                }
            }
        )
    ]