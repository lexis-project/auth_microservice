"""
Delete all expired tokens

python -m auth_microservice.manage runscript delete_expired
"""

from token_service import models
import datetime
import logging

logger = logging.getLogger(__name__)


def run():
    # Remove expired tokens
    expired_tokens = models.Token.objects.filter(expires__lte=datetime.datetime.now()):
    logger.info("Deleting {0} expired tokens.".format(len(expired_tokens)))
    for token in expired_tokens:
        token.delete()
