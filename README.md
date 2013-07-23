# Connexions

## Development and Building

Below are instructions for optimizing the site and a layout of how the code is organized.

### Building Yourself

1. Download and extract (if necessary)
2. Configure your server to point at `site/index.html` (development) or `dist/index.html` (production)
3. (optional) Build your own production code by running `r.js -o build/build.js` (requires [Node.js](http://nodejs.org) and [r.js](http://requirejs.org/docs/optimization.html)


### Directory Layout

* `build/`                      Build tools and scripts
* `dist/`                       Production version of the site
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