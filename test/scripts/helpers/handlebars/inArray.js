describe('handlebars in array helper tests', function () {
  'use strict';
  var inArray, Handlebars,
    myOptions = {
      fn: function (obj) {
        return obj.date('12/11/2012').toString();
      },
      inverse: function (obj) {
        return obj.author([{
          author: 'Caroline'
        }], 0, 'author').toString();
      }
    };

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars', 'cs!helpers/handlebars/inArray'], function () {
      Handlebars = arguments[0];
      inArray = arguments[1];
      done();
    });
  });

  it('should perform the true function', function () {
    Handlebars.helpers.inArray([1, 2, 3], 2, myOptions).should.equal('12/11/2012');
  });
  it('should perform the false function', function () {
    Handlebars.helpers.inArray([1, 2, 3], 10, myOptions).should.equal('Caroline');
    Handlebars.helpers.inArray(undefined, 10, myOptions).should.equal('Caroline');
  });
  it('should evaluate array and value', function () {
    var myArray = function () {
      return [1, 2, 3];
    };
    var myValue = function () {
      return 3;
    };
    Handlebars.helpers.inArray(myArray, myValue, myOptions).should.equal('12/11/2012');
  });
});
