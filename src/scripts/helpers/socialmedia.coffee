define (require) ->
  $ = require('jquery')
  _ = require('underscore')

  return new class SocialMedia
    locationOriginPolyFillForIe: () ->
      # Polyfill for location.origin since IE doesn't support it
      port = if location.port then ":#{location.port}" else ''
      location.origin = location.origin or "#{location.protocol}//#{location.hostname}#{port}"


    socialMediaInfo: (description,title) ->
      url = window.location.href
      image = location.origin + "/images/logo.png"
      share =
        url: url
        source:'OpenStax CNX'
        via:'cnxorg'
        summary:description
        title: title
        image: image
        # Encode all of the shared values for a URI
      _.each share, (value, key, list) ->
        list[key] = encodeURI(value)
