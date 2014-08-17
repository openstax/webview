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

describe('loader tests', function () {
  'use strict';

  var loader;

  chai.should();

  beforeEach(function (done) {
    require(['cs!loader'], function () {
      loader = arguments[0];
      done();
    });
  });

  describe('init tests', function () {
    it('should return -1 when the value is not present', function () {
      [1, 2, 3].indexOf(5).should.equal(-1);
    });
  });
});
