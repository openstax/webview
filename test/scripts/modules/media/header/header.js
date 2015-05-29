describe('media header tests', function () {
  'use strict';
  var MediaHeaderView, Content, myHeader, Backbone;
  // var should = chai.should();

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!modules/media/header/header', 'cs!models/content', 'backbone'], function () {
      MediaHeaderView = arguments[0];
      Content = arguments[1];
      Backbone = arguments[2];

      var cont = new Content();
      cont.set({
        'title': 'Book',
        'currentPage': {
          'title': 'Chapter'
        }
      });
      myHeader = new MediaHeaderView({
        'model': cont
      });
      // why doesn't this work?  Thought: function doesn't have get built in?
      // cont.get('currentPage').get('title').should.equal('asdf');
      done();
    });
  });
  describe('title update test', function () {
    it('should include the title and page name in title', function () {
      myHeader.updateTitle();
      myHeader.pageTitle.should.equal('Book - Chapter');
    });
  });
});
