describe('handlebars trim helper tests', function () {
  'use strict';
  var Handlebars;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars', 'cs!helpers/handlebars/trim'], function () {
      Handlebars = arguments[0];
      done();
    });
  });

  it('should leave special characters alone and replace spaces', function () {
    Handlebars.helpers.trim('Najważniejsze stałe fizyczne').should.equal('Najważniejsze-stałe-fizyczne');
  });

  it('should replace white space with dashes', function () {
    // space
    Handlebars.helpers.trim('  lots of    spaces ').should.equal('lots-of-spaces');
    // tabs
    Handlebars.helpers.trim('\tsome\ttabs\t').should.equal('some-tabs');
    // new lines
    Handlebars.helpers.trim('anewline\n').should.equal('anewline');
  });
});
