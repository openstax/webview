# Title:
#   English Translations FTL File
#
# Description:
#   This document provides the English translation of CNX.org when a user's
#   browser language is set to English.
#   It also serves as a template from which you can translate the website into
#   other languages.
#
# Organization:
#   Translations are organized into large sections based on the page that the
#   user would see (every section is followed by a description of the content)
#   and then subsections based on the location of the content in the src folder.
#   Section title format: ### TITLE OF PAGE ###
#   Subsection title format: # TITLE OF PAGE - Subheading - Location


### MAIN PAGE ###
# Link: http://cnx.org/
# This section consists entirely of content that is exclusive to the homepage.

# MAIN PAGE - Splash - src/scripts/modules/splash/splash-template.html

main-splash-head = Discover learning materials in an Open Space.

main-splash-content =
  | View and share free educational material in small modules that can
  | be organized as courses, books, reports or other academic assignments.

main-learn-more = Learn More

# MAIN PAGE - Title - src/scripts/pages/home/home.coffee

home-pageTitle = Sharing Knowledge and Building Communities - OpenStax CNX

# MAIN PAGE - Featured Textbooks - src/scripts/modules/featured-books/featured-books-partial.html

featured-books-read-more = Read More



### HEADER ###
# Content located in the header on each page. This includes the navigation
# and account interface.

# HEADER - Top Right Message - src/scripts/modules/header/header-template.html

all-cnx-author-legacy-site = CNX Author | Legacy Site
  [html/title] Switch to the CNX legacy web site

# HEADER - Nav Bar - src/scripts/modules/header/header-template.html

all-navbar-search = Search

all-navbar-about-us = About Us

all-navbar-give = Give

all-navbar-workspace = My Workspace

all-header-skip-to-content = skip to main content

all-header-skip-to-results = skip to results

all-header-account-profile = Account Profile

all-header-log-out = Log Out { $username }

all-navbar-toggle-navigation = Toggle navigation

all-header-support = Support
  [html/title] Got to CNX Support



### FOOTER ###
# Content located in the footer of every page.

# FOOTER - Footer - src/scripts/modules/footer/footer-template.html

all-footer-support =
  | Supported by William &amp; Flora Hewlett Foundation,
  | Bill &amp; Melinda Gates Foundation, 20 Million Minds Foundation,
  | Maxfield Foundation, Open Society Foundations, and Rice University.
  | Powered by OpenStax CNX.

all-footer-ap =
  | Advanced Placement® and AP® are trademarks registered
  | and/or owned by the College Board, which was not involved in the
  | production of, and does not endorse, this site.

all-footer-creative-commons =
  | Rice University. Except where otherwise
  | noted, content created on this site is licensed under
  | a Creative Commons Attribution 4.0 License.

all-footer-licensing = Licensing

all-footer-terms-of-use = Terms of Use

all-footer-contact = Contact

all-footer-connect = Connect

all-footer-android-app = Android App

all-footer-dev-blog = Dev Blog

all-footer-itunes = iTunes U

all-footer-share = Share



### ABOUT ###
# Link: http://cnx.org/about/
# Content located in just the section of the About page accessed when clicking
# the menu item. Also includes the navigation on the left for accessing sub
# directories in the about page like People and Contact.

# ABOUT - Page Title and Description - src/scripts/pages/about/about.coffee

about-pageTitle =  About OpenStax CNX

about-summary = About OpenStax CNX

about-description = OpenStax CNX is a non-profit organization providing thousands of free online textbooks.

# ABOUT - Navigation - src/scripts/pages/about/about-template.html

about-nav-about-us = About Us

about-nav-people = People

about-nav-contact = Contact

# ABOUT - Content - src/scripts/pages/about/default/default-template.html

about-header = About Us

about-content =
  | <p>OpenStax believes that everyone has something to learn, and everyone has something to teach.</p>
  |
  | <p>Frustrated by the limitations of traditional textbooks and courses, Dr. Richard Baraniuk
  | founded OpenStax (then Connexions) in 1999 at Rice University to provide authors and learners with
  | an open space where they can share and freely adapt educational materials such as courses, books, and reports. </p>
  |
  | <p>Today, OpenStax CNX is a dynamic non-profit digital ecosystem serving millions of users per month in the delivery
  | of educational content to improve learning outcomes.</p>
  |
  | <p>There are tens of thousands of learning objects, called <b>pages</b>, that are organized into thousands
  | of textbook-style <b>books</b> in a host of disciplines, all easily accessible online and downloadable to almost
  | any device, anywhere, anytime.</p>
  |
  | <p>The best part? Everything is available for free thanks to generous support from Rice University and several
  | philanthropic organizations.</p>

about-how-it-works-header = How it works

about-authors-can-header = Authors can:

about-allowing-learners-header = Allowing learners to:

about-frictionless-remix-header = Frictionless Remix

frictionless-content =
  | <p>OpenStax CNX is designed to encourage the sharing and reuse of educational content. The knowledge in OpenStax CNX
  | can be shared and built upon by all because it is reusable:</p>
  | <ul>
  | <li><b>educationally:</b>
  | We encourage authors to write each page to stand on its own so that others can easily use it in different
  | collections and contexts specially designed for their students.</li>
  |
  | <li><b>technologically:</b>
  | all content is built in a simple semantic HTML5 format rich with built-in accessibility features to ensure it can
  | all be read by everyone. Also the OpenStax CNX toolset makes it easy for author to create and adapt content using
  | a word processor similar to Google Docs or Word.</li>
  |
  | <li><b>legally:</b>
  | all content produced in OpenStax is available under a Creative Commons open-content licenses.
  | This makes it easy for authors to share their work - allowing others to use and reuse it legally - while still
  | getting recognition and attribution for their efforts. The OpenStax CNX software maintains attribution to the
  | original author for you, making remixing a cinch.</li>
  | </ul>

# ABOUT - Foundations - src/scripts/pages/about/people/people-template.html & src/scripts/pages/about/people/people.coffee

about-foundations-hewlett =
  | The William and Flora Hewlett Foundation has been making grants since 1967
  | to help solve social and environmental problems at home and around the world.
  | The Foundation concentrates its resources on activities in education, the
  | environment, global development and population, performing arts, and
  | philanthropy, and makes grants to support disadvantaged communities in the
  | San Francisco Bay Area.

about-foundations-gates =
  | Guided by the belief that every life has equal value, the Bill &amp; Melinda
  | Gates Foundation works to help all people lead healthy, productive lives.
  | In developing countries, it focuses on improving people’s health with
  | vaccines and other life-saving tools and giving them the chance to lift
  | themselves out of hunger and extreme poverty. In the United States, it seeks
  | to significantly improve education so that all young people have the
  | opportunity to reach their full potential. Based in Seattle, Washington,
  | the foundation is led by CEO Jeff Raikes and Co-chair William H. Gates Sr.,
  | under the direction of Bill and Melinda Gates and Warren Buffett.

about-foundations-maxfield =
  | The Maxfield Foundation supports projects with potential for high impact in
  | science, education, sustainability, and other areas of social importance.

about-foundations-rice =
  | As a leading research university with a distinctive commitment to
  | undergraduate education, Rice University aspires to pathbreaking research,
  | unsurpassed teaching, and contributions to the betterment of our world. It
  | seeks to fulfill this mission by cultivating a diverse community of
  | learning and discovery that produces leaders across the spectrum of human
  | endeavor.

about-foundations-ljaf =
  | Laura and John Arnold Foundation (LJAF) actively seeks opportunities to
  | invest in organizations and thought leaders that have a sincere interest in
  | implementing fundamental changes that not only yield immediate gains, but
  | also repair broken systems for future generations. LJAF currently focuses
  | its strategic investments on education, criminal justice, research integrity,
  | and public accountability.

