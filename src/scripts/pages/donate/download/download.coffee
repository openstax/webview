define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  Content = require('cs!models/content')
  template = require('hbs!./download-template')
  require('less!./download')

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

  return class DonateDownloadView extends BaseView
    template: template
    templateHelpers:
      value: () -> @value
      donation: () -> donation[@value]
      message: () -> message[@value]

    value: 2 # Default donation setting

    events:
      'change input[type="range"]': 'changeDonation'
      'submit form': 'onSubmit'

    initialize: (options = {}) ->
      super()

      # Allow downloads after they've visited the donation page
      # Cookie expires after 30 days
      document.cookie = "donation=requested; max-age=#{60*60*24*30}; path=/;"

      @uuid = options.uuid
      @type = options.type or 'pdf'
      @model = options.model or new Content({id: @uuid})

      @listenTo(@model, 'change:loaded', @render)

    changeDonation: (e) ->
      @value = $(e.currentTarget).val()
      @render()

    onSubmit: (e) ->
      e.preventDefault()

      amount = donation[@$el.find('input[name="donation"]').val()]
      router.navigate("/donate/form?amount=#{amount}&uuid=#{@uuid}&type=#{@type}", {trigger: true})
