describe('media header tests', function () {
  'use strict';
  // What do we actually need?
  var MediaHeaderView, Content, myHeader, Backbone;
  //    should = chai.should();

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!modules/media/header/header', 'cs!models/content', 'backbone'], function () {
      MediaHeaderView = arguments[0];
      Content = arguments[1];
      Backbone = arguments[2];

      //This defn ran until the tests at least...
      var cont = new Content();
      myHeader = new MediaHeaderView({
        'model': cont
      });
      done();
    });
  });
  describe('title tests', function () {
    it('should include the page name in title', function () {
      myHeader.model.set('title', 'A Scandal in Bohemia');
      myHeader.model.get('title').should.equal('A Scandal in Bohemia');
      //works to here
      //myHeader.model.set('currentPage', '7');
      //myHeader.model.get('currentPage').should.equal('7');

      myHeader.model.get('currentPage').should.equal(myHeader.getModel());
      myHeader.updateTitle();
      myHeader.pageTitle.should.equal('stringers');
      '1'.should.equal('1');
    });
  });
});
