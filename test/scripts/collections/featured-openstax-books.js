describe('FeaturedOpenStaxBooks collection', function () {
  'use strict';
  var featuredOpenStaxBooks;

  beforeEach(function (done) {
    require(['cs!collections/featured-openstax-books'], function (books) {
      books.reset(cmsBooks, {
        parse: true
      });
      featuredOpenStaxBooks = books;
      done();
    });
  });

  it('should have OpenStax Featured books', function () {
    featuredOpenStaxBooks.length.should.equal(36);
    var books = featuredOpenStaxBooks.models;
    books.should.not.be.empty;
    books.forEach(function (book) {
      var attributes = book.attributes;
      attributes.title.should.not.be.empty;
      attributes.title.should.not.equal('Untitled Book');
      attributes.description.should.not.be.empty;
      attributes.description.should.not.equal('This book has no description.');
      attributes.cover.should.not.be.empty;
      attributes.cover.should.not.equal('/images/books/default.png');
      attributes.type.should.equal('OpenStax Featured');
      attributes.id.should.not.be.empty;
      attributes.link.should.not.be.empty;
    });
  });
});