about-foundations-20mm =
  | Our mission at the Twenty Million Minds Foundation is to grow access and
  | success by eliminating unnecessary hurdles to affordability. We support the
  | creation, sharing, and proliferation of more effective, more affordable
  | educational content by leveraging disruptive technologies, open educational
  | resources, and new models for collaboration between for-profit, nonprofit,
  | and public entities.

about-foundations-kazanjian =
  | Calvin K. Kazanjian was the founder and president of Peter Paul Inc., the
  | maker of the Mounds and Almond Joy candy bars, located in Naugatuck,
  | Connecticut. He firmly believed that if more people understood basic
  | economics the world would be a better place in which to live. Accordingly,
  | he established the Foundation in the true spirit of unselfish service. In
  | his own words, he wished to “help bring a greater happiness and prosperity
  | to all, through a better understanding of economics.” The Calvin K.
  | Kazanjian Economics Foundation Inc. is a non-political education
  | organization that was incorporated as a nonprofit organization under the
  | Statue Laws of the State of Connecticut on April 4, 1947.

about-foundations-sick =
  | The Bill and Stephanie Sick Fund supports innovative projects in the areas
  | of Education, Art, Science and Engineering.



### PEOPLE ###
# Link: http://cnx.org/about/people
# Content on the People page among the about pages.

# PEOPLE - People - src/scripts/pages/about/people/people-template.html

about-people-header = People

about-people-foundation-header = Foundation Support

about-people-foundation-content =
  | OpenStax College is grateful for the
  | tremendous support from our foundation sponsors. Without their
  | strong engagement of our mission,the goal of free access to
  | high-quality textbooks would remain elusive.

about-people-strategic-advisors = Strategic Advisors

about-people-team-header = The OpenStax College Team

about-people-team-content =
  | OpenStax College is brought to you by a
  | team of open education professionals dedicated to increasing global
  | access to high-quality learning materials for students and teachers.



### CONTACT ###
# Link: http://cnx.org/about/contact
# Content on the Contact page among the about pages.

# CONTACT - Content - src/scripts/pages/about/contact/contact-template.html

about-contact-google-maps = Google™ map

about-contact-header = Contact

about-contact-phone = Phone: { $phone }

about-contact-email = Email: <a href="mailto:{ $email }">{ $email }</a>

about-contact-questions-header = Questions?

about-contact-questions-content = Please feel free to e-mail us for more information.

about-contact-technical-support-header = Technical Support

about-contact-technical-support-content =
  | If you are encountering a technical problem with our site, please send an
  | email to <a href="mailto:techsupport@cnx.org">techsupport@cnx.org</a>.
  | You can also submit a bug report using our bug submission form.

about-contact-general-questions-header = General Questions

about-contact-general-questions-content =
  | If you have questions about the site, would like to schedule author
  | training, or have any other general questions regarding OpenStax CNX,
  | please send an email to <a href="mailto:cnx@cnx.org">cnx@cnx.org</a>.



### SEARCH ###
# Link: http://cnx.org/browse
# Content on the page with subject categories.

# SEARCH - Page Summary and Description - src/scripts/pages/search/search.coffee

search-pageTitle = Search in OpenStax CNX

search-page-summary = Search for textbooks

search-page-description = Search from thousands of free, online textbooks.

# SEARCH - Top bar - src/scripts/modules/find-content/find-content-template.html

search-find-content = Find Content

search-search = Search
  [html/placeholder]  Search

search-or = or

search-advanced-search = Advanced Search

# SEARCH - Content - src/scripts/pages/browse-content/browse-content-template.html

search-header = Welcome to the OpenStax CNX Library

search-content =
  | The content in OpenStax CNX comes in two formats:
  | <strong>modules</strong>, which are like small "knowledge chunks,"
  | and <strong>collections</strong>, which are groups of modules
  | structured into books or course notes, or for other uses. Our open
  | license allows for free use and reuse of all our content.

search-pages = Pages: { $count }

search-books = Books: { $count }



### ADVANCED SEARCH ###
# Link: http://cnx.org/search
# Content related to the advanced search form.

# ADVANCED SEARCH - Page Title - src/scripts/modules/search/advanced/advanced.coffee

advanced-search-pageTitle = Advanced Search

# ADVANCED SEARCH - Minimal Search Results Table Partial - src/scripts/modules/minimal/search/results/list/table-partial.html

minimal-search-results-table-partial-books = Books

minimal-search-results-table-partial-pages = Pages

minimal-search-results-table-partial-miscellaneous = Miscellaneous

# ADVANCED SEARCH - Advanced Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

advanced-search-minimal-pageTitle = Advanced Search

# ADVANCED SEARCH - Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

search-minimal-pageTitle = Advanced Search

# ADVANCED SEARCH - Content - src/scripts/modules/search/advanced/advanced-template.html

advanced-search-author = Author

advanced-search-title = Title

advanced-search-subject = Subject

advanced-search-subject-default-any = Any

advanced-search-subject-arts = Arts

advanced-search-subject-business = Business

advanced-search-subject-humanities = Humanities

advanced-search-subject-math = Mathematics and Statistics

advanced-search-subject-science = Science and Technology

advanced-search-subject-social-sciences = Social Sciences

advanced-search-keywords = Keywords

advanced-search-type = Type

advanced-search-type-default-any = Any

advanced-search-type-books = Books

advanced-search-type-pages = Pages

advanced-search-language = Language

advanced-search-language-default-any = Any

advanced-search-publication-date = Publication Date

advanced-search-publication-date-default-any = Any

advanced-search-sort = Sort By

advanced-search-sort-default-relevance = Relevance

advanced-search-sort-publication-date = Publication Date

advanced-search-sort-popularity = Popularity

advanced-search-submit = Submit

advanced-search-language-option = { $native } ({ $code ->
  [aa] Afar
  [ab] Abkhazian
  [af] Afrikaans
  [am] Amharic
  [ar] Arabic
  [as] Assamese
  [ay] Aymara
  [az] Azerbaijani
  [ba] Bashkir
  [be] Belarussian
  [bg] Bulgarian
  [bh] Bihari
  [bi] Bislama
  [bn] Bengali
  [bo] Tibetan
  [bs] Bosnian
  [br] Breton
  [ca] Catalan
  [ch] Chamorro
  [co] Corsican
  [cs] Czech
  [cy] Welsh
  [da] Danish
  [de] German
  [dz] Bhutani
  [el] Greek
 *[en] English
  [eo] Esperanto
  [es] Spanish
  [et] Estonian
  [eu] Basque
  [fa] Persian
  [fi] Finnish
  [fj] Fiji
  [fo] Faroese
  [fr] French
  [fy] Frisian
  [ga] Irish Gaelic
  [gd] Scottish Gaelic
  [gl] Galician
  [gn] Guarani
  [gu] Gujarati
  [gv] Manx Gaelic
  [ha] Hausa
  [he] Hebrew
  [hi] Hindi
  [hr] Croatian
  [hu] Hungarian
  [hy] Armenian
  [ia] Interlingua
  [id] Indonesian
  [ie] Interlingue
  [ik] Inupiak
  [is] Icelandic
  [it] Italian
  [iu] Inuktitut
  [ja] Japanese
  [jbo] Lojban
  [jw] Javanese
  [ka] Georgian
  [kk] Kazakh
  [kl] Greenlandic
  [km] Cambodian/Khmer
  [kn] Kannada
  [ko] Korean
  [ks] Kashmiri
  [ku] Kurdish
  [kw] Cornish
  [ky] Kyrgyz
  [la] Latin
  [lb] Luxemburgish
  [li] Limburgish
  [ln] Lingala
  [lo] Laotian
  [lt] Lithuanian
  [lv] Latvian
  [mg] Madagascarian
  [mi] Maori
  [mk] Macedonian
  [ml] Malayalam
  [mn] Mongolian
  [mo] Moldavian
  [mr] Marathi
  [ms] Malay
  [mt] Maltese
  [my] Burmese
  [na] Nauruan
  [ne] Nepali
  [nl] Dutch
  [no] Norwegian
  [nn] Norwegian Nynorsk
  [oc] Occitan
  [om] Oromo
  [or] Oriya
  [pa] Punjabi
  [pl] Polish
  [ps] Pashto
  [pt] Portuguese
  [qu] Quechua
  [rm] Rhaeto-Romance
  [rn] Kirundi
  [ro] Romanian
  [ru] Russian
  [rw] Kiyarwanda
  [sa] Sanskrit
  [sd] Sindhi
  [se] Northern Sámi
  [sg] Sangho
  [sh] Serbo-Croatian
  [si] Singhalese
  [sk] Slovak
  [sl] Slovenian
  [sm] Samoan
  [sn] Shona
  [so] Somali
  [sq] Albanian
  [sr] Serbian
  [ss] Siswati
  [st] Sesotho
  [su] Sudanese
  [sv] Swedish
  [sw] Swahili
  [ta] Tamil
  [te] Telugu
  [tg] Tadjik
  [th] Thai
  [ti] Tigrinya
  [tk] Turkmen
  [tl] Tagalog
  [tn] Setswana
  [to] Tongan
  [tr] Turkish
  [ts] Tsonga
  [tt] Tatar
  [tw] Twi
  [ug] Uigur
  [uk] Ukrainian
  [ur] Urdu
  [uz] Uzbek
  [vi] Vietnamese
  [vo] Volapük
  [wa] Walloon
  [wo] Wolof
  [xh] Xhosa
  [yi] Yiddish
  [yo] Yorouba
  [za] Zhuang
  [zh] Chinese
  [zu] Zulu
})



