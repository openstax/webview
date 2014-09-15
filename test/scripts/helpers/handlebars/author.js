describe('handlebar author helper tests', function () {
  'use strict';
  var author, Handlebars, 
    should = chai.should();

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars','cs!helpers/handlebars/author'], function () {
      Handlebars = arguments[0];
      author = arguments[1];
      done();
    });
  });
  
  it('should retrieve the name', function() {
    var myObj = {author: 'Caroline'};
	var myList = [myObj];
	Handlebars.helpers.author(myList, 0, 'author').toString().should.equal('Caroline');
  });
});