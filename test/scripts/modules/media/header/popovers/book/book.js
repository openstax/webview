describe('book header popover', function () {
  'use strict';
  var popoverView, content;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!modules/media/header/popovers/book/book', 'cs!models/content'],
      function (Popover, Content) {
        content = new Content();
        popoverView = new Popover({
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

    popoverView.render();
    popoverView.$el.find('[download]').length.should.equal(1);
    popoverView.$el.find('[download]').attr('href').should.equal('cool path');
    popoverView.$el.find('[download]').attr('download').should.equal('some file.pdf');
  });
});