### SEARCH RESULTS ###
# Example link: http://cnx.org/search?q=subject:%22Business%22
# Content related to the displaying of search results and the filters on the
# search results page.

# SEARCH RESULTS - Page Title - src/scripts/modules/search/search.coffee

search-results-pageTitle = Search

# SEARCH RESULTS - Header - src/scripts/modules/search/header/header-template.html

search-results-search-results = Search Results

search-results-advanced-search = Advanced Search

search-results-tips-and-help = Search Tips &amp; Help

search-results-number-results = { PLURAL($counter) ->
  [0]   No results found
  [1]   <strong>{ $counter }</strong> result found
 *[other] <strong>{ $counter }</strong> results found
}

# SEARCH RESULTS - Filter - src/scripts/modules/search/results/filter/filter-template.html, src/scripts/models/search-results.coffee

search-results-filters = Filter

search-results-filter-moreless = { $ismore ->
 *[0] More
  [1] Less
}

search-results-filter-author = Author
search-results-filter-authorID = Author
search-results-filter-keyword = Keyword
search-results-filter-language = Language
search-results-filter-mediaType = Type
search-results-filter-type = Type
search-results-filter-pubYear = Publication Date
search-results-filter-subject = Subject
search-results-filter-title = Title
search-results-filter-text = Text

search-results-filter-book-page = { $displayval ->
  [Book] Book
  [Page] Page
  *[other] { $displayval }
}

# SEARCH RESULTS - Table - src/scripts/modules/search/results/list/table-partial.html

search-results-table-type = Type
search-results-table-title = Title
search-results-table-authors = Author(s)
search-results-table-edited = Edited

search-results-books = Books
search-results-pages = Pages
search-results-miscellaneous = Miscellaneous

# SEARCH RESULTS - Navigation - src/scripts/modules/search/results/list/pagination-partial.html

search-results-navigation-prev = Prev
search-results-navigation-next = Next

# SEARCH RESULTS - No Results - src/scripts/modules/search/results/list/list-template.html

search-results-list-search-taking-time =
  | The search seems to be taking a long time. The search engine may have the
  | results ready if you reload the page, or you can refine your search using
  | the Advanced Search button above.

search-results-list-no-results = No results found. Please try expanding your search.

search-results-list-loading = Loading

# SEARCH RESULTS - Item - src/scripts/modules/search/results/list/item-partial.html

search-results-item-edited = { DATETIME($date) }



### TEXTBOOK VIEW ###
# Example link: http://cnx.org/contents/02040312-72c8-441e-a685-20e9333f3e1d
# Content related to the display and viewing of textbooks.

# TEXTBOOK VIEW - Title - src/scripts/modules/media/title/title-template.html

textbook-view-btn-edit = Edit

textbook-view-btn-create = Create an Editable Copy

textbook-view-publishing = publishing { $title }

textbook-view-derived-from = Derived from <a href="{ $url }">{ $title }</a> by <span class="collection-authors">{ TAKE(50, $authors) }</span>

textbook-view-book-by =
  | Book by: <span class="collection-authors">{ TAKE(50, $authors) }</span>

textbook-view-page-by =
  | Page by: <span class="collection-authors">{ TAKE(50, $authors) }</span>

# TEXTBOOK VIEW - Downloads - src/scripts/modules/media/footer/downloads/downloads-template.html

textbook-view-downloads-header = Downloads

textbook-view-loading = Loading

textbook-view-loading-more-details-btn = More details

textbook-view-loading-less-details-btn = Less details

textbook-view-th-format = Format:

textbook-view-th-details = Details

textbook-view-th-file-name = File Name:

textbook-view-th-generated = Generated:

textbook-view-th-size = Size:

textbook-view-file-not-available = File not available

textbook-view-no-downloads = No downloads are available at this time.

textbook-view-file-description = { $format ->
  [PDF] PDF file, for viewing content offline and printing.
  [EPUB] Electronic book format file, for viewing on mobile devices.
  [Offline ZIP] An offline HTML copy of the content. Also includes XML, included media files, and other support files.
 *[other] { $format }
}

# TEXTBOOK VIEW - History - src/scripts/modules/media/footer/history/history-template.html

textbook-view-version-history-header = Version History

textbook-view-th-version = Version:

textbook-view-th-datetime = Date/Time:

textbook-view-th-changes = Changes:

textbook-view-th-publisher = Publisher:

# TEXTBOOK VIEW - Footer Tabs - src/scripts/modules/media/footer/footer-template.html

textbook-view-tab-downloads = Downloads

textbook-view-tab-history = History

textbook-view-tab-attribution = Attribution

textbook-view-tab-more-info = More Information

# TEXTBOOK VIEW - Navigation - src/scripts/modules/media/nav/nav-template.html

textbook-view-btn-back = Back

textbook-view-btn-back-to-top = Back to Top

textbook-view-btn-next = Next

textbook-view-search-this-book =
  [html/placeholder] Search this book

textbook-view-contents = Contents

# TEXTBOOK VIEW - Endorsement - src/scripts/modules/media/endorsed/endorsed-template.html

textbook-view-endorsed-by = Endorsed by: OpenStax College

# TEXTBOOK VIEW - Header - src/scripts/modules/media/header/header-template.html

textbook-view-btn-create-copy = Create an Editable Copy

textbook-view-btn-edit-page = Edit Page

textbook-view-btn-jump-to-concept-coach = Jump to Concept Coach

textbook-view-btn-get-this-book = Get This Book!

textbook-view-btn-get-this-page = Get This Page!

textbook-view-summary = Summary

textbook-view-header-publishing = <span class="label label-info">publishing</span> { $title }

textbook-view-header-publishing-chapter =
  | <span class="label label-info">publishing</span> <span class="title-chapter">{ $chapter }</span> { $title }

textbook-view-header-no-publishing = { $title }

textbook-view-header-no-publishing-chapter = <span class="title-chapter">{ $chapter }</span> { $title }

textbook-view-header-derived-from =
  | Derived from <a href="{ $url }">{ $title }</a> by <span class="book-authors">{ TAKE(50, $authors) }</span>

# TEXTBOOK VIEW - Metadata - src/scripts/modules/media/footer/metadata/metadata-template.html

textbook-view-dt-name = Name:

textbotok-view-dt-id = ID:

textbook-view-dt-language = Language:

