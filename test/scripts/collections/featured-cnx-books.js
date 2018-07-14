describe('FeaturedCNXBooks collection', function () {
  'use strict';
  var featuredCnxBooks;

  beforeEach(function (done) {
    require(['cs!collections/featured-cnx-books'], function (books) {
      books.reset(extras, {parse: true});
      featuredCnxBooks = books;
      done();
    });
  });

  it('should have CNX Featured books', function () {
    featuredCnxBooks.length.should.equal(1);
    var books = featuredCnxBooks.models;
    books.should.not.be.empty;
    books.forEach(function (book) {
      book.attributes.type.should.equal('CNX Featured');
    });
  });
});
