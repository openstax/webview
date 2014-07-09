# Adapted from: https://github.com/olalonde/handlebars-paginate

define (require) ->
  Handlebars = require('hbs/handlebars')

  Handlebars.registerHelper 'paginate', (pagination, options) ->
    type = options.hash.type or 'middle'
    ret = ''
    pageCount = Number(pagination.pageCount)
    page = Number(pagination.page)

    if options.hash.limit then limit = +options.hash.limit

    newContext = {}
    switch type
      when 'middle'
        if typeof limit is 'number'
          i = 0
          leftCount = Math.ceil(limit / 2) - 1
          rightCount = limit - leftCount - 1
          if page + rightCount > pageCount
            leftCount = limit - (pageCount - page) - 1
          if page - leftCount < 1
            leftCount = page - 1
          start = page - leftCount

          while i < limit && i < pageCount
            newContext = { n: start }
            if start is page then newContext.active = true
            ret = ret + options.fn(newContext)
            start++
            i++

        else
          for i in [0..pageCount] by 1
            newContext = { n: i }
            if i is page then newContext.active = true
            ret = ret + options.fn(newContext)

      when 'previous'
        if page is 1
          newContext = { disabled: true, n: 1 }
        else
          newContext = { n: page - 1 }

        ret = ret + options.fn(newContext)

      when 'next'
        newContext = {}
        if page is pageCount
          newContext = { disabled: true, n: pageCount }
        else
          newContext = { n: page + 1 }

        ret = ret + options.fn(newContext)

    return ret
