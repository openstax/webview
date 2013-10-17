define (require) ->
  $ = require('jquery')
  toc = require('cs!collections/toc')
  Node = require('cs!models/content/node')
  require('backbone-associations')

  LICENSES = {
    'by': 'Attribution License CC BY'
    'by-sa': 'Attribution-ShareAlike CC BY-SA'
    'by-nd': 'Attribution-NoDerivs CC BY-ND'
    'by-nc': 'Attribution-NonCommercial CC BY-NC'
    'by-nc-sa': 'Attribution-NonCommercial-ShareAlike CC BY-NC-SA'
    'by-nc-nd': 'Attribution-NonCommercial-NoDerivs CC BY-NC-ND'
  }

  return class Page extends Node
    defaults:
      authors: []

    constructor: () ->
      super(arguments...)
      toc.add(@)

    parse: (response, options) ->
      resonse = super(arguments...)

      # jQuery can not build a jQuery object with <head> or <body> tags,
      # and will instead move all elements in them up one level.
      # Use a regex to extract everything in the body and put it into a div instead.
      $body = $('<div>' + response.content.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>')
      $body.children('.title').eq(0).remove()
      $body.children('.abstract').eq(0).remove()
      response.content = $body.html()

      license = response.license.match(/^http:\/\/creativecommons\.org\/licenses\/(.+)\/(.+)\//)
      if _.isArray(license) and license.length > 1
        license =
          type: "Creative Commons #{LICENSES[license[1]]}"
          version: license[2]
          url: response.license
      else
        license = {type: null, version: null, url: response.license}

      response.license = license

      return response
