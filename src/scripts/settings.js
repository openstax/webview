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
        host: 'cnx.org',
        port: 80
      },

      // Prefix to prepend to page titles
      titleSuffix: ' - OpenStax CNX',

      // Google Analytics tracking ID
      analyticsID: 'UA-7903479-1',

      // Supported languages
      languages: languages,

      // Legacy URL
      // URLs are concatenated using the following logic: location.protocol + '//' + legacy + '/' + view.url
      //   Example: 'http:' + '//' + 'cnx.org' + '/' + 'contents'
      // Do not include the protocol or a trailing slash
      legacy: 'legacy.cnx.org',

      // Webmaster E-mail address
      webmaster: 'support@openstax.org',

      // Content shortcodes
      shortcodes: {
        'college-physics': '031da8d3-b525-429c-80cf-6c8ed997733a@8.1',
        'college-introduction-to-sociology': 'afe4332a-c97f-4fc4-be27-4e4d384a32d8@7.15',
        'biology': '185cbf87-c72e-48f5-b51e-f14f21b5eabd@9.44',
        'concepts-of-biology': 'b3c1e1d2-839c-42b0-a314-e119a8aafbdd@8.39',
        'anatomy-and-physiology': '14fb4ad7-39a1-4eee-ab6e-3ef2482e3e22@6.19',
        'introductory-statistics': '30189442-6998-4686-ac05-ed152b91b9de@17.20'
      },

      accountProfile: 'https://accounts.cnx.org/profile',

      cnxSupport: 'http://openstax.force.com/support?l=en_US&c=Products%3ACNX',

      terpUrl: function (itemCode) {
        return 'https://openstaxtutor.org/terp/' + itemCode + '/quiz_start';
      },

      exerciseUrl: function (itemCode) {
        // // stub.  Comment out to use local exercises stub.
        // // Copied from https://exercises-dev1.openstax.org/api/exercises?q=tag:k12phys-ch04-s01-lo01
        // return 'http://localhost:8000/data/exercises.json';
        return 'https://exercises-dev1.openstax.org/api/exercises?q=tag:' + itemCode;
      },

      defaultLicense: {
        code: 'by'
      },

      conceptCoach: {
        uuids: {
          'f10533ca-f803-490d-b935-88899941197f': ['art-exercise', 'free-response', 'multiple-choice'],
          '8QUzyvgD': ['art-exercise', 'free-response', 'multiple-choice'] // only long-codes are currently supported
        },
        url: 'https://tutor-qa.openstax.org'
      }

    };

  });

})();
