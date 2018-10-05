#!/bin/sh

# Run the setup script
/code/script/setup

# Run the build script only if we are going to build a prod-like image
if [ "${ENVIRONMENT}" = 'prod' ]; then
    /code/script/build;
fi
