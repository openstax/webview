# Connexions [![Build Status](https://travis-ci.org/Connexions/webview.png)](https://travis-ci.org/Connexions/webview)

## Development and Building

Below are instructions for optimizing the site and a layout of how the code is organized.

### Hosting Yourself

1. Download and extract
2. Install [Node.js](http://nodejs.org) (and npm)
3. Run `npm install -g grunt-cli` to install [grunt-cli](https://github.com/gruntjs/grunt-cli)
4. Run `npm install` to install test and build dependencies
5. (optional) Run tests with `npm test`
6. Build the production code with `grunt dist` or `npm run-script dist`
7. Configure your server to point at `dist/index.html`
  * Note: You can also host the development version at `site/index.html` (no build required)
  * Note: Unresolveable URIs should also load `dist/index.html` or `site/index.html`

#### Download production version

An optimized version of the site not requiring any build tools is
maintained in the `gh-pages` [branch](https://github.com/Connexions/webview/tree/gh-pages).
It can also be previewed at http://connexions.github.io/webview/.

### Directory Layout

* `site/`                       Development version of the site
* `site/data/`                  Hardcoded data
* `site/images/`                Images used throughout the site
* `site/scripts/`               Site scripts and 3rd party libraries
* `site/scripts/collections`    Backbone Collections
* `site/scripts/helpers`        Helpers for Handlebars, Backbone, and generic code
* `site/scripts/libs`           3rd Party Libraries
* `site/scripts/models`         Backbone Models
* `site/scripts/modules`        Self-contained, Reusable Modules used to construct pages
* `site/scripts/pages`          Backbone Views representing an entire page (or the entire viewport)
* `site/scripts/config.js`      Require.js configuration
* `site/scripts/loader.coffee`  App loader, responsible for setting up global listeners
* `site/scripts/main.js`        Initial script called by Requirejs
* `site/scripts/router.coffee`  Backbone Router
* `site/scripts/session.coffee` Session state singleton (Backbone Model)
* `site/styles/`                App-specific LESS variables and mixins
* `index.html`                  App's HTML Page

License
-------

This software is subject to the provisions of the GNU Affero General Public License Version 3.0 (AGPL). See license.txt for details. Copyright (c) 2013 Rice University.