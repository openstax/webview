define (require) ->
  $ = require('jquery')
  router = require('cs!router')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./breadcrumbs-template')
  require('less!./breadcrumbs')

  return class SearchResultsBreadcrumbsView extends BaseView
    template: template

    events:
      'mouseover .breadcrumb': 'hoverBreadcrumb'
      'mouseout .breadcrumb': 'unhoverBreadcrumb'
      'click .remove': 'removeBreadcrumb'

    hoverBreadcrumb: (e) ->
      $(e.currentTarget).find('.remove').css('opacity', 1)

    unhoverBreadcrumb: (e) ->
      $(e.currentTarget).find('.remove').css('opacity', 0)

    removeBreadcrumb: (e) ->
      limits = @model.get('query').limits
      limits.splice($(e.currentTarget).parent().data('index'), 1)

      query = @formatQuery(limits)
      @search(query)

    search: (query) ->
      router.navigate("search?q=#{query}", {trigger: true})

    formatQuery: (obj) ->
      format = (obj) ->
        _.map obj, (limit) ->
          key = _.keys(limit)[0]

          if /\s/g.test(limit[key]) and not /"/g.test(limit[key])
            limit[key] = "\"#{limit[key]}\""

          return "#{key}:#{limit[key]}"

      return _.compact(_.flatten(format(obj))).join(' ')
