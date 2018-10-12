#!/usr/bin/env python3
"""\
This is used to build an environment variable list for use with containers.

"""
import argparse
import os
from urllib.parse import urlparse


ENV_LIST_TEMPLATE = """\
DISABLE_DEV_SHM_USAGE=true
HEADLESS=true
NO_SANDBOX=true
PRINT_PAGE_SOURCE_ON_FAILURE=true
ARCHIVE_BASE_URL=http://{host}:8800
WEBVIEW_BASE_URL=http://{host}:8600
# TODO: The stack doesn't include enough to test these yet...
# LEGACY_BASE_URL=http://legacy-staging.cnx.org
# NEB_ENV=staging
"""


def make_parser():
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument(
        'dest',
        help='destination server is being deployed as a url',
    )
    return parser


def main():
    parser = make_parser()
    args = parser.parse_args()
    host = urlparse(args.dest).netloc.split(':')[0]
    print(ENV_LIST_TEMPLATE.format(host=host))


if __name__ == '__main__':
    main()
