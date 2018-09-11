describe('book footer downloads', function () {
  'use strict';
  var downloadsView, content;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!modules/media/footer/downloads/downloads', 'cs!models/content'],
      function (Downloads, Content) {
        content = new Content();
        downloadsView = new Downloads({
          'model': content
        });
        done();
      });
  });

  it('should render downloads', function () {
    content.set('downloads', [{
      created: '2018-08-15T15:40:40-05:00',
      details: 'some pdf.',
      filename: 'some file.pdf',
      format: 'PDF',
      path: 'cool path',
      size: 82767062,
      state: 'good',
    }]);

    downloadsView.render();
    downloadsView.$el.find('[download]').length.should.equal(1);
    downloadsView.$el.find('[download]').attr('href').should.equal('cool path');
    downloadsView.$el.find('[download]').attr('download').should.equal('some file.pdf');
  });
});
