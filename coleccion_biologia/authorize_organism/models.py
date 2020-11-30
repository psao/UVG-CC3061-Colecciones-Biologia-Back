import uuid
from django.db import models

from users.models import Users
from organism.models import Organism

class AuthorizeOrganism(models.Model):
    '''Authorize Organism Model'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    authorizing_user = models.ForeignKey(Users, on_delete=models.PROTECT, null=False)
    organism = models.ForeignKey(Organism, on_delete=models.PROTECT, null=False)
    authorization_date = models.DateTimeField(auto_now_add=True)

    REQUIRED_FIELDS = ['authorizing_user', 'organism']