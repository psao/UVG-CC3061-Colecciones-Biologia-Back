import json
from django.shortcuts import render
from django.db.models import Q
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from django.contrib.postgres.search import SearchVector

from . import models
from . import serializers
from permissions.services import APIPermissionClassFactory
from country.models import Country
from country.serializers import CountrySerializer
from departamento.models import Departamento
from departamento.serializers import DepartamentoSerializer
from municipio.models import Municipio
from municipio.serializers import MunicipioSerializer
from organism_conservation.models import OrganismConservation
from organism_conservation.serializers import OrganismConservationSerializer

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
                    'search_suggestions_results': True,
                    'search_results': True
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

    @action(detail=False, methods=['post'])
    def search_suggestions_results(self, request):
        '''Search based on predictive text'''

        search = json.loads(request.body)['search']

        searchResults = []

        results = models.Organism.objects.filter(Q(common_name__icontains = search) | Q(scientific_name__icontains = search))[:5]

        for result in results:
            #Serialize evrey result
            organism_serializer = serializers.OrganismSerializer(result).data
            organism = { "common_name": organism_serializer['common_name'], "scientific_name": organism_serializer['scientific_name'] }
            # organism = organism_serializer['common_name']
            searchResults.append(organism)

        return Response(searchResults)
    
    @action(detail=False, methods=['post'])
    def search_results(self, request):
        '''Search based on predictive text'''

        search = json.loads(request.body)['search']

        searchResults = []

        results = models.Organism.objects.filter(Q(common_name__icontains = search) | Q(scientific_name__icontains = search))

        for result in results:
            #Serialize evrey result
            
            organism_serializer = serializers.OrganismSerializer(result).data

            country = Country.objects.get(pk=organism_serializer['country'])
            country_serializer = CountrySerializer(country).data
            organism_serializer['country'] = country_serializer

            departamento = Departamento.objects.get(pk=organism_serializer['departamento'])
            departamento_serializer = DepartamentoSerializer(departamento).data
            organism_serializer['departamento'] = departamento_serializer

            municipio = Municipio.objects.get(pk=organism_serializer['municipio'])
            municipio_serializer = MunicipioSerializer(municipio).data
            organism_serializer['municipio'] = municipio_serializer

            organism_conservation = OrganismConservation.objects.get(pk=organism_serializer['organism_conservation'])
            organism_conservation_serializer = OrganismConservationSerializer(organism_conservation).data
            organism_serializer['organism_conservation'] = organism_conservation_serializer

            # organism = organism_serializer['common_name']
            searchResults.append(organism_serializer)

        return Response(searchResults)