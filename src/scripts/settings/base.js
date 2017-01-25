(function () {
  'use strict';

  define(function (require) {
    var _ = require('cs!helpers/underscore.deepExtend');

    var languages = require('cs!configs/languages');
    var base = {
      // Directory from which webview is served
      root: '/',

      features: ['conceptCoach'],

      // Prefix to prepend to page titles
      titleSuffix: ' - OpenStax CNX',

      // Google Analytics tracking ID
      analyticsID: 'UA-7903479-1',

      // Supported languages
      languages: languages,

      // Webmaster E-mail address
      webmaster: 'cnx@cnx.org',

      terpUrl: function (itemCode) {
        return 'https://openstaxtutor.org/terp/' + itemCode + '/quiz_start';
      },

      defaultLicense: {
        code: 'by'
      },

      conceptCoach: {
        uuids: {
          'f10533ca-f803-490d-b935-88899941197f': ['art-exercise', 'free-response', 'multiple-choice'],
          '8QUzyvgD': ['art-exercise', 'free-response', 'multiple-choice'], // only long-codes are currently supported
          "meEn-Pci": ["art-exercise", "multiple-choice", "free-response"],
          "4f86c023-a135-412a-9d96-dcbd1ca61e7d": ["section-quiz", "short-answer", "further-research"],
          "d393e255-30b3-4ba7-bc78-2fd7a4324ec8": ["section-quiz", "short-answer", "further-research"],
          "947a1417-5fd5-4b3c-ac8f-bd9d1aedf2d2": ["self-check-questions", "review-questions", "critical-thinking", "problems"],
          "05PiVTCz": ["section-quiz", "short-answer", "further-research"],
          "d2fbadca-e4f3-4432-a074-2438c216b62a": ["self-check-questions", "review-questions", "critical-thinking", "problems"],
          "27275f49-f212-4506-b3b1-a4d5e3598b99": ["conceptual-questions", "problems-exercises"],
          "08df2bee-3db4-4243-bd76-ee032da173e8": ["self-check-questions", "review-questions", "critical-thinking", "problems"],
          "v5a_xecj": ["art-exercise", "multiple-choice", "free-response"],
          "CN8r7j20": ["self-check-questions", "review-questions", "critical-thinking", "problems"],
          "99e127f8-f722-4907-a6b3-2d62fca135d6": ["art-exercise", "multiple-choice", "free-response", "interactive-exercise"],
          "JydfSfIS": ["conceptual-questions", "problems-exercises"],
          "3402dc53-113d-45f3-954e-8d2ad1e73659": ["art-exercise", "multiple-choice", "free-response"],
          "lHoUF1_V": ["self-check-questions", "review-questions", "critical-thinking", "problems"],
          "T4bAI6E1": ["section-quiz", "short-answer", "further-research"],
          "bf96bfc5-e723-46c2-9fa2-5a4c9294fa26": ["art-exercise", "multiple-choice", "free-response"],
          "0vutyuTz": ["self-check-questions", "review-questions", "critical-thinking", "problems"],
          "NALcUxE9": ["art-exercise", "multiple-choice", "free-response"]
        }
      }
    };

    return function makeSettings(additionalSettings){
      return _.deepExtend({}, base, additionalSettings);
    };

  });

})();
