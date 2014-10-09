define (require) ->
  $ = require('jquery')
  _ = require('underscore')

  return new class SocialMedia
    url = window.location.href
    description = $('.summary').text() or 'An OpenStax College book.'
    title = document.title
    image = location.origin + "/images/logo.png"

    locationOriginPolyFillForIe: () ->
      # Polyfill for location.origin since IE doesn't support it
      port = if location.port then ":#{location.port}" else ''
      location.origin = location.origin or "#{location.protocol}//#{location.hostname}#{port}"


    socialMediaInfo: () ->
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

    addOpenGraphMetaTags: () ->
      head = $('head')
      $('meta[property="og:url"]').remove();
      head.append( '<meta name="og:url" content="'+url+'">' );
      $('meta[property="og:title"]').remove();
      head.append( '<meta name="og:title" content="'+title+'">' );
      $('meta[property="og:description"]').remove();
      head.append( '<meta name="og:description" content="'+description+'">' );
      $('meta[property="og:image"]').remove();
      head.append( '<meta name="og:image" content="'+image+'">' );
