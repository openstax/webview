describe('nav tests', function () {
  'use strict';

  //Defines bind, otherwise requiring nav breaks it
  if (!Function.prototype.bind) {
    Function.prototype.bind = function (oThis) {
      //'use strict';
      if (typeof this !== 'function') {
        // closest thing possible to the ECMAScript 5
        // internal IsCallable function
        throw new TypeError('Function.prototype.bind - what is trying to be bound is not callable');
      }

      var aArgs = Array.prototype.slice.call(arguments, 1),
        fToBind = this,
        FNOP = function () {},
        fBound = function () {
          return fToBind.apply(this instanceof FNOP ? this : oThis,
            aArgs.concat(Array.prototype.slice.call(arguments)));
        };

      if (this.prototype) {
        // native functions don't have a prototype
        FNOP.prototype = this.prototype;
      }
      fBound.prototype = new FNOP();

      return fBound;
    };
  }

<<<<<<< HEAD
  /*
   * Test is only valid for viewing a book
   *
    var nav, content;

    beforeEach(function (done) {
      require(['cs!modules/media/nav/nav', 'cs!models/content'], function (MediaNavView, ContentModel) {
        content = new ContentModel();
        nav = new MediaNavView({
          'model': content
        });
        done();
      });
    });
    describe('templateHelpers tests', function () {
      it('should set a single rel=next and single rel=prev tag', function () {
        nav.templateHelpers();
        document.querySelectorAll('link[rel=\'next\']').length.should.equal(1);
        document.querySelectorAll('link[rel=\'prev\']').length.should.equal(1);
      });
    });
    */
=======
  var nav, content;

  beforeEach(function (done) {
    require(['cs!modules/media/nav/nav', 'cs!models/content'], function (MediaNavView, ContentModel) {
      content = new ContentModel();
      nav = new MediaNavView({
        'model': content
      });
      done();
    });
  });
  describe('templateHelpers tests', function () {
    it('should set a single rel=next and single rel=prev tag', function () {
      nav.templateHelpers();
      document.querySelectorAll('link[rel=\'next\']').length.should.equal(1);
      document.querySelectorAll('link[rel=\'prev\']').length.should.equal(1);
    });
  });
>>>>>>> Merge pull request #1145 from Connexions/next-prev-link
});
