define (require) ->
  settings = require('settings')
  BaseView = require('cs!helpers/backbone/views/base')
  MainPageView = require('cs!modules/main-page/main-page')
  DefaultView = require('cs!./default/default')
  ContactView = require('cs!./contact/contact')
  template = require('hbs!./about-template')
  require('less!./about')

  class InnerView extends BaseView
    template: template
    templateHelpers:
      legacy: settings.legacy

    regions:
      content: '.about-content'

    initialize: (options = {}) ->
      super()
      @page = options.page

    onRender: () ->
      $items = $('nav.about-nav li').removeClass('active')
      if (@page)
        $items.find("a[href*=#{@page}]").parent().addClass('active')
      else
        $items.first().addClass('active')
      switch @page
        when 'contact'
          @regions.content.show(new ContactView())
        else
          @regions.content.show(new DefaultView())

  return class AboutPage extends MainPageView
    pageTitle: 'About OpenStax CNX'
    canonical: null
    summary: 'About OpenStax CNX'
    description: 'OpenStax CNX is a non-profit organization providing thousands of free online textbooks.'

    initialize: (@options) ->
      super()

    onRender: ->
      super()
      @regions.main.show(new InnerView(@options))
