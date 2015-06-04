describe('media header tests', function () {
  'use strict';
  var headerView, content, page;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!modules/media/header/header', 'cs!models/contents/page', 'cs!models/content'],
      function (Header, Page, Content) {
        content = new Content();
        headerView = new Header({
          'model': content
        });
        page = new Page();
        done();
      });
  });
  describe('title update test', function () {
    it('updateTitle should correctly change the title', function () {
      content.set('title', 'Book');
      page.set('title', 'New Chapter');
      content.set('currentPage', page);
      headerView.updateTitle().should.equal('Book - New Chapter');
    });
  });
});
