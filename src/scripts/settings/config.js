(function () {
  'use strict';

  function hasLocalStorage() {
    var item = 'localStoragePolyfill';
    try {
      localStorage.setItem(item, item);
      localStorage.removeItem(item);
      return true;
    } catch (e) {
      return false;
    }
  }

  // conceptCoach enabled config needs to check for version before setting paths.
  function makeCoachEnabledConfig(settings, _, $) {
    var REV_ETAG_STORAGE_KEY = 'cnxCoachRevTag';
    var HAS_LOCAL_STORAGE = hasLocalStorage();

    var promise = $.Deferred(function () {
      return $.ajax(settings.conceptCoach.revUrl, getETagMatchingOptions())
        .then(handleCoachVersion)
        .always(handleCoachConfiguration);
    });

    function getETagMatchingOptions() {
      var options = {};

      if (HAS_LOCAL_STORAGE) {
        var previousRevETag = localStorage.getItem(REV_ETAG_STORAGE_KEY);

        if (previousRevETag) {
          options.headers = {
            'If-None-Match': previousRevETag
          };
        }
      }
      return options;
    }

    function makeCoachKey(eTag) {
      return 'cnxCoachVersion' + eTag;
    }

    function updateCache(jqXHR, coachVersion) {
      if (!HAS_LOCAL_STORAGE) {
        return;
      }

      var eTag = jqXHR.getResponseHeader('ETag');
      var previousETag = localStorage.getItem(REV_ETAG_STORAGE_KEY);
      if (previousETag) {
        var previousCoachKey = makeCoachKey(previousETag);
        var previousCoachVersion = localStorage.getItem(previousCoachKey);
        if (previousCoachVersion && eTag && previousCoachVersion !== coachVersion) {
          localStorage.removeItem(previousETag);
        }
      }

      if (eTag) {
        localStorage.setItem(REV_ETAG_STORAGE_KEY, eTag);
        localStorage.setItem(makeCoachKey(eTag), coachVersion);
      }
    }

    function getCachedCoachVersion() {
      if (!HAS_LOCAL_STORAGE) {
        return;
      }

      var currentETag = localStorage.getItem(REV_ETAG_STORAGE_KEY);
      return localStorage.getItem(makeCoachKey(currentETag));
    }

    // pull version string for coach out of revUrl's response
    function handleCoachVersion(versions, status, jqXHR) {
      var apps = versions.split('\n');
      var coachName = 'coach-js';

      var coachVersionSuffix = '';
      _.forEach(apps, function (app) {
        if (app.match(coachName)) {
          coachVersionSuffix = '-' + app.replace('openstax/tutor-js (' + coachName + ') @ ', '');
        }
      });

      updateCache(jqXHR, coachVersionSuffix);
      return coachVersionSuffix;
    }

    function handleCoachConfiguration(coachVersionSuffix) {
      // fallback to non-suffixed version if version checking fails.
      if (!_.isString(coachVersionSuffix)) {
        coachVersionSuffix = getCachedCoachVersion() || '';
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

      function handleOptions(options) {
        if (_.isFunction(options)) {
          return options;
        } else if (_.isObject(options)) {
          return _.clone(options) || {};
        }
      }

      function configureForFeatures(features) {
        var featureConfigs = _.map(features, function (featureOptions, feature) {
          if (_.contains(settings.features, feature)) {
            return handleOptions(featureOptions.enable);
          } else {
            return handleOptions(featureOptions.disable);
          }
        });

        $.when.apply($, featureConfigs).done(function () {
          var featureConfig = _.deepExtend.apply(_, arguments);
          require.config(featureConfig);
        });
      }

      configureForFeatures(features);
    };
  });

})();
