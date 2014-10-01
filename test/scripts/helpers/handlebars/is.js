describe('handlebars is helper tests', function () {
  'use strict';
  var isFunc, Handlebars,
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

    require(['hbs/handlebars', 'cs!helpers/handlebars/is'], function () {
      Handlebars = arguments[0];
      isFunc = arguments[1];
      done();
    });
  });

  it('should perform the true function', function () {
    Handlebars.helpers.is(2, 2, myOptions).should.equal('12/11/2012');
    Handlebars.helpers.is('test string', 'test string', myOptions).should.equal('12/11/2012');
    var myDate = new Date();
    Handlebars.helpers.is(myDate, myDate, myOptions).should.equal('12/11/2012');

  });
  it('should perform the false function', function () {
    Handlebars.helpers.is(2, 10, myOptions).should.equal('Caroline');
    Handlebars.helpers.is(undefined, 10, myOptions).should.equal('Caroline');
    Handlebars.helpers.is('This is my test', 10, myOptions).should.equal('Caroline');
    Handlebars.helpers.is('This is my test', 'This is not my test', myOptions).should.equal('Caroline');
  });
});
