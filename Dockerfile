FROM openstax/nodejs:6.9.1

# Install higher level packages
RUN apt-get update -qqy \
  && apt-get -qqy install \
    nginx \
    supervisor

# Install grunt-cli globally
RUN npm install -g grunt-cli

# Create the webview user, group, home directory, and package directory.
RUN addgroup --system webview && adduser --system --group webview --home /code

# Set working directory
WORKDIR /code

# Copy application code into the image
COPY . .

# Execute the following commands as specified user / bower doesn't like being executed as root
USER webview

# Setup the webview application
RUN script/setup

# Expose default port
EXPOSE 8000

USER root

CMD ["supervisord", "-c", "conf/supervisord.dev.conf"]
