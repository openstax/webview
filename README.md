# Connexions [![Build Status](https://travis-ci.org/Connexions/webview.svg?branch=master)](https://travis-ci.org/Connexions/webview) [![dependency Status](https://david-dm.org/Connexions/webview.svg)](https://david-dm.org/Connexions/webview#info=dependencies) [![devDependency Status](https://david-dm.org/Connexions/webview/dev-status.svg)](https://david-dm.org/Connexions/webview#info=devDependencies)

Below are instructions for hosting and building the site and a layout of how the code is organized.

CNX webview is designed to be run as a frontend for [cnx-archive](https://github.com/Connexions/cnx-archive).

# Installing

1. If necessary, install [Node.js](http://nodejs.org) and npm (included with Node.js).
1. Run `npm install --global n` to install the [node version manager](npmjs.com/package/n)
2. Run `./script/bootstrap` in the command line to install all the package dependencies.
  * **Note:** `npm install` runs `bower install` and `grunt install`, both of which can also be run independently
    * `bower install` downloads front-end dependencies
    * `grunt install` compiles the Aloha-Editor (which is downloaded by bower)

By default, webview will use [cnx-archive](https://github.com/Connexions/cnx-archive) and [cnx-authoring](https://github.com/Connexions/cnx-authoring) hosted on cnx.org.


# Building

From the root `webview` directory, run `./script/setup`.

The `dist` directory containing the built site will be added to the root `webview` directory.

# Testing

From the root `webview` directory, run `./script/test` (which runs `npm test`).
npm test failures are not as informative as they could be.
If `coffeelint` fails, you can run it with `grunt coffeelint` to get more information

# Updating

From the root `webview` directory, run `./script/update`, which executes the following commands:
1. `npm update`
2. `bower update`
3. `grunt aloha --verbose`

# Hosting

### Quick Development Setup

1. Install [nginx](http://nginx.org/)
2. Run `./script/start` (uses `nginx.development.conf`)
3. (optional) Install https://github.com/prerender/prerender
4. Point your browser to [http://localhost:8000](http://localhost:8000)
5. Run `./script/stop` to stop nginx

### Customization Notes

1. Update settings in `src/scripts/settings.js` if necessary to, for example, include
the correct Google Analytics ID, and to point to wherever `cnxarchive` is being hosted.

2. Ensure resources are being served with the correct MIME type, including fonts.
  * Example nginx MIME types that may need to be added:

  ```nginx
    types {
        image/svg+xml           svg svgz;
        font/truetype           ttf;
        font/opentype           otf;
        application/font-woff   woff;
    }
  ```

3. Configure your server to point at `dist/index.html` (or `src/index.html` for development)
  * Unresolveable URIs should load `dist/index.html` or `src/index.html`
  * If not hosting the site from the domain root, update `root` in `src/scripts/settings.js`
  * `scripts`, `styles`, and `images` routes should be rewritten to the correct paths

<details>
<summary>Example nginx config</summary>

```
server {
    listen 8000; # dev
    listen [::]:8000; # dev ipv6
    listen 8001; # production
    listen [::]:8001; # production ipv6
    server_name  _;

    # Support both production and dev
    set $ROOT "src";
    if ($server_port ~ "8001") {
        set $ROOT "dist";
    }

    root /path/to/webview/$ROOT/;

    index index.html;
    try_files $uri @prerender;

    # Proxy resources and exports to cnx.org
    # since they are not part of the locally hosted package
    location /resources/ {
        proxy_pass http://cnx.org;
    }
    location /exports/ {
        proxy_pass http://cnx.org;
    }

    # For development only
    location ~ ^.*/bower_components/(.*)$ {
        alias /path/to/webview/bower_components/$1;
    }

    location ~ ^.*/(data|scripts|styles|images|fonts)/(.*) {
        try_files $uri /$1/$2;
    }

    # Prerender for SEO
    location @prerender {
        # Support page prerendering for web crawlers
        set $prerender 0;
        if ($http_user_agent ~* "baiduspider|twitterbot|facebookexternalhit|rogerbot|linkedinbot|embedly|quora link preview|showyoubot|outbrain|pinterest") {
            set $prerender 1;
        }
        if ($args ~ "_escaped_fragment_") {
            set $prerender 1;
        }
        if ($http_user_agent ~ "Prerender") {
            set $prerender 0;
        }
        if ($uri ~ "\.(js|css|xml|less|png|jpg|jpeg|gif|pdf|doc|txt|ico|rss|zip|mp3|rar|exe|wmv|doc|avi|ppt|mpg|mpeg|tif|wav|mov|psd|ai|xls|mp4|m4a|swf|dat|dmg|iso|flv|m4v|torrent)") {
            set $prerender 0;
        }
        if ($prerender = 1) {
            rewrite .* /$scheme://$http_host$request_uri? break;
            proxy_pass http://localhost:3000;
        }
        if ($prerender = 0) {
            rewrite .* /index.html break;
        }
    }
}
```

</details>


# Directory Layout

* `bower_components/`           3rd Party Libraries *(added after install)*
* `node_modules/`               Node Modules *(added after install)*
* `dist/`                       Production version of the site *(added after build)*
* `src/`                        Development version of the site
* `src/data/`                   Hardcoded data
* `src/images/`                 Images used throughout the site
* `src/scripts/`                Site scripts and 3rd party libraries
* `src/scripts/collections`     Backbone Collections
* `src/scripts/helpers`         Helpers for Handlebars, Backbone, and generic code
* `src/scripts/models`          Backbone Models
* `src/scripts/modules`         Self-contained, reusable Modules used to construct pages
* `src/scripts/pages`           Backbone Views representing an entire page (or the entire viewport)
* `src/scripts/config.js`       Require.js configuration
* `src/scripts/loader.coffee`   App loader, responsible for setting up global listeners
* `src/scripts/main.js`         Initial script called by Requirejs
* `src/scripts/router.coffee`   Backbone Router
* `src/scripts/session.coffee`  Session state singleton (Backbone Model)
* `src/scripts/settings.js`     Global application config settings (remains in place after build)
* `src/styles/`                 App-specific LESS variables and mixins
* `src/index.html`              App's HTML Page
* `test/`                       Unit tests


# License

This software is subject to the provisions of the GNU Affero General Public License Version 3.0 (AGPL). See license.txt for details. Copyright (c) 2013 Rice University.
