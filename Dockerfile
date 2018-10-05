FROM openstax/nodejs:6.9.1 as base-system

# Install grunt-cli globally
RUN npm install -g grunt-cli

# Create the webview user, group, home directory, and package directory.
# Note, the packaging tools don't like to run as root.
RUN addgroup --system webview && adduser --system --group webview --home /code

USER webview
WORKDIR /code

# Copy application code into the image
COPY . .
# Remove the local copy of the build distribution directory if it exists
RUN rm -rf dist


FROM base-system as built

# Setup the webview application
RUN script/setup
RUN script/build


FROM nginx:latest as serve

# Specify the type of container runtime: 'dev' OR 'prod'
#  - 'dev' will specify that the container should run the source
#  - 'prod' will run as close to production as possible
ARG environment=prod
ENV ENVIRONMENT=${environment}

COPY --from=built /code /code
COPY .dockerfiles/configure-nginx-from-env.sh /usr/local/bin/
COPY .dockerfiles/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
