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
    it('should create fragment', function () {
      // root is not at the beginning of pathname
      var myPath = history.location.pathname;
      var mySearch = history.location.search;
      var myRoot = history.root;
      history.root = 'myRoot';
      var newFragment = myPath + mySearch;
      newFragment = newFragment.replace(/^[#\/]|\s+$/g, '');
      history.getFragment(null, null).should.equal(newFragment);

      // root is at the beginning of pathname, should be sliced off
      history.root = myPath.slice(0, 5);
      history.getFragment(null, null).should.equal(newFragment.slice(5));

      // reset root to its original state
      history.root = myRoot;
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

    it('should replace the state', function () {
      sinon.spy(history.history, 'replaceState');
      history.navigate('test', {
        replace: true
      });
      history.history.replaceState.calledWith({}, document.title, 'test');
      history.fragment.should.equal('test');
    });

    it('should push the state', function () {
      sinon.spy(history.history, 'pushState');
      history.navigate('test', {
        replace: false
      });
      history.history.pushState.calledWith({}, document.title, 'test');
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
