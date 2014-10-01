describe('handlebars paginate helper tests', function () {
  'use strict';
  var Handlebars,
    myOptions = {
      fn: function (context) {
        if (context.active) {
          return '*' + context.n;
        }
        if (context.disabled) {
          return '!' + context.n;
        }
        return context.n;
      },
      hash: {
        type: false
      },
    },
    pagination = {
      pageCount: 10,
      page: 5
    };

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars', 'cs!helpers/handlebars/paginate'], function () {
      Handlebars = arguments[0];
      done();
    });
  });

  it('should use type middle by default with limit', function () {

    myOptions.hash.limit = 13;
    Handlebars.helpers.paginate(pagination, myOptions).should.equal('1234*5678910');

    myOptions.hash.limit = 8;
    Handlebars.helpers.paginate(pagination, myOptions).should.equal('234*56789');

    myOptions.hash.limit = 4;
    Handlebars.helpers.paginate(pagination, myOptions).should.equal('4*567');

  });

  it('should use type middle with no limit', function () {
    myOptions.hash.type = 'middle';
    myOptions.hash.limit = false;
    Handlebars.helpers.paginate(pagination, myOptions).should.equal('01234*5678910');
  });

  it('should use type previous', function () {
    myOptions.hash.type = 'previous';
    Handlebars.helpers.paginate(pagination, myOptions).should.equal('4');

  });
  it('should use type previous and disable', function () {
    pagination.page = 1;
    Handlebars.helpers.paginate(pagination, myOptions).should.equal('!1');
  });
  it('should use type next', function () {
    myOptions.hash.type = 'next';
    Handlebars.helpers.paginate(pagination, myOptions).should.equal('2');
  });

  it('should use type next', function () {
    pagination.page = 10;
    Handlebars.helpers.paginate(pagination, myOptions).should.equal('!10');
  });
});
