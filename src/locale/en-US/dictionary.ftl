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



### ABOUT ###
# Link: http://cnx.org/about/
# Content located in just the section of the About page accessed when clicking
# the menu item. Also includes the navigation on the left for accessing sub
# directories in the about page like People and Contact.

# ABOUT - Page Title and Description - src/scripts/pages/about/about.coffee

# ABOUT - Navigation - src/scripts/pages/about/about-template.html

# ABOUT - Content - src/scripts/pages/about/default/default-template.html

# ABOUT - Foundations - src/scripts/pages/about/people/people-template.html & src/scripts/pages/about/people/people.coffee



### PEOPLE ###
# Link: http://cnx.org/about/people
# Content on the People page among the about pages.

# PEOPLE - People - src/scripts/pages/about/people/people-template.html



### CONTACT ###
# Link: http://cnx.org/about/contact
# Content on the Contact page among the about pages.

# CONTACT - Content - src/scripts/pages/about/contact/contact-template.html



### SEARCH ###
# Link: http://cnx.org/browse
# Content on the page with subject categories.

# SEARCH - Page Summary and Description - src/scripts/pages/search/search.coffee

# SEARCH - Top bar - src/scripts/modules/find-content/find-content-template.html

# SEARCH - Content - src/scripts/pages/browse-content/browse-content-template.html



### ADVANCED SEARCH ###
# Link: http://cnx.org/search
# Content related to the advanced search form.

# ADVANCED SEARCH - Page Title - src/scripts/modules/search/advanced/advanced.coffee

# ADVANCED SEARCH - Content - src/scripts/modules/search/advanced/advanced-template.html



### SEARCH RESULTS ###
# Example link: http://cnx.org/search?q=subject:%22Business%22
# Content related to the displaying of search results and the filters on the
# search results page.

# SEARCH RESULTS - Page Title - src/scripts/modules/search/search.coffee

# SEARCH RESULTS - Header - src/scripts/modules/search/header/header-template.html

# SEARCH RESULTS - Filter - src/scripts/modules/search/results/filter/filter-template.html, src/scripts/models/search-results.coffee

# SEARCH RESULTS - Table - src/scripts/modules/search/results/list/table-partial.html

# SEARCH RESULTS - Navigation - src/scripts/modules/search/results/list/pagination-partial.html

# SEARCH RESULTS - No Results - src/scripts/modules/search/results/list/list-template.html

# SEARCH RESULTS - Item - src/scripts/modules/search/results/list/item-partial.html



### TEXTBOOK VIEW ###
# Example link: http://cnx.org/contents/02040312-72c8-441e-a685-20e9333f3e1d
# Content related to the display and viewing of textbooks.

# TEXTBOOK VIEW - Title - src/scripts/modules/media/title/title-template.html

textbook-view-btn-edit = Edit

textbook-view-btn-create = Create an Editable Copy

textbook-view-publishing = publishing { $title }

textbook-view-derived-from =
  | Derived from <a href="{ $url }">{ $title }</a> by
  | <span class="collection-authors">{ TAKE(50, $authors) }</span>

textbook-view-book-by =
  | Book by: <span class="collection-authors">{ TAKE(50, $authors) }</span>

textbook-view-page-by =
  | Page by: <span class="collection-authors">{ TAKE(50, $authors) }</span>

# TEXTBOOK VIEW - Downloads - src/scripts/modules/media/footer/downloads/downloads-template.html

textbook-view-downloads-header = Downloads

textbook-view-loading = Loading

textbook-view-loading-more-details-btn = More details

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

# TEXTBOOK VIEW - Footer Tabs - src/scripts/modules/media/footer/footer-template.html

# TEXTBOOK VIEW - Navigation - src/scripts/modules/media/nav/nav-template.html

# TEXTBOOK VIEW - Endorsement - src/scripts/modules/media/endorsed/endorsed-template.html

# TEXTBOOK VIEW - Header - src/scripts/modules/media/header/header-template.html

# TEXTBOOK VIEW - Metadata - src/scripts/modules/media/footer/metadata/metadata-template.html

# TEXTBOOK VIEW - Attribution - src/scripts/modules/media/footer/attribution/attribution-template.html

# TEXTBOOK VIEW - Get Book Drop Down - src/scripts/modules/media/header/popovers/book/book-template.html

# TEXTBOOK VIEW - Footer Toggle - src/scripts/modules/media/footer/inherits/tab/toggle-partial.html

# TEXTBOOK VIEW - Footer license - src/scripts/modules/media/footer/license/license-template.html

# TEXTBOOK VIEW - Table of Content Search - src/scripts/modules/media/tabs/contents/toc/page-template.html



### MY WORKSPACE ###
# Content related to the user starting the creation of a new textbook or viewing
# the current books in their workspace.

# MY WORKSPACE - Header and Buttons - src/scripts/modules/workspace/workspace-template.html

# MY WORKSPACE - Empty Workspace Message - src/scripts/modules/workspace/results/list/list-template.html

# MY WORKSPACE - Delete - src/scripts/modules/workspace/popovers/new/new-template.html

