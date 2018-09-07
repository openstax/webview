describe('header tests', function () {
  'use strict';
  var headerView;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!modules/header/header'],
      function (Header) {
        headerView = new Header();
        done();
      });
  });

  describe('donate link', function () {
    it('should go to openstax', function () {
      headerView.render();
      headerView.$el.find('#nav-donate a').attr('href').should.equal('https://openstax.org/give');
    });
  });
});
