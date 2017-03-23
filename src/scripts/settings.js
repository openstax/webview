(function () {
  'use strict';

  define(function (require) {
    var makeSettings = require('settings/base');

    // The follow properties have been defined with default values in "settings/base":
    //  root, features, titleSuffix, analyticsID, languages, webmaster,
    //  support, terpUrl, shortcodes, defaultLicense, conceptCoach
    // Any new values here will override those default values.

    return makeSettings({
      features: ['conceptCoach'],

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

      // Legacy URL
      // URLs are concatenated using the following logic: location.protocol + '//' + legacy + '/' + view.url
      //   Example: 'http:' + '//' + 'cnx.org' + '/' + 'contents'
      // Do not include the protocol or a trailing slash
      legacy: 'legacy.cnx.org',

      // Webmaster E-mail address
      webmaster: 'support@openstax.org',

      accountProfile: 'https://accounts.cnx.org/profile',

      cnxSupport: 'http://openstax.force.com/support?l=en_US&c=Products%3ACNX',

      exerciseUrl: function (itemCode) {
        return 'https://exercises-dev1.openstax.org/api/exercises?q=tag:' + itemCode;
      },

      // When deployed, these will have the same origin.
      conceptCoach: {
        url: '//localhost:3001',
        assetsUrl: '//localhost:3001/assets',
        revUrl: 'https://tutor-qa.openstax.org/rev.txt'
      }

    });

  });

})();
