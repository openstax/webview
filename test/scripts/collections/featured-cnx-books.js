describe('FeaturedCNXBooks collection', function () {
  'use strict';
  var featuredCnxBooks;

  beforeEach(function (done) {
    require(['cs!collections/featured-cnx-books'], function (books) {
      books.reset(extras, {
        parse: true
      });
      featuredCnxBooks = books;
      done();
    });
  });

  it('should have CNX Featured books', function () {
    featuredCnxBooks.length.should.equal(12);
    var books = featuredCnxBooks.models;
    books.should.not.be.empty;
    books.forEach(function (book) {
      var attributes = book.attributes;
      attributes.title.should.not.be.empty;
      attributes.title.should.not.equal('Untitled Book');
      // Description is a function here and some book descriptions are actually empty.
      var description = attributes.description();
      description.should.be.a('string');
      description.should.not.equal('This book has no description.');
      attributes.cover.should.not.be.empty;
      attributes.cover.should.not.equal('/images/books/default.png');
      attributes.type.should.equal('CNX Featured');
      attributes.id.should.not.be.empty;
      attributes.link.should.not.be.empty;
    });
  });
});
