describe('analytics tests', function () {
  'use strict';

  var Backbone, analytics,
    should = chai.should();

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

      window._gaq[window._gaq.length - 1].should.equal(pageArg);
      window._gaq[window._gaq.length - 2].should.equal(accountArg);
    });

    it('should return undefined, not throw an error', function () {
      var accountArg = ['_setAccount', 'my_test_account'],
        pageArg = ['_trackPageview', '/fake_path'];

      window._gaq = undefined;
      should.not.exist(analytics.gaq(accountArg, pageArg));
    });
  });

  describe('send tests', function () {
    it('should call gaq with given account and path', function () {
      var account = 'my_test_account',
        fragment = '/fake_path';

      analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', fragment]).returns(true);
      analytics.send(account, fragment).should.be.true;
    });

    it('should call gaq with account from settings and backbone path', function () {
      var account = 'UA-7903479-1', // account from settings
        fragment = '/fake_path';

      Backbone.history.fragment = sinon.stub.returns(fragment);
      analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', fragment]).returns(
        true);
      analytics.send().should.be.true;
    });

    it('should fix the path fragment', function () {
      var account = 'my_test_account',
        fragment = 'fake_path';

      analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', '/fake_path']).returns(
        true);
      analytics.send(account, fragment).should.be.true;
    });
  });
});
