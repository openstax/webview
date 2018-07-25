describe('MediaBodyView tests', function () {
  'use strict';

  var $, exercisesServer, mediaBodyView, embeddableTypes;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['jquery', 'settings', 'cs!modules/media/body/body', 'cs!configs/embeddables'],
      // jshint -W072
      // Because it complains about this callback having too many arguments
      function (jQuery, settings, MediaBodyView, embeddablesConfig) {
        $ = jQuery;
        var exercisesPort = settings.exercises.port ? ':' + settings.exercises.port : '';
        exercisesServer = 'file://' + settings.exercises.host + exercisesPort;
        mediaBodyView = new MediaBodyView();
        embeddableTypes = embeddablesConfig.embeddableTypes;
        done();
      }
    );
  });

  it('should return the correct url for each exercise', function () {
    var expectedItemCodes = [
      'k12phys-ch04-ex001',
      'k12phys-ch04-ex002',
      'some_nickname',
      'Another Nickname'
    ];
    var expectedAttributes = ['tag', 'nickname'];
    for (var embedIndex = 0; embedIndex < embeddableTypes.length; embedIndex++) {
      var embedType = embeddableTypes[embedIndex];
      // This is normally done in findEmbeddables for some reason
      embedType.matchAttr = 'href';
      var expectedAttribute = expectedAttributes[embedIndex];
      var exStart = embedIndex * 2;
      for (var exIndex = exStart; exIndex < exStart + 2; exIndex++) {
        var expectedItemCode = expectedItemCodes[exIndex];
        var expectedUrl = exercisesServer + '/api/exercises?q=' +
          expectedAttribute + ':"' + expectedItemCode + '"';
        var exerciseLink = $(exercises[exIndex]).find('a');
        var embeddableItem = mediaBodyView.getEmbeddableItem(embedType, exerciseLink);
        embeddableItem.itemCode.should.equal(expectedItemCode);
        embeddableItem.itemAPIUrl.should.equal(expectedUrl);
        embeddableItem.$el.should.equal(exerciseLink);
      }
    }
  });
});
