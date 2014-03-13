(function () {
  'use strict';

  define(function (require) {
    var languages = require('cs!configs/languages');

    return {
      // Directory from which webview is served
      root: '/',

      // Hostname and port for the cnxarchive server
      cnxarchive: {
        host: location.hostname,
        port: 6543
      },

      // Prefix to prepend to page titles
      titlePrefix: 'OpenStax CNX - ',

      // Google Analytics tracking ID
      analyticsID: 'UA-7903479-1',

      // Supported languages
      languages: languages,

      // Legacy URL
      // URLs are concatenated using the following logic: location.protocol + '//' + legacy + '/' + view.url
      //   Example: 'http:' + '//' + 'cnx.org' + '/' + 'contents'
      // Do not include the protocol or a trailing slash
      legacy: 'cnx.org',

      // Webmaster E-mail address
      webmaster: 'cnx@cnx.org',

      // Content shortcodes
      shortcodes: {
        'college_physics': 'e4c0f2e3-82f0-4701-a485-c1b9b362a49f@7.1',
        'college_introduction_to_sociology': '451881d9-86f9-458b-83a3-a29de227a6f7@7.1',
        'biology': '6ba2ac5d-d53d-4df5-ae2f-9362add7a01a@9.1',
        'concepts_of_biology': '4779de9d-4524-49cb-88a3-3ad9e062fcb2@8.1',
        'anatomy_and_physiology': 'a7103b93-c07b-419d-8b74-3f429af4c378@6.1',
        'introductory_statistics': '5886a723-20a7-4410-b204-d70161feb416@6.1',
      }
    };

  });

})();
