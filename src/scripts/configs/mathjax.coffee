# # Configure MathJax
# This module configures MathJax and runs right after `MathJax.js` is pulled into the browser.
#
define (require) ->

  config =
<<<<<<< HEAD
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
=======
    jax: [
      'input/MathML'
      'input/TeX'
      'input/AsciiMath'
      'output/NativeMML'
      'output/HTML-CSS'
    ]
    extensions: [
      'asciimath2jax.js'
      'tex2jax.js'
      'mml2jax.js'
      'MathMenu.js'
      'MathZoom.js'
    ]
    tex2jax:
      inlineMath: [
        ['[TEX_START]','[TEX_END]']
        ['\\(', '\\)']
      ]

    # Apparently we cannot change the escape sequence for ASCIIMath (MathJax does not find it)
    #
    #     asciimath2jax: { inlineMath: [['[ASCIIMATH_START]', '[ASCIIMATH_END]']], },

    TeX:
      extensions: [
        'AMSmath.js'
        'AMSsymbols.js'
        'noErrors.js'
        'noUndefined.js'
      ]
      noErrors: {disabled:true}

    AsciiMath:
      noErrors: {disabled:true}
>>>>>>> 709c5b1c189396efffaf9e04945fa80df28a99b0

  return config
