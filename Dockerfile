FROM openstax/nodejs:6.9.1 as builder

# Specify the type of container runtime: 'dev' OR 'prod'
#  - 'dev' will specify that the container should run the source
#  - 'prod' will run as close to production as possible
ARG environment=dev
ENV ENVIRONMENT=${environment}

# Install higher level packages
RUN apt-get update -qqy \
  && apt-get -qqy install nginx supervisor

# Install grunt-cli globally
RUN npm install -g grunt-cli

# Create the webview user, group, home directory, and package directory.
RUN addgroup --system webview && adduser --system --group webview --home /code
RUN chown -R webview:webview /var/log/nginx /var/lib/nginx

USER webview

# Set working directory
WORKDIR /code

# Expose default port
EXPOSE 8000

FROM builder as build

# Copy application code into the image
COPY . .
# Remove the local copy of the build distribution directory if it exists
RUN rm -rf dist

# Setup the webview application
RUN script/setup
RUN script/build

CMD supervisord -c conf/supervisord.$ENVIRONMENT.conf
