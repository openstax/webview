describe('handlebars isnt helper tests', function () {
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

    require(['hbs/handlebars', 'cs!helpers/handlebars/isnt'], function () {
      Handlebars = arguments[0];
      done();
    });
  });

  it('should perform the true function', function () {
    Handlebars.helpers.isnt(2, 10, myOptions).should.equal('12/11/2012');
    Handlebars.helpers.isnt(undefined, 10, myOptions).should.equal('12/11/2012');
    Handlebars.helpers.isnt('This is my test', 10, myOptions).should.equal('12/11/2012');
    Handlebars.helpers.isnt('This is my test', 'This is not my test', myOptions).should.equal('12/11/2012');

  });
  it('should perform the false function', function () {
    Handlebars.helpers.isnt(2, 2, myOptions).should.equal('Caroline');
    Handlebars.helpers.isnt('test string', 'test string', myOptions).should.equal('Caroline');
    var myDate = new Date();
    Handlebars.helpers.isnt(myDate, myDate, myOptions).should.equal('Caroline');
  });
});
