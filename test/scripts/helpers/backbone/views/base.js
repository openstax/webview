describe('backbone base view helper tests', function () {
  'use strict';
  var Backbone, BaseView, $,
    should = chai.should();

  beforeEach(function (done) {
    this.timeout(10000);

    require(['backbone', 'cs!helpers/backbone/views/base', 'jquery'], function () {
      Backbone = arguments[0];
      BaseView = arguments[1];
      $ = arguments[2];
      done();
    });
  });
  describe('initialize tests', function () {
    it('should create element and regions', function () {
      // should be called on instantiation like a constructor
      var myBase = new BaseView();
      myBase.el.tagName.should.equal('DIV');
      myBase.el.childNodes.length.should.equal(0);
      should.exist(myBase.regions.self);
      myBase.regions.self.parent.should.equal(myBase);
    });
  });
  describe('render dom tests', function () {
    it('should load the template in to el', function () {
      var temp = '<html>' +
        '<head>' +
        '    <title>This is some test HTML</title>' +
        '</head>' +
        '<body>' +
        '    <h1>Some Interesting Links</h1>' +
        '    <ul>' +
        '        <li><a href="http://foo.org">The Foo Site</a>' +
        '        <li><a href="http://bar.org">The Bar Site</a>' +
        '    </ul>' +
        '        </body>' +
        '    </html>';
      var myBase = new BaseView();
      myBase.template = temp;
      myBase.renderDom();
      myBase.el.tagName.should.equal('DIV');
      myBase.el.childNodes.length.should.equal(7);
      myBase.el.innerText.should.equal('    This is some test HTML    Some Interesting Links            ' +
        'The Foo Site        The Bar Site                ');
    });
  });
  describe('update page info tests', function () {
    it('should change the page title', function () {
      var myBase = new BaseView();

      // should do nothing
      var titleBefore = document.title;
      myBase.updatePageInfo();
      document.title.should.equal(titleBefore);

      // should update the title
      myBase.pageTitle = 'title tests';
      myBase.updatePageInfo();
      document.title.should.equal('title tests - OpenStax CNX');

      // canonical should still not have been set
      should.not.exist(document.querySelector('link[rel=\'canonical\']'));
    });
    it('should change canonical', function () {
      // set it the first time
      var myBase = new BaseView();
      myBase.canonical = 'something';
      myBase.updatePageInfo();
      document.querySelector('link[rel=\'canonical\']').getAttribute('href').should.equal('something');

      // remove the old and reset
      myBase.canonical = 'somethingElse';
      myBase.updatePageInfo();
      document.querySelector('link[rel=\'canonical\']').getAttribute('href').should.equal('somethingElse');
      document.querySelectorAll('link[rel=\'canonical\']').length.should.equal(1);
    });
  });

  describe('get template tests', function () {
    it('should get the template from template field', function () {
      var myBase = new BaseView();
      myBase.template = 'something';
      myBase.getTemplate().should.equal('something');
    });
    it('should get the template from the template data', function () {
      var myBase = new BaseView();
      myBase.getTemplateData = function () {
        return 'testData';
      };
      myBase.template = function (inVal) {
        if (inVal === 'testData') {
          return true;
        }
        return false;
      };
      myBase.getTemplate().should.equal(true);
    });
  });
  describe('get template data tests', function () {
    it('should get template data from models and collections', function () {
      var myBase = new BaseView();
      // has a toJSON method
      var modelDate = new Date(2014, 1, 1);
      modelDate.setUTCHours(0);
      myBase.model = modelDate;
      myBase.getTemplateData().should.equal('2014-02-01T00:00:00.000Z');
      var collectionDate = new Date(2013, 4, 5);
      collectionDate.setUTCHours(0);
      myBase.collection = collectionDate;
      myBase.getTemplateData().should.equal('2014-02-01T00:00:00.000Z');
      myBase.model = undefined;
      myBase.getTemplateData().should.equal('2013-05-05T00:00:00.000Z');
    });
    it('should add single result of template helpers to data', function () {
      // leave data empty in beginning (don't set model or collections)
      var myBase = new BaseView();
      myBase.templateHelpers = function () {
        return {
          test: 'pass'
        };
      };
      myBase.getTemplateData().test.should.equal('pass');
    });
    it('should add other/mixed template helpers to data', function () {
      // leave data empty in beginning (don't set model or collections)
      var myBase = new BaseView();
      myBase.templateHelpers = {
        testField: true,
        testFunction: function () {
          return true;
        }
      };
      var data = myBase.getTemplateData();
      data.testField.should.equal(true);
      data.testFunction.should.equal(true);
    });
  });
  describe('add meta tags tests', function () {
    it('should set summary meta data', function () {
      var loc = window.location.href;
      document.title = 'Meta tag tests';
      var myBase = new BaseView();
      myBase.summary = 'summary';
      myBase.addMetaTags();
      document.querySelector('meta[property=\'og:url\']').getAttribute('content').should.equal(loc);
      document.querySelector('meta[property=\'og:title\']').getAttribute('content').should.equal('Meta tag ' +
        'tests');
      document.querySelector('meta[property=\'og:description\']').getAttribute('content').should.equal('summary');
      document.querySelector('meta[property=\'og:image\']').getAttribute('content').should.equal('file:///' +
        'images/social/logo.png');
    });
    it('should set description meta data', function () {
      var myBase = new BaseView();
      myBase.description = 'description';
      myBase.addMetaTags();
      document.querySelector('meta[name=\'description\']').getAttribute('content').should.equal('description');
    });
    it('should reset meta data', function () {
      var loc = window.location.href;
      document.title = 'Meta tag tests';
      var myBase = new BaseView();
      myBase.summary = 'summary';
      myBase.description = 'description';
      myBase.addMetaTags();
      myBase.summary = 'second summary';
      myBase.description = 'second description';
      myBase.addMetaTags();
      document.querySelector('meta[property=\'og:url\']').getAttribute('content').should.equal(loc);
      document.querySelectorAll('meta[property=\'og:url\']').length.should.equal(1);
      document.querySelector('meta[property=\'og:title\']').getAttribute('content').should.equal('Meta tag ' +
        'tests');
      document.querySelectorAll('meta[property=\'og:title\']').length.should.equal(1);
      document.querySelector('meta[property=\'og:description\']').getAttribute('content').should.equal('second' +
        ' summary');
      document.querySelectorAll('meta[property=\'og:description\']').length.should.equal(1);
      document.querySelector('meta[property=\'og:image\']').getAttribute('content').should.equal('file:///' +
        'images/social/logo.png');
      document.querySelectorAll('meta[property=\'og:image\']').length.should.equal(1);
      document.querySelector('meta[name=\'description\']').getAttribute('content').should.equal('second ' +
        'description');
      document.querySelectorAll('meta[name=\'description\']').length.should.equal(1);
    });
  });
  describe('render tests', function () {
    it('should call all functions and set render to true', function () {
      var myBase = new BaseView();
      myBase.onBeforeRender = sinon.spy();
      myBase.onRender = sinon.spy();
      myBase.onAfterRender = sinon.spy();
      myBase.onDomRefresh = sinon.spy();
      myBase.updatePageInfo = sinon.spy();
      myBase.renderDom = sinon.spy();

      // hasn't already been rendered
      myBase._rendered = false;
      myBase.render();
      myBase.onBeforeRender.callCount.should.equal(1);
      myBase.onRender.callCount.should.equal(1);
      myBase.onAfterRender.callCount.should.equal(1);
      myBase.onDomRefresh.callCount.should.equal(0);
      myBase.updatePageInfo.callCount.should.equal(1);
      myBase.renderDom.callCount.should.equal(1);
      myBase._rendered.should.equal(true);

      // has already been rendered
      myBase._rendered = true;
      myBase.render();
      myBase.onBeforeRender.callCount.should.equal(2);
      myBase.onRender.callCount.should.equal(2);
      myBase.onAfterRender.callCount.should.equal(2);
      myBase.onDomRefresh.callCount.should.equal(1);
      myBase.updatePageInfo.callCount.should.equal(2);
      myBase.renderDom.callCount.should.equal(2);
      myBase._rendered.should.equal(true);
    });
    it('should empty the regions', function () {
      var myBase = new BaseView();
      var region = {
        called: false,
        empty: function () {
          this.called = true;
        }
      };
      myBase.regions = [region];
      myBase.render();
      var newRegion = myBase.regions[0];
      newRegion.called.should.equal(true);
    });
  });
  describe('close tests', function () {
    it('should call all functions and return itself', function () {
      var myBase = new BaseView();
      myBase.onBeforeClose = sinon.spy();
      myBase.off = sinon.spy();
      myBase.remove = sinon.spy();
      myBase.unbind = sinon.spy();
      var close = myBase.close();
      myBase.onBeforeClose.callCount.should.equal(1);
      myBase.off.callCount.should.equal(1);
      myBase.remove.callCount.should.equal(1);
      myBase.unbind.callCount.should.equal(1);
      close.should.equal(myBase);
    });
    it('should close all the regions', function () {
      var myBase = new BaseView();
      var region = {
        called: false,
        close: function () {
          this.called = true;
        }
      };
      myBase.regions = [region];
      myBase.close();
      region.called.should.equal(true);
    });
    it('should dispose the view', function () {
      var myBase = new BaseView();
      // should delete parent el and regions
      myBase.parent = 'mom';
      myBase.el = 'some dom element';
      myBase.regions = [{
        close: function () {}
      }];
      myBase.close();
      should.not.exist(myBase.parent);
      should.not.exist(myBase.el);
      should.not.exist(myBase.regions);
    });
  });
});
