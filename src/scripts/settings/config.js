(function () {
  'use strict';

  define(function () {
    return function(settings, _){
      var features = {
        conceptCoach: {
          enable: {
            paths: {
              OpenStaxConceptCoach: settings.conceptCoach.base + '/full-build.min'
            },
            shim: {
              OpenStaxConceptCoach: {
                deps: ['css!' + settings.conceptCoach.base + '/main.min'],
                exports: 'OpenStaxConceptCoach'
              }
            }
          }
        }
      };

      var initialConfig = [{}];
      var featureConfigs = _.map(features, function(featureOptions, feature){
        if(_.contains(settings.features, feature)){
          return _.clone(featureOptions.enable) || {};
        } else {
          return _.clone(featureOptions.disable) || {};
        }
      });

      featureConfigs.unshift({});
      var featureConfig = _.deepExtend.apply(_, featureConfigs);
      require.config(featureConfig);
    }
  });

})();