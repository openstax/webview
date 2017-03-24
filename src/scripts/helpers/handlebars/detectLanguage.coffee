define (require) ->
  Handlebars = require('hbs/handlebars')

  # If value of tag is language code return internationalizable version of language span element,
  # else just return the value.
  Handlebars.registerHelper 'detectLanguage', (languages, tagValue) ->
    if languages[tagValue]
    then new Handlebars.SafeString "
      <span
      data-l10n-id=\"advanced-search-language-option\"
      data-l10n-args='#{JSON.stringify({
      native : languages[tagValue],
      code: tagValue
      })}'>
      #{tagValue}
      </span>"
    else tagValue