textbook-view-dt-summary = Summary:

textbook-view-dt-subjects = Subjects:

textbook-view-dt-keywords = Keywords:

textbook-view-dt-print-style = Print Style:

textbook-view-dt-license = License:

textbook-view-dt-authors = Authors:

textbook-view-dt-copyright-holders = Copyright Holders:

textbook-view-dt-publishers = Publishers:

textbook-view-dt-latest-version = Latest Version:

textbook-view-dt-first-publication-date = First Publication Date:

textbook-view-dt-latest-revision = Latest Revision:

textbook-view-dt-last-edited-by = Last Edited By:

textbook-view-subject-name = { $name }

# TEXTBOOK VIEW - Attribution - src/scripts/modules/media/footer/attribution/attribution-template.html

textbook-view-textbook-attribute-header = How to Reuse &amp; Attribute This Content

textbook-view-textbook-content-produced =
  | Textbook content produced by <span>{ TAKE(50, $authors) }</span>
  | is licensed under a <a href="{ $url }">{ $title }</a> license.

textbook-view-attribution-p-1 =
  | Under this license, any user of this textbook or the textbook contents herein must provide proper attribution
  | as follows:

textbook-view-attribution-p-2-strong =
  | The OpenStax College name, OpenStax College logo, OpenStax College book covers,
  | OpenStax CNX name, and OpenStax CNX logo are not subject to the creative commons license
  | and may not be reproduced without the prior and express written consent of Rice University.

textbook-view-attribution-p-2-span =
  | For questions regarding this license, please contact <a href="{ $url }">{ $title }</a>.

textbook-view-attribution-li-1 =
  | If you use this textbook as a bibliographic reference, then you should cite it as follows:

textbook-view-attribution-li-2-title =
  | If you redistribute this textbook in a print format,
  | then you must include on every physical page the following attribution:

textbook-view-attribution-li-2-attribution = "Download for free at { $url }."

textbook-view-attribution-li-3-title =
  | If you redistribute part of this textbook, then you must retain in every
  | digital format page view (including but not limited to EPUB, PDF, and HTML)
  | and on every physical printed page the following attribution:

textbook-view-attribution-li-3-attribution = "Download for free at { $url }."

# TEXTBOOK VIEW - Get Book Drop Down - src/scripts/modules/media/header/popovers/book/book-template.html

textbook-view-book-download-image =
  [html/alt]  Download

textbook-view-book-get-this-book = Get This Book

textbook-view-book-download-book = Download Book:

textbook-view-book-download-page = Download Page:

textbook-view-book-order-book = Order Printed Book

# TEXTBOOK VIEW - Footer Toggle - src/scripts/modules/media/footer/inherits/tab/toggle-partial.html

textbook-view-book-button = Book

textbook-view-page-button = Page

# TEXTBOOK VIEW - Footer license - src/scripts/modules/media/footer/license/license-template.html

textbook-view-license = This work is licensed { LEN($licensors) ->
    [0]
   *[other] by { $licensors }
  }{ LEN($name) ->
    [0]
   *[other] under a <a href="{ $url }">{ $name } ({ $code } { $version })</a>
  }.

# TEXTBOOK VIEW - Table of Content Search - src/scripts/modules/media/tabs/contents/toc/page-template.html

textbook-view-toc-page-changed = changed

textbook-view-toc-page-match-count = { $count ->
  [1] { $count } match
 *[other] { $count } matches
}



### MY WORKSPACE ###
# Content related to the user starting the creation of a new textbook or viewing
# the current books in their workspace.

# MY WORKSPACE - Header and Buttons - src/scripts/modules/workspace/workspace-template.html

workspace-header = My Workspace

workspace-button-new = New

workspace-button-recently-published = Recently Published

# MY WORKSPACE - Empty Workspace Message - src/scripts/modules/workspace/results/list/list-template.html

workspace-empty-workspace-msg = Empty Workspace. You can add new content or find content and Create a Copy for editing.

# MY WORKSPACE - Delete - src/scripts/modules/workspace/popovers/new/new-template.html

workspace-delete-close = Close

workspace-delete-confirm = Confirm

workspace-delete-are-you-sure = Are you sure you want to delete { $title }?

workspace-delete-close-2 = Close

workspace-delete-OK = OK

# MY WORKSPACE - Popover - src/scripts/modules/workspace/popovers/new/modals/new-media-template.html

workspace-popover-create-new = Create New

workspace-popover-title-label = Title

workspace-popover-title-input =
  [html/placeholder]  Title

workspace-popover-cancel-button = Cancel

workspace-popover-create-new-button = Create New

# MY WORKSPACE - Page Title, Summary, Description - src/scripts/pages/workspace/workspace.coffee

workspace-pageTitle = My Workspace

workspace-summary = Add new content or find content and derive a copy for editing.

workspace-description = Create free educational content, or derive a copy for editing.

# MY WORKSPACE - New Popover - src/scripts/modules/workspace/popovers/new/new-template.html

workspace-new-popover-book = Book

workspace-new-popover-page = Page

# MY WORKSPACE - Table Titles - src/scripts/modules/workspace/results/list/workspace-table-partial.html

workspace-table-type = Type
workspace-table-title = Title
workspace-table-status = Status
workspace-table-edited = Edited
workspace-table-delete = Delete

# MY WORKSPACE - Number of Items  - src/scripts/modules/workspace/header/header-template.html

workspace-results-plural = { $items ->
  [0] <strong>No items</strong>
  [1] <strong>1</strong> item
 *[other] <strong>{ $counter }</strong> items
}



### TEXTBOOK EDITOR ###
# Content related to editor that enables the creation and editing of textbooks.

# TEXTBOOK EDITOR - Editbar Styling - src/scripts/modules/media/editbar/editbar-template.html

textbook-editor-toggle-navigation = Toggle navigation

textbook-editor-edit = Edit

textbook-editor-normal-text-button = Normal Text

textbook-editor-normal-text = Normal Text

textbook-editor-h1 = Heading 1
textbook-editor-h2 = Heading 2
textbook-editor-h3 = Heading 3

textbook-editor-code = Code

textbook-editor-bold =
  [html/title] Bold
textbook-editor-italic =
  [html/title] Italics
textbook-editor-underline =
  [html/title] Underline
textbook-editor-superscript =
  [html/title] Superscript
textbook-editor-subscript =
  [html/title] Subscript

textbook-editor-add-row-before = Add Row Before
textbook-editor-add-row-after = Add Row After
textbook-editor-add-column-before = Add Column Before
textbook-editor-add-column-after = Add Column After
textbook-editor-add-header-row = Add Header Row
textbook-editor-delete-row = Delete Row
textbook-editor-delete-column = Delete Column
textbook-editor-delete-table = Delete Table

textbook-editor-paste-button =
  [html/data-content] Content was copied to the clipboard. Click this button to paste the content into the page.

textbook-editor-save-draft = Save Draft

textbook-editor-publish-button = Publish...

textbook-editor-drag-to-add = Drag to add a new...

# TEXTBOOK EDITOR - Tabs Add Page - src/scripts/modules/media/tabs/contents/popovers/add/modals/add-page-template.html

textbook-editor-add-page-header = Add Page(s)

textbook-editor-add-page-show-draft = Show Draft Pages

textbook-editor-add-page-title-label = Title

textbook-editor-add-page-title-input =
  [html/placeholder] Title

textbook-editor-add-page-search-button = Search

textbook-editor-add-page-cancel-button = Cancel

textbook-editor-add-page-create-new-page-button = Create New Page

# TEXTBOOK EDITOR - Create New Dropdown Menu - src/scripts/modules/media/tabs/contents/popovers/add/add-template.html

textbook-editor-menu-page = Page

textbook-editor-menu-section = Section

# TEXTBOOK EDITOR - Popup Section Name - src/scripts/modules/media/tabs/contents/toc/modals/section-name/section-name-template.html

