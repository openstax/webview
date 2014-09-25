describe('handlebars or helper tests', function () {
  'use strict';
  var Handlebars,
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

    require(['hbs/handlebars', 'cs!helpers/handlebars/or'], function () {
      Handlebars = arguments[0];
      done();
    });
  });

  it('should perform the true function', function () {
    Handlebars.helpers.or(2, 2, myOptions).should.equal('12/11/2012');
    Handlebars.helpers.or(0, 'test string', myOptions).should.equal('12/11/2012');
    var myDate = new Date();
    Handlebars.helpers.or(myDate, undefined, myOptions).should.equal('12/11/2012');

  });
  it('should perform the false function', function () {
    Handlebars.helpers.or(0, 0, myOptions).should.equal('Caroline');
    Handlebars.helpers.or(undefined, null, myOptions).should.equal('Caroline');
  });
});
