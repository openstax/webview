describe('handlebar date helper tests', function () {
  'use strict';
  var date, Handlebars, myDate = new Date();

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars', 'cs!helpers/handlebars/date'], function () {
      Handlebars = arguments[0];
      date = arguments[1];
      done();
    });
  });

  it('should create date html from date object', function () {
    var dateItems = Handlebars.helpers.date(myDate).toString().split('/');
    parseInt(dateItems[0], 10).should.equal(myDate.getMonth() + 1);
    parseInt(dateItems[1], 10).should.equal(myDate.getDate());
    dateItems[2].should.equal(myDate.getFullYear().toString());
  });

  it('should create date html with just the year', function () {
    var dateStr = Handlebars.helpers.date('year');
    dateStr.toString().should.equal(myDate.getFullYear().toString());
  });

  it('should create date html for today', function () {
    var periods = ['month', 'day', 'weekday'];
    for (var i = 0; i < 3; i++) {
      var p = periods[i];
      var dateItems = Handlebars.helpers.date(p).toString().split('/');
      parseInt(dateItems[0], 10).should.equal(myDate.getMonth() + 1);
      parseInt(dateItems[1], 10).should.equal(myDate.getDate());
      dateItems[2].should.equal(myDate.getFullYear().toString());
    }

  });

  it('should create a date and date html from a date string', function () {
    var dateStr = Handlebars.helpers.date('12/11/2012').toString();
    dateStr.should.equal('12/11/2012');
  });


});