textbook-editor-section-edit-header = Edit Section Name

textbook-editor-section-title-label = Title

textbook-editor-section-title-input =
  [html/placeholder]  Title

textbook-editor-section-ok-button = Ok

textbook-editor-section-cancel-button = Cancel

# TEXTBOOK EDITOR - Table of Contents Search - src/scripts/modules/media/tabs/contents/contents-template.html

textbook-editor-contents-add-button = Add

textbook-editor-contents-back-to-table = Back to Table of Contents

textbook-editor-contents-results-matches = { $hits ->
  [0] No matching results were found.
  [1] { $hits } page matched
 *[other] { $hits } pages matched
}

# TEXTBOOK EDITOR - Add Page List - src/scripts/modules/media/tabs/contents/popovers/add/modals/results/list/add-page-list-template.html

textbook-editor-add-page-list-no-results = No results found. Please try expanding your search.

textbook-editor-add-page-list-loading = Loading

# TEXTBOOK EDITOR - Tools - src/scripts/modules/media/tabs/tools/tools-template.html

textbook-editor-tools-edit = Edit

textbook-editor-tools-preview = Preview

textbook-editor-tools-make-editable-copy = Make an Editable Copy

textbook-editor-tools-teachers-edition = Teacher's Edition

textbook-editor-tools-standard-edition = Standard Edition


# TEXTBOOK EDITOR - Content & Tools - src/scripts/modules/media/tabs/tabs-template.html

textbook-editor-template-contents = Contents

textbook-editor-template-tools = Tools



### DONATE ###
# Links: http://cnx.org/donate, http://cnx.org/donate/form
# Content related to people donating money

# DONATE - Page Title and Description - src/scripts/pages/donate/donate.coffee

donate-pageTitle = Support OpenStax CNX

donate-summary = Donate to OpenStax CNX

donate-description = Donate to OpenStax CNX

# DONATE - Header and Content - src/scripts/pages/donate/default/default-template.html

donate-header = Support OpenStax CNX

donate-subheader = Your donation makes a difference

donate-content =
  | Your donation helps keep OpenStax CNX's rapidly growing repository of
  | educational materials vibrant, free, and available to educators and
  | learners all over the world.

donate-donation-handle-message =
  | Your donation is securely handled by Rice University and
  | <a href="http://www.touchnet.com/">Touchnet</a>.

# DONATE - Slider - src/scripts/pages/donate/donation-slider/donation-slider.coffee, src/scripts/pages/donate/donation-slider/donation-slider-template.html

donate-slider-0 = Free makes me happy
donate-slider-5 = Abe Lincoln would be proud
donate-slider-10 = OpenStax CNX is a ten in my book (suggested donation)
donate-slider-15 = Thanks for saving me hundreds of dollars!
donate-slider-20 = My ATM wants you to have this
donate-slider-25 = Abe Lincoln would be proud (and amazed by ATMs)
donate-slider-50 = Hey OpenStax, give a printed copy to a school in need
donate-slider-75 = Here's something to help keep these books free!
donate-slider-100 = Giving back never felt so good
donate-slider-250 = On me: fill a school library with your books!
donate-slider-500 = Go buy yourself a fancy new translation!
donate-slider-1000 = The next section of an OpenStax book is on me!
donate-slider-2500 = The next chapter of an OpenStax book is on me!
donate-slider-5000 = Bill Gates II, at your service
donate-slider-10000 = WOWWWWWW!!!!

donate-slider-amount = { $amount ->
  [0] $0
  [5] $5
  *[10] $10
  [15] $15
  [20] $20
  [25] $25
  [50] $50
  [75] $75
  [100] $100
  [250] $250
  [500] $500
  [1000] $1,000
  [2500] $2,500
  [5000] $5,000
  [10000] $10,000
}

donate-donate-now-button = Donate Now

donation-download-for-free = Download for Free

# DONATE - Form - src/scripts/pages/donate/form/form-template.html

donate-form-support-cnx = Support OpenStax CNX

donate-form-header-message = Your donation makes a difference

donate-form-content =
  | Your donation helps keep OpenStax CNX's rapidly growing repository of
  | educational materials vibrant, free, and available to educators and
  | learners all over the world.

donate-form-prompt =
  | Please enter your donor information and click "Continue" to be taken to
  | the secure payment site.

donate-form-title = Title

donate-form-first-name = First Name

donate-form-last-name = Last Name

donate-form-suffix = Suffix

donate-form-email = E-Mail

donate-form-address = Address

donate-form-city = City

donate-form-state = State

donate-form-zip-code = Zip Code

donate-form-country = Country

donate-form-donation = Donation

donate-form-continue = Continue

donate-form-titles =
  | <option value="">Dr.</option>
  | <option value="pubDate">Mr.</option>
  | <option value="popularity">Mrs.</option>
  | <option value="popularity">Ms.</option>

donate-form-states = { $statecode ->
  [TX]  Texas
  [AL]  Alabama
  [AK]  Alaska
  [AZ]  Arizona
  [AR]  Arkansas
  [CA]  California
  [CO]  Colorado
  [CT]  Connecticut
  [DE]  Delaware
  [FL]  Florida
  [GA]  Georgia
  [HI]  Hawaii
  [ID]  Idaho
  [IL]  Illinois
  [IN]  Indiana
  [IA]  Iowa
  [KS]  Kansas
  [KY]  Kentucky
  [LA]  Louisiana
  [ME]  Maine
  [MD]  Maryland
  [MA]  Massachusetts
  [MI]  Michigan
  [MN]  Minnesota
  [MO]  Missouri
  [MS]  Mississippi
  [MT]  Montana
  [NE]  Nebraska
  [NV]  Nevada
  [NH]  New Hampshire
  [NJ]  New Jersey
  [NM]  New Mexico
  [NY]  New York
  [NC]  North Carolina
  [ND]  North Dakota
  [OH]  Ohio
  [OK]  Oklahoma
  [OR]  Oregon
  [PA]  Pennsylvania
  [RI]  Rhode Island
  [SC]  South Carolina
  [SD]  South Dakota
  [TN]  Tennessee
  [UT]  Utah
  [VT]  Vermont
  [VA]  Virginia
  [WA]  Washington
  [WV]  West Virginia
  [WI]  Wisconsin
  [WY]  Wyoming
  [AS]  American Samoa
  [DC]  District of Columbia
  [FM]  Federated States of Micronesia
  [GU]  Guam
  [MP]  Northern Mariana Islands
  [PW]  Palau
  [PR]  Puerto Rico
  [VI]  Virgin Islands
  [AA]  Armed Forces Americas
  [AE]  Armed Forces Europe
  [AP]  Armed Forces Pacific
  [AB]  Alberta
  [BC]  British Columbia
  [MB]  Manitoba
  [NB]  New Brunswick
  [NF]  Newfoundland
  [NT]  Northwest Territories
  [NS]  Nova Scotia
  [ON]  Ontario
  [PE]  Prince Edward Island
  [PQ]  Province du Quebec
  [SK]  Saskatchewan
  [YT]  Yukon Territory
  [ZZ]  Not Applicable
}

