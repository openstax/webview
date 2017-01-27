(function () {
  'use strict';

  // conceptCoach enabled config needs to check for version before setting paths.
  function makeCoachEnabledConfig (settings, _, $) {
    var promise = $.Deferred( function () {
      return $.get(settings.conceptCoach.revUrl)
        .then(handleCoachVersion)
        .always(handleCoachConfiguration);
    });

    // pull version string for coach out of revUrl's response
    function handleCoachVersion (versions) {
      var apps = versions.split('\n');
      var coachName = 'coach-js';

      var coachVersionSuffix = '';
      _.forEach(apps, function (app) {
        if (app.match(coachName)) {
          coachVersionSuffix = '-' + app.replace('openstax/tutor-js (' + coachName + ') @ ', '');
        }
      });

      return coachVersionSuffix;
    }

    function handleCoachConfiguration (coachVersionSuffix) {
      // fallback to non-suffixed version if version checking fails.
      if ( !_.isString(coachVersionSuffix) ) {
        coachVersionSuffix = '';
      }
      var config = {
        paths: {
          OpenStaxConceptCoach: settings.conceptCoach.assetsUrl + '/concept-coach' + coachVersionSuffix + '.min'
        },
        shim: {
          OpenStaxConceptCoach: {
            deps: ['css!' + settings.conceptCoach.assetsUrl + '/concept-coach-styles' + coachVersionSuffix + '.min'],
            exports: 'OpenStaxConceptCoach'
          }
        }
      };
      promise.resolve(config);
    }

    return promise;
  }


  define(function () {
    return function (settings, _, $) {

      var features = {
        conceptCoach: {
          enable: makeCoachEnabledConfig(settings, _, $)
        }
      };

      function handleOptions (options) {
        if (_.isFunction(options)) {
          return options;
        } else if (_.isObject(options)) {
          return _.clone(options) || {};
        }
      }

      function configureForFeatures (features) {
        var featureConfigs = _.map(features, function (featureOptions, feature) {
          if (_.contains(settings.features, feature)) {
            return handleOptions(featureOptions.enable);
          } else {
            return handleOptions(featureOptions.disable);
          }
        });

        $.when.apply($, featureConfigs).done(function(){
          var featureConfig = _.deepExtend.apply(_, arguments);
          require.config(featureConfig);
        });
      }

      configureForFeatures(features);
    };
  });

})();
