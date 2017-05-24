define (require) ->
  # Used for stripping HTML tags from the page title
  SCRATCH_DIV = document.createElement('div')

  # Strip tags for baked HTML titles
  return (htmlText) ->
    SCRATCH_DIV.innerHTML = htmlText
    htmlText = SCRATCH_DIV.textContent
    SCRATCH_DIV.innerHTML = '' # So the elements can be GC'd
    htmlText
