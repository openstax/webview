describe('backbone base view helper tests', function () {
  'use strict';
  var Backbone, MediaComp, myMedia, Content,
    should = chai.should();

  beforeEach(function (done) {
    this.timeout(10000);

    require(['backbone', 'cs!helpers/backbone/views/media-component', 'cs!models/content'], function () {
      Backbone = arguments[0];
      MediaComp = arguments[1];
      Content = arguments[2];
      myMedia = new MediaComp();
      done();
    });
  });

  describe('get property tests', function () {
    it('should return undefined because model is undefined', function () {
      should.not.exist(myMedia.getProperty('something'));
      myMedia.model = new Content();
      should.not.exist(myMedia.getProperty('something'));
    });
    it('should return the given property', function () {
      myMedia.model = new Content();
      myMedia.model.set('version', 46);
      myMedia.getProperty('version').should.equal(46);
      myMedia.getProperty('loaded').should.be.false;
    });
  });

  describe('set property tests', function () {
    it('should set the given property', function () {
      myMedia.model = new Content();
      myMedia.model.set('version', 46);
      myMedia.setProperty('version', 47);
      myMedia.getProperty('version').should.equal(47);
      myMedia.model.get('version').should.equal(47);
    });
  });

  describe('get model tests', function () {
    it('should return the model as a page', function () {
      myMedia.media = 'page';
      myMedia.model = new Content();
      myMedia.model.asPage = function () {
        return 'page version';
      };
      myMedia.getModel().should.equal('page version');
    });
    it('should return undefined because something is undefined', function () {
      myMedia.media = 'page';
      myMedia.model = 'another model';
      should.not.exist(myMedia.getModel());
      myMedia.model = undefined;
      should.not.exist(myMedia.getModel());
    });
    it('should return the model', function () {
      myMedia.media = 'not page';
      myMedia.model = new Content();
      myMedia.model.set('version', 46);
      myMedia.getModel().should.equal(myMedia.model);
    });
  });
});
