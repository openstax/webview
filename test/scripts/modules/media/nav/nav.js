describe('nav tests', function () {
  'use strict';
  var nav, content;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!modules/media/nav/nav', 'cs!models/content'], function (MediaNavView, ContentModel) {
      content = new ContentModel();
      nav = new MediaNavView({
        'model': content
      });
      done();
    });
  });
  describe('templateHelpers tests', function () {
    it('should set the rel=next/prev tags', function () {
      nav.templateHelpers();
      document.querySelector('link[rel=\'next\']').getAttribute('href').should.equal('/contents/');
      document.querySelector('link[rel=\'prev\']').getAttribute('href').should.equal('/contents/');
      document.querySelectorAll('link[rel=\'next\']').length.should.equal(1);
      document.querySelectorAll('link[rel=\'prev\']').length.should.equal(1);
    });
  });
});
