describe('analytics tests', function () {
  'use strict';

  var Backbone, analytics;

  beforeEach(function (done) {
    require(['backbone', 'cs!helpers/handlers/analytics'], function () {
      Backbone = arguments[0];
      analytics = arguments[1];
      done();
    });
  });

  describe('gaq tests', function () {
    it('should push and pop from the window._gaq array', function () {
      var accountArg = ['_setAccount', 'my_test_account'],
        pageArg = ['_trackPageview', '/fake_path'];

      analytics.gaq(accountArg, pageArg);

      chai.assert.strictEqual(window._gaq[window._gaq.length - 1], pageArg);
      chai.assert.strictEqual(window._gaq[window._gaq.length - 2], accountArg);
      window._gaq.pop();
      window._gaq.pop();
    });

    it('should return undefined, not throw an error', function () {
      var temp = window._gaq,
        test,
        accountArg = ['_setAccount', 'my_test_account'],
        pageArg = ['_trackPageview', '/fake_path'];

      window._gaq = undefined;
      test = analytics.gaq(accountArg, pageArg);
      chai.assert.strictEqual(test, undefined);
      window._gaq = temp;
    });
  });

  describe('send tests', function () {
    it('should call gaq with given account and path', function () {
      var account = 'my_test_account',
        fragment = '/fake_path',
        test = false;

      analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', fragment]).returns(true);
      test = analytics.send(account, fragment);
      chai.assert.isTrue(test);
      //analytics.gaq.restore;
    });

    it('should call gaq with account from settings and backbone path', function () {
      var account = 'UA-7903479-1', // account from settings
        fragment = '/fake_path',
        test = false;

      Backbone.history.fragment = sinon.stub.returns(fragment);
      analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', fragment]).returns(
        true);
      test = analytics.send();
      chai.assert.isTrue(test);
      //analytics.gaq.restore;
      //Backbone.history.fragment.restore;
    });

    it('should fix the path fragment', function () {
      var account = 'my_test_account',
        fragment = 'fake_path',
        test = false;

      analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', '/fake_path']).returns(
        true);
      test = analytics.send(account, fragment);
      chai.assert.isTrue(test);
      //analytics.gaq.restore;
    });
  });
});
