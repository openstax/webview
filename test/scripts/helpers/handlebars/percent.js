describe('handlebars or helper tests', function () {
  'use strict';
  var Handlebars;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars', 'cs!helpers/handlebars/percent'], function () {
      Handlebars = arguments[0];
      done();
    });
  });

  it('should calculate the correct percent', function () {
    Handlebars.helpers.percent(78, 100).should.equal(78);
    Handlebars.helpers.percent(1, 2).should.equal(50);
    Handlebars.helpers.percent(0, 3).should.equal(0);
    Handlebars.helpers.percent(200000000000, 200000000000).should.equal(100);
    Handlebars.helpers.percent(20, 0).should.equal(Infinity);
  });
});
