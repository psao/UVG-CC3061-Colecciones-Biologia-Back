import uuid
from django.db import models

class AuthorizeOrganism(models.Model):
    '''Authorize Organism Model'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    