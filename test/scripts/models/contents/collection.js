describe('Collection model', function () {
  'use strict';
  var collection;

  beforeEach(function (done) {
    require(['cs!models/contents/collection'], function (Collection) {
      collection = new Collection();
      done();
    });
  });
  it('should use the non-contextual extras url', function () {
    collection.id = 'abcd@1234';
    collection.isInBook().should.equal(false);
    collection.extrasUrl().should.contain('/extras/' + collection.id);
  });
});
