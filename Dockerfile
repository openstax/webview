FROM openstax/nodejs:6.9.1 as builder

# Install higher level packages
RUN apt-get update -qqy \
  && apt-get -qqy install \
    nginx \
    supervisor

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

# Setup the webview application
RUN script/setup

CMD ["supervisord", "-c", "conf/supervisord.dev.conf"]
