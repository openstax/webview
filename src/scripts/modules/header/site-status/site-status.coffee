define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  siteStatus = require('cs!collections/site-status')
  template = require('hbs!./site-status-template')

  return class SiteStatusView extends BaseView
    template: template
    collection: siteStatus
    templateHelpers:
      dateTime: () -> @dateTime()

    events: {
      'click .close': 'dismiss'
    }

    dismiss: (evt) ->
      alert = $(evt.currentTarget).closest('.alert')
      alertName = alert.attr('name')
      alert.remove()
      document.cookie = "#{alertName}=dismissed; max-age=#{60*60*24*14}; path=/;"
      @hideAlert(alertName)

    hideAlert: (alertName) ->
      models = @collection.models
      _.each models, (model) ->
        if model.get('name') is alertName
          model.set('show', false)

    initialize: () ->
      super()
      @listenTo(@collection, 'reset', @render)

    dateTime: () ->
      date = new Date()
      date.toISOString()
