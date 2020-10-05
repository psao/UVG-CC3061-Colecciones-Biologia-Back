from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response

from . import models
from . import serializers
from permissions.services import APIPermissionClassFactory

class MunicipioViewSet(viewsets.ModelViewSet):
    '''Handles creating, reading and updating Municipios'''

    queryset = models.Municipio.objects.all()
    serializer_class = serializers.MunicipioSerializer
    permission_classes = [
        APIPermissionClassFactory(
            name='MunicipioPermissions',
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