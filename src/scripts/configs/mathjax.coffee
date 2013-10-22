# # Configure MathJax
# This module configures MathJax and runs right after `MathJax.js` is pulled into the browser.
#
define (require) ->

  config =
    extensions: [
      'mml2jax.js'
      'MathZoom.js'
      'MathMenu.js'
      'TeX/noErrors.js'
      'TeX/noUndefined.js'
    ]

    jax: [
      'input/MathML'
      'output/HTML-CSS'
      'output/NativeMML'
    ]

  return config
