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

  it('should cut the string down to 30 characters', function () {
    var returnVal = Handlebars.helpers.trim('thisisastringwiththirtysixcharacters');
    returnVal.length.should.equal(30);
    returnVal.should.equal('thisisastringwiththirtysixchar');
  });
  it('should replace white space with underscores', function () {
    // space
    Handlebars.helpers.trim('  lots of    spaces ').should.equal('__lots_of____spaces_');
    // tabs
    Handlebars.helpers.trim('\tsome\ttabs\t').should.equal('_some_tabs_');
    // new lines
    Handlebars.helpers.trim('anewline\n').should.equal('anewline_');
  });
});
