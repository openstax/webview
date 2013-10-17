# Representation of individual nodes in a book's tree (table of contents).
# A Node can represent both a tree (subcollection), or leaf (page).
# Page Nodes also are used to cache a page's content once loaded.

define (require) ->
  Backbone = require('backbone')
  settings = require('cs!settings')
  require('backbone-associations')

  CONTENT_URI = "#{location.protocol}//#{settings.cnxarchive.host}:#{settings.cnxarchive.port}/contents"

  LICENSES = {
    'by': 'Attribution License CC BY'
    'by-sa': 'Attribution-ShareAlike CC BY-SA'
    'by-nd': 'Attribution-NoDerivs CC BY-ND'
    'by-nc': 'Attribution-NonCommercial CC BY-NC'
    'by-nc-sa': 'Attribution-NonCommercial-ShareAlike CC BY-NC-SA'
    'by-nc-nd': 'Attribution-NonCommercial-NoDerivs CC BY-NC-ND'
  }

  return class Node extends Backbone.AssociatedModel
    url: () -> "#{CONTENT_URI}/#{@id}"

    parse: (response, options) ->
      # Don't overwrite the title from the book's table of contents
      if @get('title') then delete response.title

      # Determine the license name, version, and url
      license = response.license.match(/^http:\/\/creativecommons\.org\/licenses\/(.+)\/(.+)\//)
      if _.isArray(license) and license.length > 1
        license =
          name: "Creative Commons #{LICENSES[license[1]]}"
          version: license[2]
          url: response.license
      else
        license = {name: null, version: null, url: response.license}

      response.license = license

      # Add languageName property to nodes for faster references in views
      response.languageName = settings.languages[response.language]

      return response
