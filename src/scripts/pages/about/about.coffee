define (require) ->
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  HeaderView = require('cs!modules/header/header')
  FooterView = require('cs!modules/footer/footer')
  FindContentView = require('cs!modules/find-content/find-content')
  DefaultView = require('cs!./default/default')
  PeopleView = require('cs!./people/people')
  ContactView = require('cs!./contact/contact')
  template = require('hbs!./about-template')
  require('less!./about')

  return class AboutPage extends BaseView
    template: template
    templateHelpers:
      legacy: settings.legacy
    pageTitle: 'About OpenStax CNX'
    canonical: null
    summary: 'About OpenStax CNX'
    description: 'OpenStax CNX is a non-profit organization providing thousands of free online textbooks.'

    regions:
      find: '.find'
      content: '.about-content'

    initialize: (options = {}) ->
      super()
      @page = options.page

    onRender: () ->
      @parent.regions.header.show(new HeaderView({page: 'about'}))
      @parent.regions.footer.show(new FooterView({page: 'about'}))
      @regions.find.show(new FindContentView())

      switch @page
        when 'people'
          @regions.content.show(new PeopleView())
        when 'contact'
          @regions.content.show(new ContactView())
        else
          @regions.content.show(new DefaultView())
