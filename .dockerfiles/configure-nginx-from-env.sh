#!/usr/bin/env bash

# Set defaults
ENVIRONMENT=${ENVIRONMENT:-dev}
ARCHIVE_HOST=${ARCHIVE_HOST:-archive.cnx.org}
ARCHIVE_PORT=${ARCHIVE_PORT:-80}
OPENSTAX_HOST=${OPENSTAX_HOST:-openstax.org}
OPENSTAX_PORT=${OPENSTAX_PORT:-443}
EXERCISES_HOST=${EXERCISES_HOST:-exercises.openstax.org}
EXERCISES_PORT=${EXERCISES_PORT:-443}
LEGACY_HOST=${LEGACY_HOST:-legacy.cnx.org}

case "${ARCHIVE_PORT}" in
    443) ARCHIVE_PROTOCOL='https' ;;
    *) ARCHIVE_PROTOCOL='http' ;;
esac

ROOT=${1:-/code/dist}

# Define environment specific configuration
case "${ENVIRONMENT}" in
    'dev')
        DEV_CONFIG=$(echo """
  location ~ ^.*/bower_components/(.*)$ {
      alias ${ROOT}/../bower_components/\$1;
  }

  location ~ ^.*/data/(.*) {
      alias ${ROOT}/test/data/\$1;
  }""")
        ;;
    *)
        DEV_CONFIG=""
        ;;
esac

# Output the nginx config to stdout
echo """\
server {
  listen 80;
  root ${ROOT};
  index index.html;
  try_files \$uri /index.html;

  # Try to fetch resources from archive (most common)
  location ~ ^/resources/.+ {
      proxy_pass ${ARCHIVE_PROTOCOL}://${ARCHIVE_HOST}:${ARCHIVE_PORT};
  }
${DEV_CONFIG}

  location ~ ^.*/(scripts|styles|images)/(.*) {
      try_files \$uri \$uri/ /\$1/\$2;
  }

  types {
      text/html               html htm shtml;
      text/css                css;
      image/svg+xml           svg svgz;
      font/truetype           ttf;
      font/opentype           otf;
      application/font-woff   woff;
  }
}
"""