# Make sure to translate the final option, "Not Applicable".
donate-form-countries = { $countrycode ->
  [US]  United States
  [CA]  Canada
  [AF]  Afghanistan
  [AX]  Aland Islands
  [AL]  Albania
  [DZ]  Algeria
  [AS]  American Samoa
  [AD]  Andorra
  [AO]  Angola
  [AI]  Anguilla
  [AQ]  Antarctica
  [AG]  Antigua and Barbuda
  [AR]  Argentina
  [AM]  Armenia
  [AW]  Aruba
  [AU]  Australia
  [AT]  Austria
  [AZ]  Azerbaijan
  [BS]  Bahamas
  [BH]  Bahrain
  [BD]  Bangladesh
  [BB]  Barbados
  [BY]  Belarus
  [BE]  Belgium
  [BZ]  Belize
  [BJ]  Benin
  [BM]  Bermuda
  [BT]  Bhutan
  [BO]  Bolivia
  [BA]  Bosnia and Herzegovina
  [BW]  Botswana
  [BV]  Bouvet Island
  [BR]  Brazil
  [IO]  British Indian Ocean Territory
  [BN]  Brunei Darussalam
  [BG]  Bulgaria
  [BF]  Burkina Faso
  [BI]  Burundi
  [KH]  Cambodia
  [CM]  Cameroon
  [CV]  Cape Verde
  [KY]  Cayman Islands
  [CF]  Central African Republic
  [TD]  Chad
  [CL]  Chile
  [CN]  China
  [CX]  Christmas Island
  [CC]  Cocos (Keeling) Islands
  [CO]  Columbia
  [KM]  Comoros
  [CG]  Congo
  [CD]  Congo - The Democratic Republic of the
  [CK]  Cook Islands
  [CR]  Costa Rica
  [HR]  Croatia
  [CU]  Cuba
  [CY]  Cyprus
  [CZ]  Czech Republic
  [DK]  Denmark
  [DJ]  Djibouti
  [DM]  Dominica
  [DO]  Dominican Republic
  [EC]  Ecuador
  [EG]  Egypt
  [SV]  El Salvador
  [GQ]  Equatorial Guinea
  [ER]  Eritrea
  [EE]  Estonia
  [ET]  Ethiopia
  [FK]  Falkland Islands (Malvinas)
  [FO]  Faroe Islands
  [FJ]  Fiji
  [FI]  Finland
  [FR]  France
  [GF]  French Guiana
  [PF]  French Polynesia
  [TF]  French Southern Territories
  [GA]  Gabon
  [GM]  Gambia
  [GE]  Georgia
  [DE]  Germany
  [GH]  Ghana
  [GI]  Gibraltar
  [GR]  Greece
  [GL]  Greenland
  [GD]  Grenada
  [GP]  Guadeloupe
  [GU]  Guam
  [GT]  Guatemala
  [GG]  Guernsey
  [GN]  Guinea
  [GW]  Guinea-Bissau
  [GY]  Guyana
  [HT]  Haiti
  [HM]  Heard Island and McDonald Islands
  [VA]  Holy See (Vatican City State)
  [HN]  Honduras
  [HK]  Hong Kong
  [HU]  Hungary
  [IS]  Iceland
  [IN]  India
  [ID]  Indonesia
  [IR]  Iran - Islamic Republic of
  [IQ]  Iraq
  [IE]  Ireland
  [IM]  Isle of Man
  [IL]  Israel
  [IT]  Italy
  [JM]  Jamaica
  [JP]  Japan
  [JE]  Jersey
  [JO]  Jordan
  [KZ]  Kazakhstan
  [KE]  Kenya
  [KI]  Kiribati
  [KP]  Korea - Democratic Peoples Republic of
  [KR]  Korea - Republic of
  [KW]  Kuwait
  [KG]  Kyrgyzstan
  [LA]  Lao Peoples Democratic Republic
  [LV]  Latvia
  [LB]  Lebanon
  [LS]  Lesotho
  [LR]  Liberia
  [LY]  Libyan Arab Jamahiriya
  [LI]  Liechtenstein
  [LT]  Lithuania
  [LU]  Lexembourg
  [MO]  Macao
  [MK]  Macedonia - The Former Yugoslav Republic of
  [MG]  Madagascar
  [MW]  Malawi
  [MY]  Malaysia
  [MV]  Maldives
  [ML]  Mali
  [MT]  Malta
  [MH]  Marshall Islands
  [MQ]  Martinique
  [MR]  Mauritania
  [MU]  Mauritius
  [YT]  Mayotte
  [MX]  Mexico
  [FM]  Micronesia - Federated States of
  [MD]  Moldova
  [MC]  Monaco
  [MN]  Mongolia
  [ME]  Montenegro
  [MS]  Montserrat
  [MA]  Morocco
  [MZ]  Mozambique
  [MM]  Myanmar
  [NA]  Namibia
  [NR]  Nauru
  [NP]  Nepal
  [NL]  Netherlands
  [AN]  Netherlands Antilles
  [NC]  New Caledonia
  [NZ]  New Zealand
  [NI]  Nicaragua
  [NE]  Niger
  [NG]  Nigeria
  [NU]  Niue
  [NF]  Norfolk Island
  [MP]  Northern Mariana Islands
  [NO]  Norway
  [OM]  Oman
  [PK]  Pakistan
  [PW]  Palau
  [PS]  Palestinian Territory - Occupied
  [PA]  Panama
  [PG]  Papua New Guinea
  [PY]  Paraguay
  [PE]  Peru
  [PH]  Philippines
  [PN]  Pitcairn
  [PL]  Poland
  [PT]  Portugal
  [PR]  Puerto Rico
  [QA]  Qatar
  [RE]  Reunion
  [RO]  Romania
  [RU]  Russian Federation
  [RW]  Rwanda
  [BL]  Saint Barthelemy
  [SH]  Saint Helena
  [KN]  Saint Kitts and Nevis
  [LC]  Saint Lucia
  [MF]  Saint Martin
  [PM]  Saint Pierre and Miquelon
  [VC]  Saint Vincent and the Grenadines
  [WS]  Samoa
  [SM]  San Marino
  [ST]  Sao Tome and Principe
  [SA]  Saudi Arabia
  [SN]  Senegal
  [RS]  Serbia
  [SC]  Seychelles
  [SL]  Sierra Leone
  [SG]  Singapore
  [SK]  Slovakia
  [SI]  Slovenia
  [SB]  Solomon Islands
  [SO]  Somalia
  [ZA]  South Africa
  [GS]  South Georgia and the South Sandwich Islands
  [ES]  Spain
  [LK]  Sri Lanka
  [SD]  Sudan
  [SR]  Suriname
  [SJ]  Svalbard and Jan Mayen
  [SZ]  Swaziland
  [SE]  Sweden
  [CH]  Switzerland
  [SY]  Syrian Arab Republic
  [TW]  Taiwan - Province of China
  [TJ]  Tajikistan
  [TZ]  Tanzania - United Republic of
  [TH]  Thailand
  [TL]  Timor-Leste
  [TG]  Togo
  [TK]  Tokelau
  [TO]  Tonga
  [TT]  Trinidad and Tobago
  [TN]  Tunisia
  [TR]  Turkey
  [TM]  Turkmenistan
  [TC]  Turks and Caicos Islands
  [TV]  Tuvalu
  [UG]  Uganda
  [UA]  Ukraine
  [AE]  United Arab Emirates
  [GB]  United Kingdom
  [UM]  United States Minor Outlying Islands
  [UY]  Uruguay
  [UZ]  Uzbekistan
  [VU]  Vanuatu
  [VE]  Venezuela
  [VN]  Viet Nam
  [VG]  Virgin Islands - British
  [VI]  Virgin Islands - U.S.
  [WF]  Wallis and Futuna
  [EH]  Western Sahara
  [YE]  Yemen
  [ZM]  Zambia
  [ZW]  Zimbabwe
}

donate-form-currency-symbol = $

donate-form-donation-decimal = .00

# DONATE - Download Page - src/scripts/pages/donate/download/download-template.html

donate-download-header = Download

donate-download-support-header = Support OpenStax CNX

donate-download-support-content =
  | Want to help us continue to give away millions of dollars of resources for
  | free? Help us keep the project going by making a donation!

donate-download-donation-handled =
  | Your donation is securely handled by Rice University and
  | <a href="http://www.touchnet.com/">Touchnet</a>.

# DONATE - Thank You - src/scripts/pages/donate/thankyou/thankyou-template.html

donate-thank-you-thank-you-header = Thank You!

donate-thank-you-download-title = Download { $title }

donate-thank-you-download-message =
  | Your download should start automatically. If it doesn't, click the download
  | button below.

