(function () {
  'use strict';

  define(function (require) {
    var languages = require('cs!configs/languages');

    return {
      // Directory from which webview is served
      root: '/',

      // Hostname and port for the cnx-archive server
      cnxarchive: {
        host: 'archive.cnx.org',
        port: 80
      },

      // Hostname and port for the cnx-authoring server
      cnxauthoring: {
        host: location.hostname,
        port: 8080
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
        'college_physics': '031da8d3-b525-429c-80cf-6c8ed997733a@8.1',
        'college_introduction_to_sociology': 'afe4332a-c97f-4fc4-be27-4e4d384a32d8@7.15',
        'biology': '185cbf87-c72e-48f5-b51e-f14f21b5eabd@9.44',
        'concepts_of_biology': 'b3c1e1d2-839c-42b0-a314-e119a8aafbdd@8.39',
        'anatomy_and_physiology': '14fb4ad7-39a1-4eee-ab6e-3ef2482e3e22@6.19',
        'introductory_statistics': '30189442-6998-4686-ac05-ed152b91b9de@17.20',
      }
    };

  });

})();
