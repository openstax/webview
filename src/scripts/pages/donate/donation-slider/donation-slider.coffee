define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./donation-slider-template')
  require('less!./donation-slider')

  donation = [0, 5, 10, 15, 20, 25, 50, 75, 100, 250, 500, 1000, 2500, 5000, 10000]
  message = [
    'Free makes me happy'
    'Abe Lincoln would be proud'
    'OpenStax CNX is a ten in my book (suggested donation)'
    'Thanks for saving me hundreds of dollars!'
    'My ATM wants you to have this'
    'Abe Lincoln would be proud (and amazed by ATMs)'
    'Hey OpenStax, give a printed copy to a school in need'
    'Here\'s something to help keep these books free!'
    'Giving back never felt so good'
    'On me: fill a school library with your books!'
    'Go buy yourself a fancy new translation!'
    'The next section of an OpenStax book is on me!'
    'The next chapter of an OpenStax book is on me!'
    'Bill Gates II, at your service'
    'WOWWWWWW!!!!'
  ]

  return class DonateSliderView extends BaseView
    template: template
    templateHelpers:
      uuid: () -> @uuid
      min: () -> @min
      max: () -> donation.length - 1
      value: () -> @value
      donation: () -> donation[@value]
      minDonation: () -> donation[@min]
      maxDonation: () -> donation[@max]
      message: () -> message[@value]
      path: () -> @getPath()
      isIpad: navigator.userAgent.match(/iPad/i) != null

    min: 1 # Default minimum donation
    value: 2 # Default donation setting

    events:
      'mousedown input[type="range"]': 'onSlideStart'
      'change input[type="range"]': 'changeDonation'
      'submit form': 'onSubmit'
      'click [data-ipad="true"]': (e) ->
        window.location.href = e.target.href

    initialize: (options = {}) ->
      super()
      @min = options.min if typeof options.min is 'number'
      @uuid = options.uuid
      @type = options.type or 'pdf'

      @listenTo(@model, 'change:downloads', @setDownload) if @model

    getPath: () ->
      if not @model then return ''

      download = _.find @model.get('downloads'), (download) =>
        format = download.format?.toUpperCase()

        if format is 'OFFLINE ZIP'
          format = 'ZIP'

        return format is @type.toUpperCase()

      return download?.path

    setDownload: () ->
      path = @getPath()

      if path
        $button = @$el.find('.btn-primary')
        $button.attr('href', path)
        $button.removeClass('disabled')

    onSlideStart: (e) ->
      slider = e.currentTarget

      onSlide = (e) =>
        @changeDonation.call(@, e)
        # fix for safari so that arrow keys work
        $('[type="range"]').focus()

      onSlideStop = (e) ->
        # Remove event listeners when the user stops dragging the slider
        slider.removeEventListener('mousemove', onSlide, false)
        document.body.removeEventListener('mouseup', onSlideStop, false)
        # fix for safari so that arrow keys work
        $('[type="range"]').focus()

      # fix for safari so that arrow keys work
      $('[type="range"]').focus()
      # Add event listeners when the user starts dragging the slider
      slider.addEventListener('mousemove', onSlide, false)
      slider.addEventListener('input', onSlide, false)
      document.body.addEventListener('mouseup', onSlideStop, false)

    changeDonation: (e) ->
      @value = $(e.currentTarget).val()
      @$el.find('[type="range"]').attr('aria-valuenow', donation[@value])

      # Dummy check if l20n exist:
      # If l20n exist/works this will prevent `.donation-value` value from flickering during donation slider moving.
      if (document.l10n)
        @$el.find('.donation-value').attr('data-l10n-args', "{\"amount\": #{donation[@value]} }")
        @$el.find('.donation-message').attr('data-l10n-id', "donate-slider-#{donation[@value]}")
      else
        @$el.find('.donation-value').text("$#{donation[@value]}")
        @$el.find('.donation-message').text("#{message[@value]}")

      if @value is '0'
        @$el.find('.btn-default').hide()
      else
        @$el.find('.btn-default').show()

    onSubmit: (e) ->
      e.preventDefault()

      amount = donation[@value]
      url = "/donate/form?amount=#{amount}"
      url += "&uuid=#{@uuid}&type=#{@type}" if @uuid and @type
      router.navigate(url, {trigger: true})
