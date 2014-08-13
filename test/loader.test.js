
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

describe('loader tests', function(){

  var Loader;
  this.timeout(15000);
  beforeEach(function(done) {
    require(['poly/function', 'cs!loader'], function (loader) {
      Loader = clone(loader);
      done();
    });
  });

  describe('init tests', function(){
    it('should return -1 when the value is not present', function(){
      chai.assert.equal(-1, [1,2,3].indexOf(5));
      chai.assert.equal(-1, [1,2,3].indexOf(0));
    });
  });
  
  describe('backbone.sync tests', function() {
    it ('should manipulate promise', function() {
      Loader.Backbone_sync = sinon.stub.returns(new Object());
      promise = Loader.Backbone.sync('method', 'model', 'options');
      jqXHR = {status: 401};
      promise.fail(jqXHR);
      chai.assert.equal('log', '/log');
      Loader.Backbone_sync.restore();
	  });
    });
  });
