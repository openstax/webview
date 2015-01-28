describe('social media helper tests', function () {
  'use strict';
  var SocialMedia;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['cs!helpers/socialmedia'], function () {
      SocialMedia = arguments[0];
      done();
    });
  });

  it('should set and encode all of the info', function () {
    var description = '+&Hello Günter&+';
    var share = SocialMedia.socialMediaInfo(description, 'a title!', 'http://whereICameFrom');
    share.source.should.equal('OpenStax%20CNX');
    share.via.should.equal('cnxorg');
    share.image.should.equal('http://whereICameFrom/images/logo.png');
    share.summary.should.equal('+&Hello%20G%C3%BCnter&+');
    decodeURI(share.title).should.equal('a title!');
    share.url.should.equal(window.location.href);
  });

});
