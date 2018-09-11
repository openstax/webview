describe('find-content tests', function () {
  'use strict';
  var router, findContentView;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!router', 'cs!modules/find-content/find-content'],
      function (_router, FindContent) {
        router = _router;
        findContentView = new FindContent();
        done();
      });
  });

  describe('search', function () {
    it('icon should be clickable', function () {
      var query = 'asdf';
      router.navigate = sinon.spy();

      findContentView.render();
      findContentView.$el.find('input').val(query);
      findContentView.$el.find('.fa-search').click();

      router.navigate.args[0][0].should.equal('search?q=' + query);
    });
  });
});
