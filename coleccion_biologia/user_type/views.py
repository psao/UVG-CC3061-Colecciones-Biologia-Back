from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response

from . import models
from . import serializers

from permissions.services import APIPermissionClassFactory

class UserTypeViewSet(viewsets.ModelViewSet):
    '''Handle creating, reading and deleting User Types'''

    queryset = models.UserType.objects.all()
    serializer_class = serializers.UserTypeSerializer
    permission_classes = [
        APIPermissionClassFactory(
            name = 'UserTypePermissions',
            permission_configuration={
                'base': {
                    'create': True,
                    'list': True,
                },
                'instance':{
                    'retrieve': True,
                    'destroy': True,
                    'update': True,
                    'partial_update': True,
                }
            }
        )
    ]