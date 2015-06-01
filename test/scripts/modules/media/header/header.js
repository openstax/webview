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

      var model = new Content();
      model.set('title', 'Book');
      var curPage = (new Content()).asPage();
      curPage.set('title', 'Chapter');
      model.set('currentPage', curPage);
      myHeader = new MediaHeaderView({
        'model': model
      });
      done();
    });
  });
  describe('title update test', function () {
    it('should include the title and page name in title when updateTitle is called', function () {
      myHeader.updateTitle();
      myHeader.pageTitle.should.equal('Book - Chapter');
    });
    it('should automatically call updateTitle when currentPage changes', function () {
      var newCurPage = new Content();
      newCurPage.set('title', 'New Chapter');
      myHeader.model.set('currentPage', newCurPage);
      myHeader.pageTitle.should.equal('Book - New Chapter');
    });
  });
});