# MY WORKSPACE - Popover - src/scripts/modules/workspace/popovers/new/modals/new-media-template.html

# MY WORKSPACE - Page Title, Summary, Description - src/scripts/pages/workspace/workspace.coffee

# MY WORKSPACE - New Popover - src/scripts/modules/workspace/popovers/new/new-template.html

# MY WORKSPACE - Table Titles - src/scripts/modules/workspace/results/list/workspace-table-partial.html

# MY WORKSPACE - Number of Items  - src/scripts/modules/workspace/header/header-template.html



### TEXTBOOK EDITOR ###
# Content related to editor that enables the creation and editing of textbooks.

# TEXTBOOK EDITOR - Editbar Styling - src/scripts/modules/media/editbar/editbar-template.html

# TEXTBOOK EDITOR - Tabs Add Page - src/scripts/modules/media/tabs/contents/popovers/add/modals/add-page-template.html

# TEXTBOOK EDITOR - Create New Dropdown Menu - src/scripts/modules/media/tabs/contents/popovers/add/add-template.html

# TEXTBOOK EDITOR - Popup Section Name - src/scripts/modules/media/tabs/contents/toc/modals/section-name/section-name-template.html

# TEXTBOOK EDITOR - Table of Contents Search - src/scripts/modules/media/tabs/contents/contents-template.html

# TEXTBOOK EDITOR - Add Page List - src/scripts/modules/media/tabs/contents/popovers/add/modals/results/list/add-page-list-template.html

# TEXTBOOK EDITOR - Tools - src/scripts/modules/media/tabs/tools/tools-template.html

# TEXTBOOK EDITOR - Content & Tools - src/scripts/modules/media/tabs/tabs-template.html



### DONATE ###
# Links: http://cnx.org/donate, http://cnx.org/donate/form
# Content related to people donating money

# DONATE - Page Title and Description - src/scripts/pages/donate/donate.coffee

# DONATE - Header and Content - src/scripts/pages/donate/default/default-template.html

# DONATE - Slider - src/scripts/pages/donate/donation-slider/donation-slider.coffee, src/scripts/pages/donate/donation-slider/donation-slider-template.html

# DONATE - Form - src/scripts/pages/donate/form/form-template.html

# DONATE - Download Page - src/scripts/pages/donate/download/download-template.html

# DONATE - Thank You - src/scripts/pages/donate/thankyou/thankyou-template.html



### TERMS OF SERVICE ###
# Link: http://cnx.org/tos
# Content of the Terms of Service page.

# TERMS OF SERVICE - Page Title - src/scripts/pages/tos/tos.coffee

# TERMS OF SERVICE - Content - src/scripts/pages/tos/tos-template.html



### LICENSING ###
# Link: http://cnx.org/license
# Content of the Licensing page.

# LICENSING - Page Title - src/scripts/pages/license/license.coffee

# LICENSING - Content - src/scripts/pages/license/license-template.html



### ROLE ACCEPTANCES ###
# Content of the Role Acceptances page.

# ROLE ACCEPTANCES - Title - src/scripts/modules/role-acceptances/role-acceptances.coffee, src/scripts/pages/role-acceptance/role-acceptance.coffee

# ROLE ACCEPTANCES - Content - src/scripts/modules/role-acceptances/role-acceptances-template.html



### OTHER CONTENT ###
# Content that does not yet fit into any particular category. Instead organized
# only by file location,

# OTHER CONTENT - Modal Processing - src/scripts/modules/media/body/processing-instructions/modals/processing-instructions-template.html

# OTHER CONTENT - Media Body - src/scripts/modules/media/body/body-template.html

# OTHER CONTENT - Editbar Block Publish - src/scripts/modules/media/editbar/block-publish/modals/block-publish-template.html

# OTHER CONTENT - Editbar License Template - src/scripts/modules/media/editbar/license/modals/license-template.html

# OTHER CONTENT - Editbar Section Template - src/scripts/modules/media/editbar/modals/list/section-template.html

# OTHER CONTENT - Publish Template - src/scripts/modules/media/editbar/modals/publish-template.html

# OTHER CONTENT - Media Latest Template - src/scripts/modules/media/latest/latest-template.html

# OTHER CONTENTS - Minimal Search Results Table Partial - src/scripts/modules/minimal/search/results/list/table-partial.html

# OTHER CONTENT - Advanced Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

# OTHER CONTENT - Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

# OTHER CONTENT - Legacy Template - src/scripts/pages/app/modals/legacy-template.html

# OTHER CONTENT - Contents Out of Date Alert - src/scripts/pages/contents/contents-template.html

# OTHER CONTENT - Contents Library Page title and description - src/scripts/pages/contents/contents.coffee



### ERROR PAGE ###
# Example link: http://cnx.org/error
# Content related to the error pages.

# ERROR PAGE - Error Page - src/scripts/pages/error/error-template.html



### MAINTENANCE ###
# Content related to the page that displays when the site is in maintenance.

# MAINTENANCE - Maintenance - src/maintenance.html
