describe('nav tests', function () {
  'use strict';
  var page;

  beforeEach(function (done) {
    require(['cs!models/contents/page'], function (Page) {
      page = new Page();
      done();
    });
  });
  describe('templateHelpers tests', function () {
    it('should set the rel=next/prev tags', function () {
      page.get('content').should.not.equal('');
    });
  });
});
