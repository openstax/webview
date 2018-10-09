#!/usr/bin/env python3
"""\
This is used to build an environment variable list for use with containers.
"""
import os
from urllib.parse import urlparse

# e.g. DOCKER_HOST=tcp://192.168.0.1:2375
docker_host = os.getenv('DOCKER_HOST')
if docker_host is None:
    raise RuntimeError(
        'You must supply a value for the DOCKER_HOST '
        'environment variable'
    )
host = urlparse(docker_host).netloc.split(':')[0]


print("""\
DISABLE_DEV_SHM_USAGE=true
HEADLESS=true
NO_SANDBOX=true
PRINT_PAGE_SOURCE_ON_FAILURE=true
ARCHIVE_BASE_URL=http://{host}:8800
WEBVIEW_BASE_URL=http://{host}:8600
# TODO: The stack doesn't include enough to test these yet...
# LEGACY_BASE_URL=http://legacy-staging.cnx.org
# NEB_ENV=staging
""".format(host=host))
