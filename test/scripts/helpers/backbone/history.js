describe('backbone history helper tests', function () {
  'use strict';
  var Backbone, history,
    should = chai.should();

  beforeEach(function (done) {
    this.timeout(10000);

    require(['backbone', 'cs!helpers/backbone/history'], function () {
      Backbone = arguments[0];
      history = arguments[1];
      done();
    });
  });
  describe('get fragment tests', function () {
    it('should modify fragment', function () {
      history.getFragment('/test', null).should.equal('test');
      history.getFragment('#weird route      ', null).should.equal('weird route');
      history.getFragment('should_not_be_changed', null).should.equal('should_not_be_changed');
    });
  });
  describe('navigate tests', function () {
    it('should not do anything', function () {
      // before Backbone.history is started
      history.navigate('', true).should.equal(false);
      Backbone.history.start();
      history.fragment = 'test';
      should.not.exist(history.navigate('test', true));
      history.fragment.should.equal('test');
    });

    it('should trigger url to be loaded', function () {
      sinon.spy(history, 'loadUrl');
      history.navigate('test', true);
      history.fragment.should.equal('test');
      history.loadUrl.calledWith('test');
    });
  });
});
