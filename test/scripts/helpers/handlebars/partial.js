describe('handlebars partial helper tests', function () {
  'use strict';
  var Handlebars, $;

  beforeEach(function (done) {
    this.timeout(10000);

    require(['hbs/handlebars', 'cs!helpers/handlebars/partial', 'jquery'], function () {
      Handlebars = arguments[0];
      $ = arguments[2];
      done();
    });
  });

  it('should compile partial', function () {
    var person = {
        firstName: 'Alan',
        lastName: 'Johnson',
        email: 'alan@test.com',
        phone: '123-456-7890',
        memberSince: 'yesterday'
      },
      myOptions = {
        hash: person
      },
      personPartial = '<script id="person-partial" type="text/x-handlebars-template">' +
      '  <div class="person">' +
      '    <h2>{{firstName}} {{lastName}}</h2>' +
      '    <div class="phone">{{phone}}</div>' +
      '    <div class="email"><a href="mailto:{{email}}">{{email}}</a></div>' +
      '    <div class="since">User since {{memberSince}}</div>' +
      '  </div>' +
      '</script>',
      alan = '<script id="person-partial" type="text/x-handlebars-template">' +
      '  <div class="person">' +
      '    <h2>Alan Johnson</h2>' +
      '    <div class="phone">123-456-7890</div>' +
      '    <div class="email"><a href="mailto:alan@test.com">alan@test.com</a></div>' +
      '    <div class="since">User since yesterday</div>' +
      '  </div>' +
      '</script>';
    Handlebars.partials.person = personPartial;
    Handlebars.helpers.partial('person', myOptions).toString().should.equal(alan);
    var type = typeof Handlebars.partials.person;
    type.should.equal('function');
  });
});
