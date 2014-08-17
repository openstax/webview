if (!Function.prototype.bind) {
  Function.prototype.bind = function (oThis) {
    'use strict';

    if (typeof this !== 'function') {
      // closest thing possible to the ECMAScript 5
      // internal IsCallable function
      throw new TypeError('Function.prototype.bind - what is trying to be bound is not callable');
    }

    var aArgs = Array.prototype.slice.call(arguments, 1),
      fToBind = this,
      FNOP = function () {},
      fBound = function () {
        return fToBind.apply(this instanceof FNOP && oThis ? this : oThis,
          aArgs.concat(Array.prototype.slice.call(arguments)));
      };

    FNOP.prototype = this.prototype;
    fBound.prototype = new FNOP();

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
  'use strict';

  if (obj === null || typeof (obj) !== 'object') {
    return obj;
  }

  var temp = {};

  for (var key in obj) {
    if (obj.hasOwnProperty(key)) {
      temp[key] = clone(obj[key]);
    }
  }

  return temp;
}

describe('loader tests', function () {
  'use strict';

  var loader;

  beforeEach(function (done) {
    require(['cs!loader'], function () {
      loader = clone(arguments[0]);
      done();
    });
  });

  describe('init tests', function () {
    it('should return -1 when the value is not present', function () {
      chai.assert.equal(-1, [1, 2, 3].indexOf(5));
      chai.assert.equal(-1, [1, 2, 3].indexOf(0));
    });
  });

  /*describe('backbone.sync tests', function () {
    it ('should manipulate promise', function () {
      loader.Backbone_sync = sinon.stub.returns(new Object());
      promise = loader.Backbone.sync('method', 'model', 'options');
      jqXHR = {status: 401};
      promise.fail(jqXHR);
      chai.assert.equal('log', '/log');
      loader.Backbone_sync.restore();
	  });
  });*/
});
