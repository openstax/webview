# Connexions [![Build Status](https://travis-ci.org/Connexions/webview.png)](https://travis-ci.org/Connexions/webview)

## Development and Building

Below are instructions for hosting and building the site and a layout of how the code is organized.

### Installing & Hosting

#### Installing

1. If necessary, install [Node.js](http://nodejs.org) and npm (included with Node.js).
2. Run `npm install -g grunt-cli` in the command line to install [grunt-cli](https://github.com/gruntjs/grunt-cli).
3. From the root `webview` directory, run `npm install` in the command line to install test and build dependencies.

##### Testing

From the root `webview` directory, run `npm test`.

##### Building

From the root `webview` directory, run `grunt dist`.

The `dist` directory containing the built site will be added to the root `webview` directory.

#### Hosting

Configure your server to point at `dist/index.html` (or `src/index.html` for development)
  * Unresolveable URIs should load `dist/index.html` or `src/index.html`
  * If not hosting the site from the domain root, update `root` in `src/scripts/config.js` (line 8)
  * `scripts`, `styles`, and `images` routes should be rewritten to the correct paths
  * Example nginx development config:
  ```
    server {
        listen       8080;
        server_name $hostname;
        root /path/to/webview/src/;
        index index.html;
        try_files $uri $uri/ /index.html;

        location ~ ^.*/(data|scripts|styles|images)/(.*) {
            try_files $uri $uri/ /$1/$2 /test/$1/$2;
        }

        location ~ ^.*/test/(.*)/(.*) {
            try_files $uri $uri/ /test/$1 /test/$2 /test/index.html;
        }

        location ~ ^.*/test/(.*) {
            try_files $uri $uri/ /test/$1 /test/index.html;
        }
    }
  ```

### Directory Layout

* `dist/`                      Production version of the site *(added after install)*
* `node_modules/`              Node Modules *(added after install)*
* `src/`                       Development version of the site
* `src/data/`                  Hardcoded data
* `src/images/`                Images used throughout the site
* `src/scripts/`               Site scripts and 3rd party libraries
* `src/scripts/collections`    Backbone Collections
* `src/scripts/helpers`        Helpers for Handlebars, Backbone, and generic code
* `src/scripts/libs`           3rd Party Libraries *(added after install)*
* `src/scripts/models`         Backbone Models
* `src/scripts/modules`        Self-contained, Reusable Modules used to construct pages
* `src/scripts/pages`          Backbone Views representing an entire page (or the entire viewport)
* `src/scripts/config.js`      Require.js configuration
* `src/scripts/loader.coffee`  App loader, responsible for setting up global listeners
* `src/scripts/main.js`        Initial script called by Requirejs
* `src/scripts/router.coffee`  Backbone Router
* `src/scripts/session.coffee` Session state singleton (Backbone Model)
* `src/styles/`                App-specific LESS variables and mixins
* `src/test/`                  Test site
* `src/index.html`             App's HTML Page
* `tests/`                     Unit tests

License
-------

This software is subject to the provisions of the GNU Affero General Public License Version 3.0 (AGPL). See license.txt for details. Copyright (c) 2013 Rice University.