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
      titlePrefix: 'Connexions - ',

      // Google Analytics tracking ID
      analyticsID: 'UA-7903479-1',

      // Supported languages
      languages: languages,

      // Legacy URL
      // URLS are concatenated using the following logic: location.protocol + '//' + legacy + '/' + view.url
      //   Example: 'http:' + '//' + 'cnx.org' + '/' + 'contents'
      // Do not include the protocol or a trailing slash
      legacy: 'cnx.org',

      // Webmaster E-mail address
      webmaster: 'cnx@cnx.org',

      // Content shortcodes
      shortcodes: {
        'college_physics': 'e79ffde3-7fb4-4af3-9ec8-df648b391597@7.1',
        'college_introduction_to_sociology': '30a3ada8-41a4-4ab1-ba79-d4e49b044964@7.119',
        'biology': 'aa0c81ca-2246-49c2-93ff-03f31569a740@9.123',
        'concepts_of_biology': '81c53958-672b-4e07-8025-535602180078@8.17',
        'anatomy_and_physiology': '12b7fdb3-23e3-48d1-adf6-7e3c8b73fa21@6.148',
        'introductory_statistics': '30189442-6998-4686-ac05-ed152b91b9de@16.2',
      }
    };

  });

})();
