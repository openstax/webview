describe('handlebar greater than helper tests', function () {
  'use strict';
  var gt, Handlebars,
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

    require(['hbs/handlebars', 'cs!helpers/handlebars/gt'], function () {
      Handlebars = arguments[0];
      gt = arguments[1];
      done();
    });
  });

  it('should perform the true function', function () {
    Handlebars.helpers.gt(10, 2, myOptions).should.equal('12/11/2012');
  });
  it('should perform the false function', function () {
    Handlebars.helpers.gt(2, 10, myOptions).should.equal('Caroline');
  });
});