donate-thank-you-download-button = Download

donate-thank-you-thank-you-for-generosity = Thank you for your generosity

donate-thank-you-appreciation-message =
  | Your donation helps keep OpenStax CNX's rapidly growing repository of
  | educational materials vibrant, free, and available to educators and
  | learners all over the world. Here is the information you provided.



### TERMS OF SERVICE ###
# Link: http://cnx.org/tos
# Content of the Terms of Service page.

# TERMS OF SERVICE - Page Title - src/scripts/pages/tos/tos.coffee

terms-of-service-pageTitle = Terms of Service - OpenStax CNX

terms-of-service-summary = OpenStax CNX Terms of Service

terms-of-service-description = OpenStax CNX Terms of Service

# TERMS OF SERVICE - Content - src/scripts/pages/tos/tos-template.html



### LICENSING ###
# Link: http://cnx.org/license
# Content of the Licensing page.

# LICENSING - Page Title - src/scripts/pages/license/license.coffee

licensing-pageTitle = License FAQ - OpenStax CNX

licensing-summary = OpenStax CNX License

licensing-description = OpenStax CNX License Frequently Asked Questions

licensing-title = Legal

licensing-document-description = Frequently asked IP (Intellectual Property) and legal questions

licensing-question-1 = Why do I have to agree to your license before I can publish my work?

licensing-answer-1 =
  | <p>Our goal is to provide and maintain a commons where individuals and communities
  | worldwide can create and freely share knowledge. The <a href="http://creativecommons.org/">Creative Commons</a>
  | <a href="http://creativecommons.org/licenses/by/4.0/">Attribution license</a>
  | that you and every author must agree to enables the content to be as
  | reusable as possible. All the content is accessible to anyone without
  | restriction and any author can use that content, share it with others,
  | or create a derivative work that is customized and personalized for their
  | context.</p>
  | <p>The license also reduces everyone's risk, because it clarifies what the
  | legal uses of the materials are. Without a license, everyone is forced
  | to assume that the full protection of copyright law applies to your work,
  | even if you intend to share it, or wanted it to be in the public domain.
  | The license makes clear to lawyers and to other readers that this is
  | your intention.</p>

licensing-question-2 =
  | Why should I make my work available under a Creative Commons Attribution license, instead of publishing
  | it with the full protection of copyright law?

licensing-answer-2 =
  | There are several reasons. You might like the idea of others building upon
  | your work, or the notion of contributing to an intellectual commons.
  | As the community grows, you and other authors will have the satisfaction
  | of helping develop new ways to collaborate. Another reason is that you
  | may want your writings to be copied and shared, so your ideas can spread
  | around the world. A young author may want to encourage the unrestrained
  | dissemination of his or her works to help build a reputation. An established
  | author might post samples of his or her work to create an interest in
  | works that are outside of our repository. The Creative Commons license
  | can help you implement such strategies while you retain the ultimate
  | control of your copyright.

licensing-question-3 = What is Creative Commons?

licensing-answer-3 =
  | Creative Commons is a non-profit corporation that promotes the creative
  | licensing and re-using of intellectual works. To quote from their Web
  | site: “Creative Commons is a new system, built within current copyright
  | law, that allows you to share your creations with others and use music,
  | movies, images, and text online that’s been marked with a Creative Commons
  | license.”

licensing-question-4 = Is the content copyrighted and who owns the copyright?

licensing-answer-4 =
  | All material is copyrighted and the author retains the copyright of his
  | or her material. The material is also licensed under the Creative Commons
  | Attribution license. Under this license the author gives others the freedom
  | to copy, distribute, and display the work, and to make derivative works,
  | as long as they give the original author credit. A link to a description
  | of the Creative Commons Attribution license appears at the bottom of
  | every content page.

licensing-question-5 = How do authors license their work in the content commons?

licensing-answer-5 =
  | Before you can create a module or collection, you must agree to the Creative
  | Content Attribution license that applies to all the content.

licensing-question-6 = Can I distribute or use my material elsewhere?

licensing-answer-6 =
  | Yes. The Creative Commons license is "non-exclusive"-- which means that
  | you are free to distribute your material under a different license elsewhere,
  | publish it for profit, or transform it without endangering the version
  | in our repository.

licensing-question-7 = How do I control what changes are made to my modules?

licensing-answer-7 =
  | Only persons who have the maintainer role on your module have permission
  | to modify and publish an updated version of your module. As the author
  | of a module, you determine who has the maintainer role on your module.
  | The Creative Commons Attribution license does allow another person to
  | make an <a href="../authoring/expressedit">adaptation</a> of any content
  | published in our repository. An adaptation is a derived copy of a module
  | that is modified and published as a new module under the new author's
  | name. Your original module is not changed and the adaptation contains
  | a statement of attribution to you and a link to your original module.

licensing-question-8 =
  | But wait, I thought the license gave people the right to make their
  | own adaptations of my work?

licensing-answer-8 =
  | True, another author can indeed make an adaptation of your work according
  | to the license. However, if you determine that someone has created an
  | adaptation that is incorrect, or contradictory with your own, or worse,
  | is defamatory or otherwise offensive, the license gives you the legal
  | right to ask that person to remove your name from the module -- but not
  | to demand that he or she change it as you wish. One way to avoid creation
  | of such adaptations is to invite these other authors into your workgroup
  | and develop a dialog with them as collaborators or co-authors.

licensing-question-9 =
  | What prevents some dishonest person from stealing my works and claiming it as theirs?

licensing-answer-9 =
  | Nothing except the copyright law. The Creative Commons license is based
  | on existing copyright law and your works have the same legal protections
  | and legal standing as a copyrighted work that is published outside of
  | our repository. You may actually run less risk using our repository than
  | simply putting your work on your own Web page, because the license is
  | clearly visible and clearly explains the uses people may legally make
  | of your work. Strictly speaking, fraud and plagiarism are not the subject
  | of copyright law, but copyright law is a good first defense.

licensing-question-10 = Can people make money off of my work?

licensing-answer-10 =
  | It is possible, but to be effective at all the license we use must allow
  | some "commercial" uses. Consider the situation in which a printing service,
  | such as FedEx Kinko's℠, offers to print your work so that your students
  | may have access to hard copies. Without a license that allows commercial
  | use, the service could not charge a fee to recover their printing, binding,
  | and handling costs.

licensing-question-11 = That's fine, but what if some huge publisher decides to publish my work?

licensing-answer-11 =
  | If a publisher wants to include your module in a book of collected materials,
  | they have that right according to the license, but remember that they
  | are required to list you as the author and copyright holder. Our experience
  | also suggests that most reputable publishers would want to re-negotiate
  | a new license with you in that case. Furthermore, if you seriously expect
  | to receive royalties from what you write, our repository is probably
  | not the right place for the work -- though it might be the right place
  | to experiment with an early version, or an alternative version.

licensing-question-12 = Does the Creative Commons Attribution license affect fair use rights?

licensing-answer-12 =
  | No. The license includes the statement: "Nothing in this license is intended
  | to reduce, limit, or restrict any rights arising from fair use, first
  | sale, or other limitations on the exclusive rights of the copyright owner
  | under copyright law or other applicable laws." Fair use, the first sale
  | doctrine, and other such limitations apply whether a copyright holder
  | consents to them or not.

licensing-question-13 =
  | What must I do if I want to include a portion of an author’s work in the
  | repository in a work I am creating outside of the repository?

licensing-answer-13 =
  | You must give attribution to the portion of the original author’s work
  | that you include outside of our repository. This attribution is as simple
  | as clearly naming the original author and identifying the portion of
  | his or her work you are using. In addition you must retain the copyright
  | notice and provide the URI of the original work.

licensing-question-14 =
  | What must I do if I want to include another author’s module in a collection
  | that I am building?

