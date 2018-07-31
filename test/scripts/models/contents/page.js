describe('Page model', function () {
  'use strict';
  var page;
  var book;

  beforeEach(function (done) {
    require(['cs!models/contents/page'], function (Page) {
      page = new Page();
      require(['cs!models/contents/collection'], function (Collection) {
        book = new Collection();
        done();
      });
    });
  });
  it('should not have empty content', function () {
    page.get('content').should.not.equal('');
  });
  it('should return a default media type', function () {
    page.get('mediaType').should.equal('application/vnd.org.cnx.module');
  });
  it('should use the non-contextual extras url if not in a book', function () {
    page.id = 'abcd@1234';
    page.isInBook().should.equal(false);
    page.extrasUrl().should.contain('/contents/' + page.id);
  });
  it('should use the contextual extras url if in a book', function () {
    book.id = 'abcd@1234';
    page.set('book', book);
    page.id = 'efgh@5678';
    page.isInBook().should.equal(true);
    page.extrasUrl().should.contain('/contents/' + book.id + ':' + page.id);
  });
});
