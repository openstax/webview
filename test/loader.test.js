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
    // Load the application after the config
    require(['poly/function','config'], function(poly, config) {
      require(['cs!loader'], function (loader) {
        Loader = clone(loader);
        done();
      });
    });
  });
  
  describe('init', function(){
    it('should return -1 when the value is not present', function(){
      chai.assert.equal(-1, [1,2,3].indexOf(5));
      chai.assert.equal(-1, [1,2,3].indexOf(0));
    })
  })
})