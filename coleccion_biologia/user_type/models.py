from django.db import models
import uuid

class UserType(models.Model):
    '''User Type Model'''

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    description = models.CharField(max_length = 50, unique = True)

    REQUIRED_FIELDS = ['description']

    def __str__(self):
        '''User Type to String'''

        return self.description




