# Internationalization Guidelines

This document aims to provide CNX developers with complete instructions for handling internationalization frameworks used by Katalyst Education. The frameworks are: Rails i18n for ox-accounts and L20n for webview.

## Document Index
- The Rails I18n Gem
- The L20n Internationalization Framework
 - Getting Started – The Guidelines
 - How does l20n work?
- Understanding FTL
 - FTL files
 - FTL keys naming convention
- Interpolation / External arguments
  - Localizing Content
  - Localizing CSS
  - Localizing HTML
  - Localizing CoffeeScript
  - Localizing assets (e.g. images)
- Structure of ./locale catalog

### The Rails I18n Gem
The Rails I18n Gem is an internationalization library used by RubyOnRails for providing translations within Ruby and ERB scripts. For detailed description see Rails Internationalization (I18n) API.

## The L20n Internationalization Framework
L20n is a localization framework developed by Mozilla which allows translators to implement any desired grammatical constructs (such as pluralizations, grammar cases, etc.) independently from application code. We have chosen L20n as our i18n javascript library primarily due to its regular and up-to-date maintenance, ease of installation and implementation, and flexibility.

### Getting Started – The Guidelines
Basic guidelines of how to use L20n can be found under these links:
- Official project website
- Github documentation
- Learning examples
- HTML/JS API
- Support for older browsers

### How does l20n work?
L20n is linked to the main page through the script tag with the defer attribute. This allows L20n to run after the page is loaded. The framework adds itself to the global document object under the l10n namespace and uses the HTML5 APIs to listen for language and content changes, retranslating the website if needed. Each tag in the document with the `data-l10n-id` attribute will be matched to its equivalent in the FTL file, and provide the proper translation / pluralization.

**`Tip:`** You should remember to add short language code to the meta-tag `availableLanguages` if you plan to add new language to the translations. The correct form of the short code in *availableLanguages* is very important, especially for Safari.


## Understanding FTL

### FTL files
FTL files could be considered as dictionaries that contain keys matched to the HTML data-l10n-id attributes with respective translations for its content.
FTL files can handle multi line string and HTML content, selectors. It also can interpolate external arguments. Full documentation about FTL format may be found here. For developers using Atom editor, there is a plug-in for FTL syntax highlighting.

**`Tip:`** Do not use HTML with classes in FTL files. This will resolve with tightly-coupled code which is not desired. The translations need to be independent from system implementation.


### FTL keys naming convention
To provide organization in FTL and avoid confusion among translators, Webview FTL keys come with naming conventions respecting namespaces aligned to Webview sections visible to the users. After each prefix is a descriptive name of the translated element. For example, in this sample line of FTL `all-ask-us-button = Ask Us`, the prefix is **all-**. This indicates that it fits into the category of content viewable on all pages of webview.
Available prefixes (and corresponding location for user):
- all - content that is visible on all pages
- [about-contact](http://cnx.org/about/contact)
- [main](http://cnx.org/)
- [donate](http://cnx.org/donate)
- [search](http://cnx.org/browse)
- [advanced-search](http://cnx.org/search)
- [licensing](http://cnx.org/license)
- [search-results](http://cnx.org/search?q=subject:"Business")
- [tos](http://cnx.org/tos) - terms of service
- [about](http://cnx.org/about)
- [textbook-view](http://cnx.org/contents/02040312-72c8-441e-a685-20e9333f3e1d)
- [about-people](http://cnx.org/about/people)
- workspace - content that is visible in the "My Workspace" pages

**`Tip:`** Whenever possible, use existing prefixes to avoid confusion.


## Interpolation / External arguments

L20n allows developers to interpolate external arguments in translated strings, and use them to make conditional choices. For example:

```
search-results-number-results = { $counter ->
  [0]       No results found
  [1]       <strong>{ $counter }</strong> result found
  *[other]  <strong>{ $counter }</strong> results found
}
```

In the above case, the *$counter* value can influence the *search-results-number-results* output. This means that *search-results-number-results* can return different values assigned to 0, 1 or other identifier. To provide external argument for interpolation l20n use the `data-l10n-args` attribute. The content of this attribute is a stringified JSON object:

```
 data-l10n-args='{"username": "Mary"}'
```

**`Tip:`** Remember that strings in JSON are enclosed in double quoted `(")` and usage of single quotes `(')` is incorrect. While attribute values are usually enclosed in double quotes their presence inside the value forces it to be enclosed in single quotes.

**`Tip:`** If for some reason number values are passed as strings like e.g. `data-l10n-args='{"counter": "2"}'`, remember to use **PLURAL(** $counter **)** / **NUMBER(** $counter **)** in ftl files to get right value.


## Localizing Content

### Localizing CSS
Do not put any content in CSS selectors! All content should came from FTL files.

### Localizing HTML
Default language for the Webview is English. Even though L20n overrides any content that might be present inside a tag with data-l10n-id attributes the English content is left in source, so that in case of L20n failure the website will remain usable. This means that developers need to put original content in handlebar markup along with the corresponding strings in FTL files.

Whenever possible, the content should be provided through HTML attributes: `data-l10n-id` and `data-l10n-args`. This allows l20n to keep eye on DOM changes and run smoothly after page refresh.

**`Tip:`** While FTL format allows putting HTML markup inside the content, be aware of complex constructions such as deep nesting. This will cloud the code and make it harder to understand by the non-technical user.

### Localizing CoffeeScript
L20n has JavaScript API available under document.l10n namespace, providing methods likeready, requestLanguages, formatValues, setAttributes and others. Full documentation can be found here. These methods can be useful in many cases, but it is important to remember that whole API is Promise based which means that all requests are made asynchronously. It might be tricky to use it in synchronous CoffeeScript class declaration / instantiation.
Content added using those functions will not be managed by L20n. Therefore to reflect changes to locale (for example when user changes their browser language while the page is opened) the code will need to also listen to the locale change event.

Better solution is to rely on l20n HTML attributes. L20n is aware of any changes in HTML nodes that it serves, which give developers a lots of flexibility, especially when using Backbone based views. Taking advantage of Backbone developer have access to the element being rendered by the view ($el). This means that the attributes can be dynamically changed from the view while it is render, and l20n will get notice of those changes if they are made to the `data-l10n-id` or `data-l10n-args`. A good example of this approach is the internationalization of donation slider in the Webview.

**`Tip:`** The data-l10n-id attribute is not required to be an HTML element at first render to be registered in L20n. Webview views can add the attribute later and this also triggers the L20n translation.

### Localizing assets (e.g. images)
Asset localisation is handled outside of L20n, until it gets fully supported in the L20n framework. Currently each Webview view model is supplied with $locale variable congaing current locale-code. Furthermore each view is sensible for browser language change, so it can be automatically re-render in case of dynamic language change.

All assets that could be internationalized should be put in `./locale/{locale-code}/` catalog. Structure in each foreign language must be the same as in the default (English) ./locale/en-US/ folder.
To provide localized assets e.g. an image to the handlebars template, the following syntax is required: `./locale/{{ $locale }}/images/map.svg`.


## Structure of ./locale catalog
All the FTL files and other translated assets are located in `./locale/{locale-code}/` catalog. Default (and required) locale is english (./locale/en-US/). Any other locale is optional, but if another is added, it must have exactly the same structure as the en-US version.

**Current structure:**

```
locale /
    |--- en-US
        |--- images/            (folder with default assets - svg files)
        |--- dictionary.ftl     (file with all the strings)
    |--- pl
        |--- images/            (folder with translated assets - svg files)
        |--- dictionary.ftl     (file with all the strings)


```
