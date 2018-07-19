describe('handlebar date helper tests', function () {
  'use strict';
  var date, Handlebars, myDate = new Date();
  var dateRegex = /(\w+)(?:\/|\s)(\d\d)(?:\/|,\s)(\d\d\d\d)/;
  var months = {
    'January': 0,
    'February': 1,
    'March': 2,
    'April': 3,
    'May': 4,
    'June': 5,
    'July': 6,
    'August': 7,
    'September': 8,
    'October': 9,
    'November': 10,
    'December': 11
  };

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars', 'cs!helpers/handlebars/date'], function () {
      Handlebars = arguments[0];
      date = arguments[1];
      done();
    });
  });

  it('should create date html from date object', function () {
    var dateItems = dateRegex.exec(Handlebars.helpers.date(myDate).toString());
    var month = (typeof (dateItems[1]) === 'number' ? dateItems[1] : months[dateItems[1]]);
    month.should.equal(myDate.getMonth());
    parseInt(dateItems[2]).should.equal(myDate.getDate());
    parseInt(dateItems[3]).should.equal(myDate.getFullYear());
  });

  it('should create date html with just the year', function () {
    var dateStr = Handlebars.helpers.date('year');
    dateStr.toString().should.equal(myDate.getFullYear().toString());
  });

  it('should create date html for today', function () {
    var periods = ['month', 'day', 'weekday'];
    for (var i = 0; i < 3; i++) {
      var p = periods[i];
      var dateItems = dateRegex.exec(Handlebars.helpers.date(p).toString());
      var month = (typeof (dateItems[1]) === 'number' ? dateItems[1] : months[dateItems[1]]);
      month.should.equal(myDate.getMonth());
      parseInt(dateItems[2]).should.equal(myDate.getDate());
      parseInt(dateItems[3]).should.equal(myDate.getFullYear());
    }

  });

  it('should create a date and date html from a date string', function () {
    var dateItems = dateRegex.exec(Handlebars.helpers.date('12/11/2012').toString());
    var month = (typeof (dateItems[1]) === 'number' ? dateItems[1] : months[dateItems[1]]);
    month.should.equal(11);
    parseInt(dateItems[2]).should.equal(11);
    parseInt(dateItems[3]).should.equal(2012);
  });


});
