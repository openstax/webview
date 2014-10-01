define (require) ->
  $ = require('jquery')
  _ = require('underscore')

  return new class SocialMedia
    locationOriginPolyFillForIe: () ->
      # Polyfill for location.origin since IE doesn't support it
      port = if location.port then ":#{location.port}" else ''
      location.origin = location.origin or "#{location.protocol}//#{location.hostname}#{port}"


    socialMediaInfo: () ->
      share =
        url: window.location.href
        source:'OpenStax CNX'
        via:'cnxorg'
        summary:$('.summary').text() or 'An OpenStax College book.'
        title: document.title
        image: location.origin + "/images/logo.png"
        # App ids ARE required for Facebook.
        appId: 940451435969487
        # Encode all of the shared values for a URI
      _.each share, (value, key, list) ->
        list[key] = encodeURI(value)
