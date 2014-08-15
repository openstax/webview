
/**
 * Clones / deep copies an object.
 *
 * @param Object obj
 *   Any object.
 *
 * @return Object
 *   obj--cloned.
 */
function clone(obj) {
    if (obj === null || typeof(obj) !== 'object') {
      return obj;
    }

    var temp = new Object();

    for (var key in obj) {
      temp[key] = clone(obj[key]);
    }
    return temp;
}

describe('analytics tests', function(){
  var Analytics;

  beforeEach(function(done) {  
    require(['config'], function() {  
      require(['cs!helpers/handlers/analytics'], function(analytics) {
        Analytics = clone(analytics);
        done();
      });   
    });
  });

  describe('gaq tests', function(){
    it('should push and pop from the window._gaq array', function() {
	  var account_arg = ['_setAccount', 'my_test_account'];
	  var page_arg = ['_trackPageview', '/fake_path'];
      Analytics.gaq(account_arg, page_arg);
	  chai.assert.strictEqual(window._gaq[window._gaq.length - 1], page_arg);
      chai.assert.strictEqual(window._gaq[window._gaq.length - 2], account_arg);
      window._gaq.pop();
      window._gaq.pop();	  
    });
	it ('should return undefined, not throw an error', function() {
	  var temp = window._gaq;
	  window._gaq = undefined;
	  var account_arg = ['_setAccount', 'my_test_account'];
	  var page_arg = ['_trackPageview', '/fake_path'];
      var test = Analytics.gaq(account_arg, page_arg);
	  chai.assert.strictEqual(test, undefined);
	  window._gaq = temp;
	});
  });
  
  describe('send tests', function() {
    it ('should call gaq with given account and path', function() {
      var account = 'my_test_account';
      var fragment = '/fake_path';
	  var test = false;
      Analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', fragment]).returns(true);
      test = Analytics.send(account, fragment);
      chai.assert.isTrue(test);
	  Analytics.gaq.restore;
    });
    it ('should call gaq with account from settings and backbone path', function() {
	  var account = 'UA-7903479-1'; // account from settings
	  var fragment = '/fake_path';
	  var test = false;
      Backbone.history.fragment = sinon.stub.returns(fragment);
	  Analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', fragment]).returns(true);
	  test = Analytics.send();
      chai.assert.isTrue(test);
	  Analytics.gaq.restore;
	  Backbone.history.fragment.restore;
    });
    it ('should fix the path fragment', function() {
    var account = 'my_test_account';
      var fragment = 'fake_path';
	  var test = false;
      Analytics.gaq = sinon.stub().withArgs(['_setAccount', account], ['_trackPageview', '/fake_path']).returns(true);
      test = Analytics.send(account, fragment);
      chai.assert.isTrue(test);
	  Analytics.gaq.restore;
    });
    });
  });
