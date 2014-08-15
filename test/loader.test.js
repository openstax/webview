if (!Function.prototype.bind) {
  Function.prototype.bind = function (oThis) {
    if (typeof this !== "function") {
      // closest thing possible to the ECMAScript 5
      // internal IsCallable function
      throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
    }

    var aArgs = Array.prototype.slice.call(arguments, 1), 
    fToBind = this, 
    fNOP = function () {},
    fBound = function () {
      return fToBind.apply(this instanceof fNOP && oThis
             ? this
             : oThis,
             aArgs.concat(Array.prototype.slice.call(arguments)));
      };

  fNOP.prototype = this.prototype;
  fBound.prototype = new fNOP();

  return fBound;
  };
}
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

describe('loader tests', function () {

  var Loader;
  this.timeout(15000);
  beforeEach(function(done) {
    require(['config'], function() {
      require(['cs!loader'], function (loader) {
        Loader = clone(loader);
        done();
      });
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