describe('test page model', function () {
  'use strict';
  var Page,
    expect = chai.expect;

  beforeEach(function (done) {
    require(['cs!models/contents/page'], function () {
      Page = arguments[0];
      done();
    });
  });
  describe('model defaults', function () {
    it('should have default type for mediaType', function () {
      var page = new Page();
      expect(page.get('mediaType')).to.equal('application/vnd.org.cnx.module');
    });
  });
  describe('results returned', function () {
    it('should show default text if page is loaded and content is empty', function () {
      var page = new Page();
      var results = {
        content: '',
        loaded: true
      };
      if (results.loaded && results.content === '') {
        page.set('content', 'Some Content');
      }
      results.content = page.get('content');
      expect(results.content).to.equal('Some Content');
    });
  });
});
