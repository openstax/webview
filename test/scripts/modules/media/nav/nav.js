describe('nav tests', function () {
  'use strict';
  var Backbone, MediaNavView, Content, $;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['backbone', 'cs!modules/media/nav/nav', 'cs!models/content', 'jquery'], function () {
      Backbone = arguments[0];
      MediaNavView = arguments[1];
      Content = arguments[2];
      $ = arguments[3];
      done();
    });
  });
  describe('templateHelpers tests', function () {
    it('should set the rel=next/prev tags', function () {
      var content = new Content();
      var myNav = new MediaNavView({
        'model': content
      });

      myNav.templateHelpers();
      document.querySelector('link[rel=\'next\']').getAttribute('href').should.equal('/contents/');
      document.querySelector('link[rel=\'prev\']').getAttribute('href').should.equal('/contents/');
      document.querySelectorAll('link[rel=\'next\']').length.should.equal(1);
      document.querySelectorAll('link[rel=\'prev\']').length.should.equal(1);
    });
  });
});
