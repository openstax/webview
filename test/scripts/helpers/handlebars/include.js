describe('handlebar include helper tests', function () {
  'use strict';
  var include, Handlebars,
    should = chai.should();

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars', 'cs!helpers/handlebars/include'], function () {
      Handlebars = arguments[0];
      include = arguments[1];
      done();
    });
  });

  it('should return the html safe string', function () {
    var myHtml = 'This. "is //my &html ?string$';
    Handlebars.helpers.include(myHtml).toString().should.equal('This. "is //my &html ?string$');
  });
  it('should not return anything', function () {
    var myNull = null;
    var myUndefined;
    should.not.exist(Handlebars.helpers.include(myNull));
    should.not.exist(Handlebars.helpers.include(myUndefined));
  });
});
