define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./donation-slider-template')
  require('less!./donation-slider')

  donation = ['0', '5', '10', '15', '20', '25', '50', '75', '100', '250', '500', '1,000', '2,500', '5,000', '10,000']
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

    min: 1 # Default minimum donation
    value: 2 # Default donation setting

    events:
      'mousedown input[type="range"]': 'onSlideStart'
      'change input[type="range"]': 'changeDonation'
      'submit form': 'onSubmit'

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

      onSlide = (e) => @changeDonation.call(@, e)

      onSlideStop = (e) ->
        # Remove event listeners when the user stops dragging the slider
        slider.removeEventListener('mousemove', onSlide, false)
        document.body.removeEventListener('mouseup', onSlideStop, false)

      # Add event listeners when the user starts dragging the slider
      slider.addEventListener('mousemove', onSlide, false)
      document.body.addEventListener('mouseup', onSlideStop, false)

    changeDonation: (e) ->
      @value = $(e.currentTarget).val()
      @$el.find('.donation-value').text("$#{donation[@value]}")
      @$el.find('[type="range"]').attr('aria-valuenow', donation[@value])
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