licensing-answer-14 =
  | Simply add the module to your collection with the Collection Composer tool.
  | Our software automatically includes the name of the original author in
  | your collection, giving him or her the attribution that is required by
  | the Creative Commons license.

licensing-question-15 =
  | Can I include material in my modules that was originally published outside
  | of the repository and copyrighted?

licensing-answer-15 =
  | This simple question raises some complex legal points. It can best be answered
  | by the copyright holder or an intellectual property attorney. We can
  | tell you that any content you put into our repository is licensed under
  | the Creative Commons Attribution 4.0 License, which means anything you
  | use directly in your content must to be legally publishable under that
  | license. The University of Texas System has a <a href="http://copyright.lib.utexas.edu/">Copyright Crash Course</a>
  | and a <a href="http://copyright.lib.utexas.edu/copypol2.html">Copyright Tutorial</a>
  | that can provide you with general information about copyright and reuse
  | of copyrighted material. If you do obtain permission to use copyrighted
  | material in your modules, we recommend that you include a note with the
  | material that indicates who holds the copyright on the material.

licensing-question-16 = Does "fair use" enable me to use copyrighted material in my modules?

licensing-answer-16 =
  | Maybe yes, maybe no. There are many factors to consider before you can
  | claim "fair use" for your reuse of copyrighted material. This is another
  | question that can best be answered by the copyright holder or an intellectual
  | property attorney.

licensing-question-17 =
  | What legal standing does the Creative Commons license have outside of the United States?

licensing-answer-17 =
  | The Creative Commons license was crafted to be enforceable in as many jurisdictions
  | as possible. That said, Creative Commons cannot account for every last
  | nuance in the world's various copyright laws, at their current level
  | of resources. The Creative Commons license does contain "severability"
  | clauses -- meaning that, if a certain provision is found to be unenforceable
  | in a certain place, that provision and only that provision drops out
  | of the license, leaving the rest of the agreement intact.

# LICENSING - Content - src/scripts/pages/license/license-template.html



### ROLE ACCEPTANCES ###
# Content of the Role Acceptances page.

# ROLE ACCEPTANCES - Title - src/scripts/modules/role-acceptances/role-acceptances.coffee, src/scripts/pages/role-acceptance/role-acceptance.coffee

role-acceptances-pageTitle = Role Acceptance

# ROLE ACCEPTANCES - Content - src/scripts/modules/role-acceptances/role-acceptances-template.html

role-acceptances-title = Title:

role-acceptances-role = Role

role-acceptances-requester = Requester

role-acceptances-assignment-date = Assignment Date

role-acceptances-license-i-license =
  | I license this work under the <a href="{ $url }">Creative Commons Attribution License (CC-BY).</a>

role-acceptances-license-understand = I understand

role-acceptances-license-retain-copyright = I retain the copyright of my work

role-acceptances-license-warrant =
  | I warrant that I am the author or have permission to distribute the work
  | in question

role-acceptances-license-wish =
  | I wish to have this distributed under the terms of the CC-BY license
  | (<strong>including allowing modification of this work and requiring
  | attribution</strong>)

role-acceptances-license-agree =
  | I agree that proper attribution of my work is any attribution that
  | includes the authors' names, the title of the work and the OpenStax CNX
  | URL to the work

role-acceptances-success-alert =
  | <strong>Success.</strong> Your new role settings have been saved.



### OTHER CONTENT ###
# Content that does not yet fit into any particular category. Instead organized
# only by file location,

# OTHER CONTENT - Modal Processing - src/scripts/modules/media/body/processing-instructions/modals/processing-instructions-template.html

modal-add-processing = Add Processing Instructions

modal-cancel = Cancel

modal-insert = Insert

# OTHER CONTENT - Media Body - src/scripts/modules/media/body/body-template.html

media-loading = Loading

# OTHER CONTENT - Editbar Block Publish - src/scripts/modules/media/editbar/block-publish/modals/block-publish-template.html

media-editbar-title-cannot-publish = You Cannot Publish

media-editbar-body-cannot-publish = You cannot publish because of the following reasons:

media-editbar-okay-button = OK

# OTHER CONTENT - Editbar License Template - src/scripts/modules/media/editbar/license/modals/license-template.html

media-editbar-header-change-license = Change License for { $title }

media-editbar-license-note =
  | <em><strong>NOTE</strong></em> - This license change affects the book and
  | all currently unpublished pages within the book.

media-editbar-license-cancel = Cancel

media-editbar-button-change-license = Change License

# OTHER CONTENT - Editbar Section Template - src/scripts/modules/media/editbar/modals/list/section-template.html

media-editbar-list-publishing = publishing

# OTHER CONTENT - Publish Template - src/scripts/modules/media/editbar/modals/publish-template.html

media-publish-template-license-agreement = I license this work under the

media-publish-template-publish = Publish

media-publish-template-previously = (previously <a href="{ $url }">{ $licensename } {$licenseversion }.</a>)

media-publish-template-understand = I understand:

media-publish-template-understand-li-1 = I retain the copyright of my work
media-publish-template-understand-li-2 =
  | I warrant that I am the author or have permission to distribute the work in question
media-publish-template-understand-li-3 =
  | I wish to have this distributed under the terms of the "{ $code }" license
  | (<strong>including allowing modification of this work and requiring attribution<strong>)
media-publish-template-understand-li-4 =
  | I agree that proper attribution of my work is any attribution that includes the authors' names,
  | the title of the work and the OpenStax CNX URL to the work

media-publish-template-textarea-description =
  [html/placeholder] Include a description of your changes (required)

media-publish-template-items-to-publish = Items to Publish

media-publish-template-cancel-button = Cancel

media-publish-template-publish-button = Publish

# OTHER CONTENT - Media Latest Template - src/scripts/modules/media/latest/latest-template.html

media-latest-content = A <a href="{ $url }">newer version</a> of this { $type } is now available.

# OTHER CONTENTS - Minimal Search Results Table Partial - src/scripts/modules/minimal/search/results/list/table-partial.html

# OTHER CONTENT - Advanced Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

# OTHER CONTENT - Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

# OTHER CONTENT - Legacy Template - src/scripts/pages/app/modals/legacy-template.html

legacy-template-warning-header = Warning

legacy-template-warning-message =
  | You are about to go to the legacy CNX site. To return to this page, you
  | can use your browser's back button.

legacy-template-remind-again = Don't remind me again

legacy-template-cancel-button = Cancel

legacy-template-go-button = Go

# OTHER CONTENT - Contents Out of Date Alert - src/scripts/pages/contents/contents-template.html

contents-alert-out-of-date =
  | This page is out of date. <a href="" data-bypass="true">Refresh</a>
  | to see the latest.

# OTHER CONTENT - Contents Library Page title and description - src/scripts/pages/contents/contents.coffee

content-library-pageTitle = Content Library

content-library-summary = OpenStax Content Library

content-library-description = Search for free, online textbooks.



### ERROR PAGE ###
# Example link: http://cnx.org/error
# Content related to the error pages.

# ERROR PAGE - Error Page - src/scripts/pages/error/error-template.html

error-page-oops = Oops!

error-page-oh-no-message =
  | Oh, No!<br />We're sorry, but the page you requested could not be found.<br />
  | Please try a <a href="/search">search</a> to find what you are looking for.

error-page-something-not-right-message =
  | Something's Not Right!<br />We're sorry, but we have experienced a
  | technical error.<br />Reloading this page may fix the issue, otherwise wait
  | a few minutes and try again.

error-page-reason = { $code ->
  [403] Forbidden
  [404] Page Not Found
  [408] Request Timed Out
  [500] Internal Server Error
  [503] Service Unavailable
 *[unknown] Unknown Error
}



### MAINTENANCE ###
# Content related to the page that displays when the site is in maintenance.

# MAINTENANCE - Maintenance - src/maintenance.html

maintenance-openstax-cnx-title = OpenStax CNX is currently down for Maintenance

maintenance-message = We are ironing out the kinks and should be back shortly!
