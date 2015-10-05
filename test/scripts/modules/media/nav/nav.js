describe('nav tests', function () {
  'use strict';
  var nav, content;

  beforeEach(function (done) {
    require(['cs!modules/media/nav/nav', 'cs!models/content'], function (MediaNavView, ContentModel) {
      content = new ContentModel();
      nav = new MediaNavView({
        'model': content
      });
      done();
    });
  });
  describe('templateHelpers tests', function () {
    it('should set a single rel=next and single rel=prev tag', function () {
      nav.templateHelpers();
      document.querySelectorAll('link[rel=\'next\']').length.should.equal(1);
      document.querySelectorAll('link[rel=\'prev\']').length.should.equal(1);
    });
  });
});
