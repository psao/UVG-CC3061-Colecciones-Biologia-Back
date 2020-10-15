from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response

from . import models
from . import serializers
from permissions.services import APIPermissionClassFactory

class OrganismViewSet(viewsets.ModelViewSet):
    '''Handles creating, reading and updating Organisms'''

    queryset = models.Organism.objects.all()
    serializer_class = serializers.OrganismSerializer
    permission_classes = [
        APIPermissionClassFactory(
            name='OrganismPermissions',
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