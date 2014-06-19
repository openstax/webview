# Copyright (c) 2013 Rice University
#
# This software is subject to the provisions of the GNU AFFERO GENERAL PUBLIC LICENSE Version 3.0 (AGPL).
# See LICENSE.txt for details.

# # Configure Aloha
# This module configures Aloha and runs before Aloha loads.
#
# Aloha is configured by a global `Aloha` object.
# This module creates it and when Aloha finishes loading its shim removes the global
define ['jquery'], ($) ->

  # Hack for newer versions of jquery
  $.browser = {}
  $.browser.msie = false
  $.fn.live = $.fn.on # (events, data, handler) -> @on(events, data, handler)

  @Aloha = @Aloha or {}
  @Aloha.settings =
    jQuery: $ # Use the same version of jQuery

    # Disable global error handling and let the exception go all the way back to the browser
    errorhandling: false
    logLevels:
      error: true
      warn: false
      info: false
      debug: false

    sidebar: {disabled:true}

    requireConfig:
      paths:
        # Override location of jquery-ui and use our own. Because
        # jquery-ui and bootstrap conflict in a few cases (buttons,
        # tooltip) our copy has those removed.
        jqueryui: '../../oerpub/js/jquery-ui-1.9.0.custom-aloha'

      map:
        '*':
          'ui/ui': 'toolbar/toolbar-plugin'

      waitSeconds: 42

    bundles:
      ghbook: '../../../../scripts/aloha'

    plugins:
      # All the plugins we use in Aloha
      load: [
        'oer/toolbar'
        'common/dom-to-xhtml'
        'common/ui'
        'common/format'
        'common/block'
        'common/list'
        'common/contenthandler'
        'oer/paste'
        'oer/table'
        'extra/draganddropfiles'
        'oer/image'
        'oer/figure'
        'oer/overlay'
        'oer/math'
        'oer/assorted'
        #'ghbook/image'
        # 'common/image' # Need to monkeypatch jQuery.live
        'oer/semanticblock'
        'oer/note'
        'oer/example'
        'oer/exercise'
        'oer/quotation'
        'oer/equation'
        'oer/definition'
        'oer/multipart'
        'oer/copy'
        'oer/cleanup'
      ]


      assorted:
        image:
          # Do not send the image in the POST body (use uploadfield instead)
          uploadSinglepart: false
          # Use the body of the response as the URL
          parseresponse: (xhr) ->

            setTimeout(window.GLOBAL_UPLOADER_HACK, 100)

            if xhr.status >= 200 and xhr.status < 300 or xhr.status is 304 or xhr.status is 302
              return {status:xhr.status, url:xhr.response}

            return {status:xhr.status}

          # Send files using the `file` field when POSTing
          uploadfield: 'file'
          uploadurl: "#{location.origin}/resources"


      # This whole thing is what's needed to:
      #
      # - set a custom URL to send files to
      # - register a callback that updates the IMG with the new src
      draganddropfiles:
        upload:
          config:
            method: 'POST'
            url: '/resource'
            fieldName: 'upload'
            send_multipart_form: true
            callback: (resp) ->
              # **TODO:** add xhr to Aloha.trigger('aloha-upload-*') in dropfilesrepository.js

              # dropfilesrepository.js triggers 'aloha-upload-success'
              # and 'aloha-upload-failure' but does not provide the
              # response text (URL).
              # We should probably change dropfilesrepository.js to be:
              #
              #     Aloha.trigger('aloha-upload-success', that, xhr);

              # Then, instead of configuring a callback we could just listen to that event.

              # If the response is a URL then change the Image source to it
              # The URL could be absolute (`/^http/`) or relative (`/\//` or `[a-z]`).
              unless resp.match(/^http/) or resp.match(/^\//) or resp.match(/^[a-z]/)
                alert 'You dropped a file and we sent a message to the server to do something with it.'
                resp = 'src/test/AlohaEditorLogo.png'

              # Drag and Drop creates an <img id='{this.id}'> element but the
              #
              # - 'New Image' plugin doesn't have access to the UploadFile object (this)
              #   so all it can do is add a class.
              # - If I combine both then we can set the attribute consistently.
              # - **FIXME:** Don't assume only 1 image can be uploaded at a time

              $img = Aloha.jQuery('.aloha-image-uploading').add('#' + @id)
              $img.attr 'src', resp
              $img.removeClass 'aloha-image-uploading'
              console.log 'Updated Image src as a result of upload'

      semanticblock:
        # Handle dragging semantic blocks directly in webview
        semanticDragSelector: '#INVALID-SELECTOR'

      note: [
        { label: 'Note',      typeClass: 'note', hasTitle: true }
        { label: 'Aside',     typeClass: 'note', hasTitle: true, dataClass: 'aside' }
        { label: 'Warning',   typeClass: 'note', hasTitle: true, dataClass: 'warning' }
        { label: 'Tip',       typeClass: 'note', hasTitle: true, dataClass: 'tip' }
        { label: 'Important', typeClass: 'note', hasTitle: true, dataClass: 'important' }
        { label: "Teacher's Guide", typeClass: 'note', hasTitle: true, dataClass: 'teachers-guide' }
      ]
      block:
        dragdrop: "1"
        rootTags: ['span', 'div', 'figure']
        defaults:
          '.default-block': {}
      image:
        handles: 'se'
      # copy:
      #   path: () ->
      #     # The path of the current document can be determined from the hash
      #     decodeURI RegExp('^#repo/[^/]*/[^/]*(/branch/[^/]*)?/edit(/[^|]*)').exec(window.location.hash)[2]

    smartContentChange:
      idle: 2000

    contentHandler:
      insertHtml: [ 'cleanup' ]
      initEditable: []
      getContents: []

  # In case some module wants the config object return it.
  return @Aloha
