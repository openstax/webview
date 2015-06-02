describe('media header tests', function () {
  'use strict';
  var headerView, content, page;
  var Header, Page, Content, Backbone;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!modules/media/header/header', 'cs!models/content', 'cs!models/content', 'backbone'],
      function () {
        Header = arguments[0];
        Content = arguments[1];
        Page = arguments[2];
        Backbone = arguments[3];

        content = new Content();
        headerView = new Header({
          'model': content
        });
        page = new Page();
        done();
      });
  });
  describe('title update test', function () {
    it('should include the title and page name in title when updateTitle is called', function () {
      page.set('title', 'Page');
      content.set('currentPage', page);
      content.set('title', 'Book');
      headerView = new Header({
        'model': content
      });
      headerView.updateTitle();
      headerView.pageTitle.should.equal('Book - Page');
    });
    it('should automatically call updateTitle when currentPage changes', function () {
      content.set('title', 'Book');
      page.set('title', 'New Chapter');
      content.set('currentPage', page);
      headerView.pageTitle.should.equal('Book - New Chapter');
    });
  });
});
