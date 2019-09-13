# Title:
#   Polish Translations FTL File
#
# Description:
#   This document provides the Polish translation of CNX.org when a user's
#   browser language is set to Polish.
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

main-splash-head = Odkryj materiały edukacyjne wolne od ograniczeń

main-splash-content =
  | Korzystaj z otwartych materiałów udostępnianych w postaci stron,
  | które można składać w kursy, podręczniki, skrypty
  | i inne publikacje akademickie. Twórz nowe zasoby i udostępniaj je innym.

main-learn-more = Dowiedz się więcej

# MAIN PAGE - Title - src/scripts/pages/home/home.coffee

home-pageTitle = Propagując wiedzę tworzymy społeczeństwo{$suffix}

# MAIN PAGE - Featured Textbooks - src/scripts/modules/featured-books/featured-books-partial.html

featured-books-show-more = Więcej
featured-books-show-less = Mniej

featured-books-openstax-heading = Podręczniki OpenStax
featured-books-openstax-description = OpenStax publikuje wysokiej jakości recenzowane podręczniki na otwartej licencji, dzięki czemu są udostępniane całkowicie za darmo w internecie, a egzemplarze drukowane można uzyskać niskim kosztem. Aby dowiedzieć się, jakie formaty są dostępne, odwiedź <a href="https://openstax.org">openstax.org</a> i wybierz interesującą cię dziedzinę.

featured-books-cnx-heading = Zasoby stworzone przez użytkowników
featured-books-cnx-description = Poniższe książki i strony zostały przygotowane i udostępnione przez społeczność ludzi przekonanych o tym, że zasoby edukacyjne powinny być otwarte dla wszystkich.


### HEADER ###
# Content located in the header on each page. This includes the navigation
# and account interface.

# HEADER - Top Right Message - src/scripts/modules/header/header-template.html

all-cnx-author-legacy-site = Twórz zasoby | Stara wersja CNX
  [html/title] Przejdź do starej wersji CNX

# HEADER - Nav Bar - src/scripts/modules/header/header-template.html

all-navbar-search = Szukaj

all-navbar-about-us = O nas

all-navbar-give = Wesprzyj nas

all-navbar-workspace = Moje biurko

all-header-skip-to-content = Przejdź do treści

all-header-skip-to-results = Przejdź do wyników

all-header-account-profile = Ustawienia konta

all-header-log-out = Wyloguj { $username }

all-navbar-toggle-navigation = Przełącz nawigację

all-header-support = Pomoc
  [html/title] Przejdź do strony pomocy CNX



### FOOTER ###
# Content located in the footer of every page.

# FOOTER - Footer - src/scripts/modules/footer/footer-template.html

all-footer-support =
  | Serwis powstał dzięki pomocy William &amp;
  | Flora Hewlett Foundation, Bill &amp; Melinda Gates Foundation,
  | Michelson 20MM Foundation, Maxfield Foundation, Open Society Foundations oraz Rice University.
  | Obsługiwany przez OpenStax CNX.

all-footer-ap =
  | Advanced Placement® oraz AP® to zarejestrowane znaki
  | towarowe będące własnością College Board, która nie uczestniczyła w
  | tworzeniu niniejszej strony ani jej nie autoryzowała.

all-footer-creative-commons =
  | Rice University. Wszystkie treści zawarte
  | w serwisie zostały opublikowane na licencji Creative Commons Uznanie
  | Autorstwa 4.0, z wyjątkiem tych, dla których wskazano inną licencję.

all-footer-licensing = Licencje

all-footer-terms-of-use = Warunki użytkowania

all-footer-accessibility = Ułatwienia dostępności

all-footer-contact = Kontakt

all-footer-android-app = Aplikacja na Androida

all-footer-dev-blog = Blog

all-footer-itunes = iTunes

all-footer-share = Udostępnij



### ABOUT ###
# Link: http://cnx.org/about/
# Content located in just the section of the About page accessed when clicking
# the menu item. Also includes the navigation on the left for accessing sub
# directories in the about page like People and Contact.

# ABOUT - Page Title and Description - src/scripts/pages/about/about.coffee

about-pageTitle =  O OpenStax CNX{$suffix}

about-summary = O OpenStax CNX

about-description = OpenStax CNX jest organizacją non-profit udostępniającą tysiące otwartych cyfrowych podręczników.

# ABOUT - Navigation - src/scripts/pages/about/about-template.html

about-nav-about-us = O nas

about-nav-people = Ludzie

about-nav-contact = Kontakt

# ABOUT - Content - src/scripts/pages/about/default/default-template.html

about-header = O nas

about-content =
  | <p>Wierzymy, że każdy człowiek może nauczyć się czegoś nowego i każdy człowiek może nauczyć czegoś kogoś innego.</p>
  |
  | <p>Zirytowany ograniczeniami tradycyjnych podręczników, w 1999 roku dr Richard Baraniuk
  | założył OpenStax (wówczas Connexions) na Rice University, aby udostępnić autorom i studentom miejsce,
  | gdzie mogliby swobodnie publikować i modyfikować otwarte zasoby edukacyjne takie jak kursy,
  | podręczniki czy skrypty.</p>
  |
  | <p>Obecnie OpenStax CNX to dynamicznie rozwijający się cyfrowy ekosystem, dzięki któremu miliony użytkowników
  | miesięcznie uczą się z otwartych zasobów edukacyjnych nie płacąc za to ani grosza.</p>
  |
  | <p>Serwis zawiera dziesiątki tysięcy modułów edukacyjnych zwanych <b>stronami</b>, które zgrupowane są w
  | <b>książki</b> tworząc gotowe podręczniki z wielu różnych dziedzin, łatwo dostępne przez internet i w każdej chwili
  | gotowe do pobrania na niemal dowolne urządzenie.</p>
  |
  | <p>A co najlepsze, to wszystko jest dostępne za darmo dzięki wspaniałomyślnej pomocy Rice University i wielu
  | organizacji charytatywnych.</p>
  |
  | <p><a href="{ $link-about }">Dowiedz się więcej o zespole tworzącym OpenStax</a></p>
  |
  | <p><a href="{ $link-foundation }">Dowiedz się więcej o fundacjach wspierających projekty OpenStax,
  | takie jak CNX</a></p>

about-how-it-works-header = Jak to działa

about-authors-can-header = Autorzy mogą:

about-allowing-learners-header = Studenci mogą:

about-frictionless-remix-header = Łatwe adaptowanie

frictionless-content =
  | <p>OpenStax CNX powstał z myślą o promowaniu otwartego udostępniania i adaptowania zasobów edukacyjnych.
  | Wiedzę zgromadzoną w OpenStax CNX mogą poszerzać wszyscy, ponieważ jest dostępna do modyfikacji:</p>
  | <ul>
  | <li><b>pod względem edukacyjnym:</b>
  | Zachęcamy autorów, aby tworzyli każdą stronę jako samowystarczalny, odrębny zasób. Dzięki temu innym łatwiej będzie
  | wykorzystać ją we własnych kolekcjach tworzonych na potrzeby ich studentów.</li>
  |
  | <li><b>pod względem technicznym:</b>
  | wszystkie zasoby oparte są na prostym składniowo formacie HTML5, z wbudowanym wsparciem dla osób o specjalnych
  | potrzebach, aby mogli korzystać z nich wszyscy. Dzięki narzędziom udostępnionym w OpenStax CNX, autorzy mogą tworzyć
  | i modyfikować zasoby równie łatwo, jak gdyby pracowali w Google Docs lub w Microsoft Word.</li>
  |
  | <li><b>pod względem prawnym:</b>
  | wszystkie zasoby tworzone na OpenStax są udostępniane na otwartych licencjach Creative Commons.
  | Dzięki temu autorzy mogą łatwo umożliwić innym zgodne z prawem wykorzystywanie i adaptowanie ich pracy,
  | jednocześnie zachowując prawo do należnego uznania autorstwa. Oprogramowanie OpenStax CNX samo dba o przytoczenie
  | oryginalnego autora, więc proces adaptacji jest bezbolesny.</li>
  | </ul>




### CONTACT ###
# Link: http://cnx.org/about/contact
# Content on the Contact page among the about pages.

# CONTACT - Content - src/scripts/pages/about/contact/contact-template.html

about-contact-header = Kontakt

about-contact-questions-header = Masz pytanie?

about-contact-questions-content = Możesz skontaktować się z nami wysyłając e-mail na adres <a href="mailto:kontakt@openstax.pl">kontakt@openstax.pl</a>.

### SEARCH ###
# Link: http://cnx.org/browse
# Content on the page with subject categories.

# SEARCH - Page Summary and Description - src/scripts/pages/search/search.coffee

search-pageTitle = Szukaj w bibliotece OpenStax CNX{$suffix}

search-page-summary = Szukaj podręczników

search-page-description = Szukaj wśród tysięcy otwartych podręczników dostępnych online.

# SEARCH - Top bar - src/scripts/modules/find-content/find-content-template.html

search-find-content = Szukaj zasobów

search-search = Search
  [html/placeholder]  Szukaj

search-or = lub

search-advanced-search = Zaawansowane wyszukiwanie

# SEARCH - Content - src/scripts/pages/browse-content/browse-content-template.html

search-header = Witaj w cyfrowej bibliotece OpenStax CNX

search-content =
  | Zasoby OpenStax CNX udostępniane są w dwóch postaciach:
  | <strong>modułów/stron</strong>, stanowiących małe "porcje wiedzy," oraz
  | <strong>kolekcji/książek</strong>, stanowiących zestawy modułów ułożone w
  | formę podręcznika, kursu lub publikacji o innym przeznaczeniu. Otwarte
  | licencje pozwalają na swobodne użytkowanie wszystkich zasobów.

search-pages = Strony: { $count }

search-books = Książki: { $count }



### ADVANCED SEARCH ###
# Link: http://cnx.org/search
# Content related to the advanced search form.

# ADVANCED SEARCH - Page Title - src/scripts/modules/search/advanced/advanced.coffee

advanced-search-pageTitle = Zaawansowane wyszukiwanie{$suffix}

# ADVANCED SEARCH - Minimal Search Results Table Partial - src/scripts/modules/minimal/search/results/list/table-partial.html

minimal-search-results-table-partial-books = Książki

minimal-search-results-table-partial-pages = Strony

minimal-search-results-table-partial-miscellaneous = Dodatkowe

# ADVANCED SEARCH - Advanced Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

advanced-search-minimal-pageTitle = Zaawansowane wyszukiwanie{$suffix}

# ADVANCED SEARCH - Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

search-minimal-pageTitle = Szukaj{$suffix}

# ADVANCED SEARCH - Content - src/scripts/modules/search/advanced/advanced-template.html

advanced-search-author = Autor

advanced-search-title = Tytuł

advanced-search-subject = Dziedzina

advanced-search-subject-default-any = Dowolna

advanced-search-subject-arts = Muzyka i plastyka

advanced-search-subject-business = Przedsiębiorczość

advanced-search-subject-humanities = Nauki humanistyczne

advanced-search-subject-math = Matematyka i statystyka

advanced-search-subject-science = Pozostałe nauki ścisłe, przyrodnicze i techniczne

advanced-search-subject-social-sciences = Nauki społeczne

advanced-search-keywords = Słowa kluczowe

advanced-search-type = Typ

advanced-search-type-default-any = Dowolny

advanced-search-type-books = Książki

advanced-search-type-pages = Strony

advanced-search-language = Język

advanced-search-language-default-any = Dowolny

advanced-search-publication-date = Rok publikacji

advanced-search-publication-date-default-any = Dowolny

advanced-search-sort = Sortuj według

advanced-search-sort-default-relevance = trafności

advanced-search-sort-publication-date = Roku publikacji

advanced-search-sort-popularity = popularności

advanced-search-submit = Szukaj

advanced-search-language-option = { $native } ({ $code ->
  [aa] Afar
  [ab] Abhaski
  [af] Afrikaans
  [am] Amharski
  [ar] Arabski
  [as] Asamski
  [ay] Ajmara
  [az] Azerbejdżański
  [ba] Bashkir
  [be] Białoruski
  [bg] Bułgarski
  [bh] Bihari
  [bi] Bislama
  [bn] Bengalski
  [bo] Tybetański
  [bs] Bośniacki
  [br] Breton
  [ca] Kataloński
  [ch] Chamorro
  [co] Korsykański
  [cs] Czeski
  [cy] Walijski
  [da] Duński
  [de] Niemiecki
  [dz] Bhutani
  [el] Grecki
 *[en] Angielski
  [eo] Esperanto
  [es] Hiszpański
  [et] Estoński
  [eu] Baskijski
  [fa] Perski
  [fi] Fiński
  [fj] Fidżi
  [fo] Farerski
  [fr] Francuski
  [fy] Fyrzyjski
  [ga] Irlandzki
  [gd] Szkocki
  [gl] Galicyjski
  [gn] Guarani
  [gu] Gujarati
  [gv] Manx
  [ha] Hausa
  [he] Hebrajski
  [hi] Hinduski
  [hr] Chorwacki
  [hu] Węgierski
  [hy] Ormiański
  [ia] Interlingua
  [id] Indonezyjski
  [ie] Interlingue
  [ik] Inupiak
  [is] Iskandzki
  [it] Włoski
  [iu] Inuktitut
  [ja] Japoński
  [jbo] Lojban
  [jw] Jawajski
  [ka] Gruziński
  [kk] Kazahski
  [kl] Grenlandzki
  [km] Khmerski
  [kn] Kannada
  [ko] Koreański
  [ks] Kashmiri
  [ku] Kursyjski
  [kw] Kornwalijski
  [ky] Kirgiski
  [la] Łacina
  [lb] Luksemburski
  [li] Limburgijski
  [ln] Lingala
  [lo] Laosu
  [lt] Litewski
  [lv] Łotwski
  [mg] Madagascarian
  [mi] Maori
  [mk] Macedoński
  [ml] Malajalam
  [mn] Mongolski
  [mo] Mołdawski
  [mr] Marathi
  [ms] Malajski
  [mt] Maltese
  [my] Birmański
  [na] Nauruan
  [ne] Nepalski
  [nl] Holenderski
  [no] Norweski
  [nn] Nynorsk
  [oc] Occitan
  [om] Oromski
  [or] Orija
  [pa] Punjabi
  [pl] Polski
  [ps] Paszto
  [pt] Portugalski
  [qu] Quechua
  [rm] Retoromański
  [rn] Kirundi
  [ro] Rumuński
  [ru] Rosyjski
  [rw] Kiyarwanda
  [sa] Sanskryt
  [sd] Sindhi
  [se] Lapoński
  [sg] Sangho
  [sh] Serbochorwacki
  [si] Cejloński
  [sk] Słowacki
  [sl] Słoweński
  [sm] Samoański
  [sn] Shona
  [so] Somalijski
  [sq] Albański
  [sr] Serbski
  [ss] Siswati
  [st] Sesotho
  [su] Sudański
  [sv] Szwedzki
  [sw] Suahili
  [ta] Tamil
  [te] Telugu
  [tg] Tadjik
  [th] Tajski
  [ti] Tigrinia
  [tk] Turkmeński
  [tl] Tagalog
  [tn] Setswana
  [to] Tonga
  [tr] Turecki
  [ts] Tsonga
  [tt] Tatarski
  [tw] Twi
  [ug] Uigur
  [uk] Ukraiński
  [ur] Urdu
  [uz] Uzbecki
  [vi] Wietnamski
  [vo] Volapük
  [wa] Waloński
  [wo] Wolof
  [xh] Xhosa
  [yi] Jidysz
  [yo] Jorouba
  [za] Zhuang
  [zh] Chiński
  [zu] Zuluski
})



### SEARCH RESULTS ###
# Example link: http://cnx.org/search?q=subject:%22Business%22
# Content related to the displaying of search results and the filters on the
# search results page.

# SEARCH RESULTS - Page Title - src/scripts/modules/search/search.coffee

search-results-pageTitle = Szukaj{$suffix}

# SEARCH RESULTS - Header - src/scripts/modules/search/header/header-template.html

search-results-search-results = Wyniki wyszukiwania

search-results-advanced-search = Zaawansowane wyszukiwanie

search-results-tips-and-help = Wyszukiwanie - porady i pomoc

search-results-number-results = { $counter ->
  [0] Brak wyników
  [1] Znaleziono jeden wynik
  [few] Znaleziono <strong>{ $counter }</strong> wyniki
  [many] Znaleziono <strong>{ $counter }</strong> wyników
 *[other] Znaleziono <strong>{ $counter }</strong> wyniku
}

# SEARCH RESULTS - Filter - src/scripts/modules/search/results/filter/filter-template.html, src/scripts/models/search-results.coffee

search-results-filters = Filtry

search-results-filter-moreless = { $ismore ->
 *[0] Więcej
  [1] Mniej
}

search-results-filter-author = Autor
search-results-filter-authorID = Autor
search-results-filter-keyword = Słowa kluczowe
search-results-filter-language = Język
search-results-filter-mediaType = Typ
search-results-filter-type = Typ
search-results-filter-pubYear = Rok publikacji
search-results-filter-subject = Dziedzina
search-results-filter-title = Tytuł
search-results-filter-text = Tekst

search-results-filter-book-page = { $displayval ->
  [Book] Książka
  [Page] Strona
 *[other] { $displayval }
}

search-results-filter-subject-value = { $subject ->
  [Arts] Muzyka i plastyka
  [Business] Przedsiębiorczość
  [Humanities] Nauki humanistyczne
  [Mathematics and Statistics] Matematyka i statystyka
  [Science and Technology] Pozostałe nauki ścisłe, przyrodnicze i techniczne
  [Social Sciences] Nauki społeczne
 *[__other__] { $subject }
}

# SEARCH RESULTS - Table - src/scripts/modules/search/results/list/table-partial.html

search-results-table-type = Typ
search-results-table-title = Tytuł
search-results-table-authors = Autorzy
search-results-table-edited = Ostatnia modyfikacja

search-results-books = Książki
search-results-pages = Strony
search-results-miscellaneous = Dodatkowe

# SEARCH RESULTS - Navigation - src/scripts/modules/search/results/list/pagination-partial.html

search-results-navigation-prev = Wstecz
search-results-navigation-next = Dalej

# SEARCH RESULTS - No Results - src/scripts/modules/search/results/list/list-template.html

search-results-list-search-taking-time =
| Wyszukiwanie trwa dłużej niż zazwyczaj. Wyniki mogą być już dostępne —
| spróbuj przeładować stronę. Możesz też zawęzić kryteria wyszukiwania
| wybierając „Wyszukiwanie zaawansowane” powyżej.

search-results-list-no-results = Brak wyników. Spróbuj rozszerzyć kryteria wyszukiwania.

search-results-list-loading = Ładowanie

# SEARCH RESULTS - Item - src/scripts/modules/search/results/list/item-partial.html

search-results-item-edited = { DATETIME($date) }


### TEXTBOOK VIEW ###
# Example link: http://cnx.org/contents/02040312-72c8-441e-a685-20e9333f3e1d
# Content related to the display and viewing of textbooks.

# TEXTBOOK VIEW - Title - src/scripts/modules/media/title/title-template.html

textbook-view-btn-edit = Edytuj

textbook-view-btn-create = Utwórz kopię do edycji

textbook-view-publishing = publikujesz { $title }

textbook-view-derived-from = Utworzone z <a href="{ $url }">{ $title }</a> autorstwa <span class="collection-authors">{ TAKE(50, $authors) }</span>

textbook-view-book-by =
  | Utworzone przez: <span class="collection-authors">{ TAKE(50, $authors) }</span>

textbook-view-page-by =
  | Utworzone przez: <span class="collection-authors">{ TAKE(50, $authors) }</span>

# TEXTBOOK VIEW - Downloads - src/scripts/modules/media/footer/downloads/downloads-template.html

textbook-view-downloads-header = Do pobrania

textbook-view-loading = Ładowanie

textbook-view-loading-more-details-btn = Pokaż szczegóły

textbook-view-loading-less-details-btn = Ukryj szczegóły

textbook-view-th-format = Format:

textbook-view-th-details = Szczegóły

textbook-view-th-file-name = Nazwa pliku:

textbook-view-th-generated = Wygenerowany:

textbook-view-th-size = Rozmiar:

textbook-view-file-not-available = Plik niedostępny

textbook-view-no-downloads = Pobieranie w tej chwili jest niedostępne.

textbook-view-file-description = { $format ->
  [PDF] Plik PDF, najlepszy do drukowania.
  [EPUB] Książka cyfrowa, najlepsza do przeglądania na urządzeniach mobilnych bez połączenia z internetem.
  [Offline ZIP]
    | Archiwum HTML, najlepsze do przeglądania na komputerze bez połączenia z internetem.
    | Zawiera XML, multimedia i inne zasoby dodatkowe.
 *[other] { $format }
}

# TEXTBOOK VIEW - History - src/scripts/modules/media/footer/history/history-template.html

textbook-view-version-history-header = Historia wersji

textbook-view-th-version = Wersja:

textbook-view-th-datetime = Data/Godzina:

textbook-view-th-changes = Zmiany:

textbook-view-th-publisher = Wydawca:

# TEXTBOOK VIEW - Footer Tabs - src/scripts/modules/media/footer/footer-template.html

textbook-view-tab-downloads = Pobrania

textbook-view-tab-history = Historia

textbook-view-tab-attribution = Uznanie autorstwa

textbook-view-tab-more-info = Więcej informacji

# TEXTBOOK VIEW - Navigation - src/scripts/modules/media/nav/nav-template.html

textbook-view-btn-back = Wstecz

textbook-view-btn-back-to-top = Do góry

textbook-view-btn-next = Dalej

textbook-view-search-this-book =
  [html/placeholder] Szukaj w tej książce

textbook-view-contents = Spis treści

textbook-view-contents-aria-label =
  [html/aria-label] Kliknij, aby odkryć spis treści

textbook-view-books = Książki

# TEXTBOOK VIEW - Endorsement - src/scripts/modules/media/endorsed/endorsed-template.html

textbook-view-endorsed-by = Zatwierdzone przez: OpenStax

# TEXTBOOK VIEW - Header - src/scripts/modules/media/header/header-template.html

textbook-view-btn-create-copy = Utwórz kopię do edycji

textbook-view-btn-edit-page = Edytuj stronę

textbook-view-btn-get-this-book = Weź tę książkę!

textbook-view-btn-get-this-page = Weź tę stronę!

textbook-view-summary = Podsumowanie

textbook-view-header-derived-from =
  | Utworzone z <a href="{ $url }">{ $title }</a> autorstwa <span class="book-authors">{ TAKE(50, $authors) }</span>

# TEXTBOOK VIEW - Metadata - src/scripts/modules/media/footer/metadata/metadata-template.html

textbook-view-dt-name = Nazwa:

textbook-view-dt-id = Identyfikator:

textbook-view-dt-language = Język:

textbook-view-dt-summary = Podsumowanie:

textbook-view-dt-subjects = Przedmioty:

textbook-view-dt-keywords = Słowa kluczowe:

textbook-view-dt-print-style = Styl wydruku:

textbook-view-dt-license = Licencja:

textbook-view-dt-authors = Autorzy:

textbook-view-dt-copyright-holders = Właściciele licencji:

textbook-view-dt-publishers = Wydawcy:

textbook-view-dt-latest-version = Najnowsza wersja:

textbook-view-dt-first-publication-date = Data pierwszej publikacji:

textbook-view-dt-latest-revision = Ostatnia modyfikacja:

textbook-view-dt-last-edited-by = Ostatnia modyfikacja przez:

textbook-view-subject-name = { $name ->
  [Arts] Sztuka
  [Business] Przedsiębiorczość
  [Humanities] Nauki humanistyczne
  [Mathematics and Statistics] Matematyka i Statystyka
  [Science and Technology] Pozostałe nauki ścisłe, przyrodnicze i techniczne
  [Social Sciences] Nauki społeczne
 *[other] { $name }
}

# TEXTBOOK VIEW - Attribution - src/scripts/modules/media/footer/attribution/attribution-template.html

textbook-view-textbook-attribute-header = Zasady korzystania z tego zasobu

textbook-view-textbook-content-produced =
  | Treść tej książki została stworzona przez <span>{ TAKE(50, $authors) }</span>
  | i jest udostępniona na licencji <a href="{ $url }">{ $title }</a>.

textbook-view-attribution-p-1 =
  | Na mocy tej licencji, każdy użytkownik tej książki lub jej fragmentów zobowiązany jest do uznania autorstwa
  | w następujący sposób:

textbook-view-attribution-p-2-strong =
  | Nazwa OpenStax, logo OpenStax, okładki książek OpenStax,
  | nazwa OpenStax CNX i logo OpenStax CNX nie podlegają licencji Creative Commons
  | i wykorzystywanie ich jest dozwolone tylko na mocy uprzedniego, pisemnego upoważnienia ze strony Rice University.

textbook-view-attribution-p-2-span =
  | Jeśli masz jakiekolwiek pytania odnośnie tej licencji, skontaktuj się z <a href="{ $url }">{ $title }</a>.

textbook-view-attribution-li-1 =
  | Jeśli chcesz umieścić odnośnik do tej książki w bibliografii,
  | zrób to zgodnie z poniższym przykładem:

textbook-view-attribution-li-2-title =
  | Jeśli rozpowszechniasz tę książkę w formie drukowanej,
  | jesteś zobowiązany do umieszczenia na każdej jej kartce następującej informacji:

textbook-view-attribution-li-2-attribution = "Pobierz za darmo z { $url }."

textbook-view-attribution-li-3-title =
  | Jeśli rozpowszechniasz fragment tej książki, jesteś zobowiązany do umieszczenia
  | na każdym cyfrowym widoku strony (w tym w plikach EPUB, PDF i HTML)
  | a także na każdej drukowanej kartce następującej informacji:

textbook-view-attribution-li-3-attribution = "Pobierz za darmo z { $url }."

# TEXTBOOK VIEW - Get Book Drop Down - src/scripts/modules/media/header/popovers/book/book-template.html

textbook-view-book-download-image =
  [html/alt]  Pobierz

textbook-view-book-get-this-book = Weź tę książkę

textbook-view-book-download-book = Pobierz książkę:

textbook-view-book-download-page = Pobierz stronę:

textbook-view-book-order-book = Zamów egzemplarz drukowany

# TEXTBOOK VIEW - Footer Toggle - src/scripts/modules/media/footer/inherits/tab/toggle-partial.html

textbook-view-book-button = Książka

textbook-view-page-button = Strona

# TEXTBOOK VIEW - Footer license - src/scripts/modules/media/footer/license/license-template.html

textbook-view-license = Zasób udostępniony { LEN($licensors) ->
    [0]
   *[other] przez { $licensors }
  } { LEN($name) ->
    [0]
   *[other] na licencji <a href="{ $url }">{ $name } ({ $code } { $version })</a>
  }.

# TEXTBOOK VIEW - Table of Content Search - src/scripts/modules/media/tabs/contents/toc/page-template.html

textbook-view-toc-page-match-count = { NUMBER($count) ->
  [1] { $count } wystąpienie
  [few] { $count } wystąpienia
  [many] { $count } wystąpień
 *[other] { $count } wystąpienia
}

textbook-view-toc-page-changed = zmienione



### MY WORKSPACE ###
# Content related to the user starting the creation of a new textbook or viewing
# the current books in their workspace.

# MY WORKSPACE - Header and Buttons - src/scripts/modules/workspace/workspace-template.html

workspace-header = Moje biurko

workspace-button-new = Nowa

workspace-button-recently-published = Ostatnio opublikowane

# MY WORKSPACE - Empty Workspace Message - src/scripts/modules/workspace/results/list/list-template.html

workspace-empty-workspace-msg =
  | Twoje biurko jest puste. Możesz stworzyć nowy zasób albo wyszukać istniejący i utworzyć kopię do modyfikacji.

# MY WORKSPACE - Delete - src/scripts/modules/workspace/popovers/new/new-template.html

workspace-delete-close = Zamknij

workspace-delete-confirm = Potwierdź

workspace-delete-are-you-sure = Czy na pewno skasować { $title }?

workspace-delete-close-2 = Zamknij

workspace-delete-OK = OK

# MY WORKSPACE - Popover - src/scripts/modules/workspace/popovers/new/modals/new-media-template.html

workspace-popover-create-new = Utwórz Nową

workspace-popover-title-label = Tytuł

workspace-popover-title-input =
  [html/placeholder]  Tytuł

workspace-popover-cancel-button = Anuluj

workspace-popover-create-new-button = Utwórz Nową

# MY WORKSPACE - Page Title, Summary, Description - src/scripts/pages/workspace/workspace.coffee

workspace-pageTitle = Moje biurko{$suffix}

workspace-summary = Stwórz nowy zasób albo wyszukaj istniejący i utwórz kopię do modyfikacji.

workspace-description = Twórz darmowe zasoby edukacyjne lub modyfikuj istniejące.

# MY WORKSPACE - New Popover - src/scripts/modules/workspace/popovers/new/new-template.html

workspace-new-popover-book = Książka

workspace-new-popover-page = Strona

# MY WORKSPACE - Table Titles - src/scripts/modules/workspace/results/list/workspace-table-partial.html

workspace-table-type = Typ
workspace-table-title = Tytuł
workspace-table-status = Status
workspace-table-edited = Ostatnia zmiana
workspace-table-delete = Skasuj

# MY WORKSPACE - Number of Items  - src/scripts/modules/workspace/header/header-template.html

workspace-results-plural = { $items ->
  [0] Brak wyników
  [1] Jeden wynik
  [few] <strong>{ $items }</strong> wyniki
  [many] <strong>{ $items }</strong> wyników
 *[other] <strong>{ $items }</strong> wyników
}



### TEXTBOOK EDITOR ###
# Content related to editor that enables the creation and editing of textbooks.

# TEXTBOOK EDITOR - Editbar Styling - src/scripts/modules/media/editbar/editbar-template.html

textbook-editor-toggle-navigation = Przełącz nawigację

textbook-editor-edit = Edytuj

textbook-editor-normal-text-button = Normalny Tekst

textbook-editor-normal-text = Normalny Tekst

textbook-editor-h1 = Nagłówek 1
textbook-editor-h2 = Nagłówek 2
textbook-editor-h3 = Nagłówek 3

textbook-editor-code = Kod

textbook-editor-bold =
  [html/title] Pogrubiony
textbook-editor-italic =
  [html/title] Kursywa
textbook-editor-underline =
  [html/title] Podkreślać
textbook-editor-superscript =
  [html/title] Napisany u góry
textbook-editor-subscript =
  [html/title] Indeks

textbook-editor-add-row-before = Dodaj wiersz przed
textbook-editor-add-row-after = Dodaj wiersz po
textbook-editor-add-column-before = Dodaj kolumnę przed
textbook-editor-add-column-after = Dodaj kolumnę po
textbook-editor-add-header-row = Dodaj wiersz nagłówka
textbook-editor-delete-row = Usuń wiersz
textbook-editor-delete-column = Usuń kolumnę
textbook-editor-delete-table = Usuń tabelę

textbook-editor-paste-button =
  [html/data-content] Treść została skopiowana do schowka. Kliknij ten przycisk, aby wkleić treść do strony.

textbook-editor-save-draft = Zapisz Projekt

textbook-editor-publish-button = Publikacja...

textbook-editor-drag-to-add = Przeciągnij, aby dodać nową...

# TEXTBOOK EDITOR - Tabs Add Page - src/scripts/modules/media/tabs/contents/popovers/add/modals/add-page-template.html

textbook-editor-add-page-header = Dodaj strony

textbook-editor-add-page-show-draft = Pokaż szkice stron

textbook-editor-add-page-title-label = Tytuł

textbook-editor-add-page-title-input =
  [html/placeholder] Tytuł

textbook-editor-add-page-search-button = Szukaj

textbook-editor-add-page-cancel-button = Anuluj

textbook-editor-add-page-create-new-page-button = Utwórz nową stronę

# TEXTBOOK EDITOR - Create New Dropdown Menu - src/scripts/modules/media/tabs/contents/popovers/add/add-template.html

textbook-editor-menu-page = Stronę

textbook-editor-menu-section = Rozdział

# TEXTBOOK EDITOR - Popup Section Name - src/scripts/modules/media/tabs/contents/toc/modals/section-name/section-name-template.html

textbook-editor-section-edit-header = Edit Section Name

textbook-editor-section-title-label = Tytuł

textbook-editor-section-title-input =
  [html/placeholder]  Tytuł

textbook-editor-section-ok-button = Ok

textbook-editor-section-cancel-button = Anuluj

# TEXTBOOK EDITOR - Table of Contents Search - src/scripts/modules/media/tabs/contents/contents-template.html

textbook-editor-contents-add-button = Dodaj

textbook-editor-contents-back-to-table = Powrót do spisu treści

textbook-editor-contents-results-matches = { $hits ->
  [0] Nie znaleziono szukanej treści.
  [1] Znaleziono { $hits } stronę
  [few] Znaleziono { $hits } strony
  [many] Znaleziono { $hits } stron
 *[other] Znaleziono { $hits } strony
}

textbook-view-page-in-books = { $numbooks ->
  [0] Żadna książka nie zawiera tej strony.
  [1] Jedna książka zawiera tę stronę:
  [few] { $numbooks } książki zawierają tę stronę:
  [many] { $numbooks } książek zawiera tę stronę:
 *[other] { $numbooks } książki zawiera tę stronę:
}

textbook-view-book-list-revised = Zmodyfikowano:

textbook-view-book-list-go-to-book = Przejdź do książki

# TEXTBOOK EDITOR - Add Page List - src/scripts/modules/media/tabs/contents/popovers/add/modals/results/list/add-page-list-template.html

textbook-editor-add-page-list-no-results = Brak wyników. Spróbuj rozszerzyć wyszukiwanie.

textbook-editor-add-page-list-loading = Ładowanie

# TEXTBOOK EDITOR - Tools - src/scripts/modules/media/tabs/tools/tools-template.html

textbook-editor-tools-edit = Edytuj

textbook-editor-tools-preview = Podgląd

textbook-editor-tools-make-editable-copy = Stwórz edytowalną kopię

textbook-editor-tools-teachers-edition = Wydanie nauczyciela

textbook-editor-tools-standard-edition = Wydanie standardowe

# TEXTBOOK EDITOR - Content & Tools - src/scripts/modules/media/tabs/tabs-template.html

textbook-editor-template-contents = Spis treści

textbook-editor-template-tools = Narzędzia

### TERMS OF SERVICE ###
# Link: http://cnx.org/tos
# Content of the Terms of Service page.

# TERMS OF SERVICE - Page Title - src/scripts/pages/tos/tos.coffee

terms-of-service-pageTitle = Warunki korzystania z serwisu OpenStax CNX{$suffix}

terms-of-service-summary = OpenStax CNX - warunki serwisu

terms-of-service-description = OpenStax CNX - warunki serwisu

# TERMS OF SERVICE - Content - src/scripts/pages/tos/tos-template.html



### LICENSING ###
# Link: http://cnx.org/license
# Content of the Licensing page.

# LICENSING - Page Title - src/scripts/pages/license/license.coffee

licensing-pageTitle = OpenStax CNX: Najczęsciej zadawane pytania odnośnie warunków licencyjnych{$suffix}

licensing-summary = Licencja OpenStax CNX

licensing-description = OpenStax CNX - Najczęściej zadawane pytania dotyczące warunków licencyjnych

licensing-title = Kwestie prawne

licensing-document-description =
  | Najczęściej zadawane pytania dotyczące własności intelektualnej i kwestii prawnych

licensing-question-1 = Dlaczego muszę wyrazić zgodę na Waszą licencję, zanim opublikuję swoją pracę?

licensing-answer-1 =
  | <p>Naszym celem jest stworzenie i utrzymywanie miejsca (repozytorium), w którym zarówno
  | indywidualni użytkownicy, jak i społeczności z całego świata mogą tworzyć i swobodnie
  | dzielić się wiedzą. Licencja <a href="http://creativecommons.pl">Creative Commons</a> –
  | <a href="https://creativecommons.org/licenses/by/4.0/deed.pl">Uznanie autorstwa</a>,
  | na którą wyrażasz zgodę, podobnie jak każdy inny autor, umożliwia ponowne wykorzystywanie
  | Twoich treści. Dzięki temu wszystkie treści są dostępne dla każdego bez ograniczeń i każdy
  | autor może wykorzystywać te treści, dzielić się nimi z innymi albo tworzyć utwory pochodne,
  | spersonalizowane i dopasowane do konkretnego kontekstu.</p>
  | <p>Licencja ta również zmniejsza ryzyko prawne, ponieważ jasno określa, jakie są zgodne
  | z prawem sposoby wykorzystania materiałów. Bez Licencji każdy musiałby założyć, że Twoja praca
  | objęta jest pełną ochroną prawami autorskimi, nawet jeśli Twoim celem lub życzeniem jest,
  | żeby znalazła się ona w domenie publicznej i była swobodnie dostępna. Przyjęcie Licencji
  | daje jasno do zrozumienia - zarówno czytelnikom, jak i prawnikom - że taka właśnie
  | jest Twoja intencja.</p>

licensing-question-2 =
  | Dlaczego miałbym udostępniać swój utwór na licencji Creative Commons – Uznanie autorstwa,
  | zamiast publikować go z pełną ochroną prawami autorskimi?

licensing-answer-2 =
  | Jest kilka powodów. Może podobać Ci się idea, że inni będą rozwijać Twój utwór lub
  | że przyczynisz się do rozwoju wartości intelektualnej zasobów publicznych. W miarę wzrostu
  | tych zasobów, Ty i inni autorzy możecie czerpać satysfakcję z tego, że przyczyniacie się do
  | rozwoju nowych sposobów współpracy. Kolejnym powodem jest to, że dzięki tej Licencji Twoje
  | teksty będą kopiowane i rozpowszechniane na całym świecie, a wraz z nimi Twoje idee i pomysły.
  | Nieograniczone rozpowszechnianie prac może być również korzystne dla początkującego autora
  | w budowaniu jego reputacji. Z kolei znany autor może opublikować fragmenty swoich prac,
  | aby wzbudzić zainteresowanie ich pełnymi wersjami rozpowszechnianymi innymi kanałami.
  | Licencja Creative Commons może pomóc w realizacji tego typu strategii przy zachowaniu
  | kontroli nad prawami autorskimi.

licensing-question-3 = Czym jest Creative Commons?

licensing-answer-3 =
  | Creative Commons to organizacja non-profit, która promuje kreatywne licencjonowanie i ponowne
  | wykorzystywanie twórczości intelektualnej. Cytując z ich strony internetowej:
  | „Creative Commons to międzynarodowy projekt oferujący darmowe rozwiązania prawne i inne
  | narzędzia służące zarządzaniu przez twórców prawami autorskimi do swoich utworów.
  | Creative Commons wspiera wolną kulturę: produkcję i wymianę utworów traktowanych
  | jako dobro wspólne..”

licensing-question-4 = Czy treść jest chroniona prawem autorskim i kto jest właścicielem praw?

licensing-answer-4 =
  | Wszystkie materiały są objęte ochroną prawem autorskim i autor zachowuje prawa autorskie do
  | swojego materiału. Równocześnie materiał jest udostępniany na licencji Creative Commons –
  | Uznanie autorstwa. Zgodnie z tą Licencją autor daje innym prawo do swobodnego kopiowania,
  | dystrybuowania oraz wyświetlania utworu, jak również do tworzenia utworów pochodnych pod
  | warunkiem, że zawsze będzie podpisany jako oryginalny autor oraz że link do Licencji
  | Creative Commons – Uznanie autorstwa pojawi się na każdej stronie zawierającej jego utwór.

licensing-question-5 = Jak autorzy udzielają licencji na swoje utwory udostępniane w repozytorium?

licensing-answer-5 =
  | Zanim będziesz mógł/mogła stworzyć swój zasób lub zbiór zasobów, musisz zgodzić się na
  | licencję Creative Commons - Uznanie autorstwa, która obowiązuje w odniesieniu do wszystkich
  | treści w repozytorium.

licensing-question-6 = Czy mogę rozpowszechniać lub wykorzystywać mój materiał w innych miejscach?

licensing-answer-6 =
  | Tak. Licencja Creative Commons jest „niewyłączna” – co oznacza, że możesz swobodnie udostępniać
  | swoje materiały na mocy innej licencji w innym miejscu, publikować je dla zysku, a także
  | przekształcać je bez wpływu na wersję znajdująca się w naszym repozytorium.

licensing-question-7 = Jak mogę kontrolować zmiany dokonywane w moich zasobach?

licensing-answer-7 =
  | Jedynie osoby, którym przydzielisz funkcję współautora Twojego zasobu mają uprawnienia do
  | modyfikowania i publikowania jego zaktualizowanych wersji. Jako autor zasobu określasz, kto
  | może być jego współautorem. Jednakże Licencja Creative Commons – Uznanie autorstwa pozwala
  | dowolnym osobom na dokonywanie <a href="../authoring/expressedit">adaptacji</a> treści
  | publikowanych w naszym repozytorium. Adaptacja to utwór zależny, będący modyfikacją
  | oryginalnego zasobu i opublikowany jako nowy zasób pod nazwiskiem nowego autora. Twój
  | oryginalny zasób pozostaje niezmieniony, a utwór pochodny zawiera informację, że to Ty jesteś
  | oryginalnym autorem, i link do oryginalnej wersji Twojego zasobu.

licensing-question-8 =
  | Ale chwila, czy nie przesłyszałem się, że Licencja daje ludziom prawo do
  | przerabiania mojego utworu?

licensing-answer-8 =
  | To prawda. Zgodnie z licencją, inny autor może stworzyć własny utwór na bazie Twojego.
  | Jednak jeśli ustalisz, że ktoś stworzył adaptację Twojego utworu, która jest niewłaściwa
  | lub sprzeczna z Twoją własną - lub, co gorsza, jest oszczercza lub w inny sposób obraźliwa -
  | licencja daje Ci prawo do poproszenia tej osoby o usunięcie Twojego nazwiska z zasobu –
  | ale nie do zażądania, żeby zmieniła go zgodnie z Twoim życzeniem. Jednym ze sposobów na
  | uniknięcie takich niepożądanych adaptacji jest zaproszenie tych autorów do Twojej grupy
  | roboczej i nawiązanie dialogu z nimi jako współpracownikami lub współautorami.

licensing-question-9 =
  | Co powstrzyma nieuczciwą osobę przed ukradzeniem mojej pracy i przedstawianiem jej jako własnej?

licensing-answer-9 =
  | Nic, z wyjątkiem prawa autorskiego. Licencja Creative Commons jest oparta na istniejącym prawie
  | autorskim i Twoje prace mają taką samą ochronę prawną i status prawny, jak utwory publikowane
  | poza naszym repozytorium, objęte ustawowym prawem autorskim. W rzeczy samej, mniejsze ryzyko
  | wiąże się z korzystaniem z naszego repozytorium niż z po prostu zamieszczeniem Twojego utworu
  | na własnej stronie internetowej, ponieważ licencja jest wyraźnie widoczna i jasno określa,
  | w jaki sposób można zgodnie z prawem wykorzystać Twój utwór. Mówiąc wprost, prawo autorskie
  | nie reguluje kwestii ścigania oszustw i plagiatów, ale jest dobrą pierwszą linią obrony.

licensing-question-10 = Czy inni ludzie mogą sprzedawać efekty mojej pracy?

licensing-answer-10 =
  | Jest to możliwe, o ile wybrana przez Ciebie licencja pozwala na jakiekolwiek „komercyjne”
  | zastosowania. To może być korzystne. Rozważ sytuację, w której jakaś firma oferuje
  | wydrukowanie Twojej pracy, aby studenci mieli dostęp do kopii papierowych. Bez licencji
  | umożliwiającej wykorzystanie komercyjne, taka firma nie mogłaby pobierać opłaty pokrywającej
  | koszty druku, oprawy i obsługi.

licensing-question-11 = No dobrze, ale co, jeśli jakiś duży wydawca zechce opublikować moją pracę?

licensing-answer-11 =
  | Jeśli wydawca będzie chciał włączyć Twój utwór do pracy zbiorowej, ma takie prawo na mocy
  | licencji; musi tylko wymienić Ciebie jako autora i właściciela praw autorskich. Z naszych
  | doświadczeń wynika jednak, że w takim przypadku większość poważnych wydawców woli renegocjować
  | z autorem nową licencję. Co więcej, jeśli naprawdę spodziewasz się, że otrzymasz tantiemy
  | za to, co piszesz, nasze repozytorium prawdopodobnie nie jest właściwym miejscem na publikację
  | Twojego utworu – choć może być właściwym miejscem na eksperymentowanie z jego wczesną wersją
  | lub wersją alternatywną.

licensing-question-12 =
  | Czy licencja Creative Commons – Uznanie autorstwa wpływa na zakres dozwolonego użytku?

licensing-answer-12 =
  | Nie. Licencja obejmuje sformułowanie: „Żadne postanowienie niniejszej Licencji nie zmierza
  | do ograniczenia, wyłączenia lub zawężenia sposobów korzystania nieobjętych prawem autorskim
  | lub uprawnień wynikających z ograniczeń lub wyjątków od ochrony prawa autorskiego wynikających
  | z przepisów prawa autorskiego lub innych znajdujących zastosowanie przepisów.” Dozwolony
  | użytek, doktryna pierwszej sprzedaży i inne podobne uprawnienia mają zastosowanie bez względu
  | na to, czy właściciel prawa autorskiego zgadza się na nie, czy nie.

licensing-question-13 =
  | Co muszę zrobić, jeśli chcę włączyć część utworu innego autora znajdującego się w repozytorium
  | do utworu, który tworzę poza repozytorium?

licensing-answer-13 =
  | Musisz właściwie oznakować autorstwo tej części oryginalnej pracy, którą wykorzystujesz poza
  | naszym repozytorium. Właściwe oznakowanie to po prostu podanie nazwiska oryginalnego autora
  | i wskazanie zakresu jego pracy w Twoim utworze. Oprócz tego musisz zamieścić informację
  | o prawie autorskim (licencji) i podać link(URL) do oryginalnej pracy w naszym repozytorium.

licensing-question-14 =
  | Co mam zrobić, jeśli pragnę włączyć utwór innego autora do zbioru, który tworzę?

licensing-answer-14 =
  | Po prostu dodaj utwór do swojego zbioru w narzędziu Collection Composer. Nasze oprogramowanie
  | automatycznie doda nazwisko oryginalnego autora do Twojego zbioru, podając odniesienie do
  | niego, zgodnie z wymogami licencji Creative Commons.

licensing-question-15 =
  | Czy mogę włączyć taki materiał do moich utworów pierwotnie opublikowanych poza bazą
  | i objętych ustawowym prawem autorskim?

licensing-answer-15 =
  | To proste pytanie dotyka kilku złożonych problemów prawnych. Najlepiej odpowie na nie
  | właściciel praw autorskich lub prawnik specjalizujący się w dziedzinie ochrony własności
  | intelektualnej. Możemy Ci tylko przypomnieć, że wszelka treść, jaką wprowadzasz do naszego
  | repozytorium, objęta jest licencją Creative Commons – Uznanie autorstwa, co oznacza, że
  | wszystko, co wykorzystujesz bezpośrednio w swoich materiałach w naszym repozytorium, musi być
  | możliwe do opublikowania zgodnie z prawem na mocy tej licencji. Na stronie
  | <a href="http://www.creativecommons.pl">Creative Commons Polska</a> znajdziesz informację,
  | które mogą wprowadzić Cię w temat prawa autorskiego i zasad ponownego wykorzystania materiałów
  | objętych prawem autorskim. Jeśli uzyskasz zgodę od posiadacza praw autorskich na wykorzystanie
  | materiału objętego prawem autorskim w swoich utworach, zalecamy włączenie tej zgody do
  | materiału, ponieważ w ten sposób wskażesz, kto jest właścicielem praw autorskich
  | do tego materiału.

licensing-question-16 =
  | Czy prawo “dopuszczonego użytku” pozwala mi na wykorzystanie materiału objętego prawem
  | autorskim w moich utworach w repozytorium?

licensing-answer-16 =
  | Może tak, może nie. Jest wiele czynników, które należy wziąć pod uwagę, zanim powołasz się na
  | „dozwolony użytek”, żeby wykorzystać materiał objęty prawem autorskim. To kolejne pytanie,
  | na które najlepiej odpowie właściciel praw autorskich lub prawnik specjalizujący się
  | w dziedzinie ochrony własności intelektualnej.

licensing-question-17 =
  | Jaki jest status prawny licencji Creative Commons poza Stanami Zjednoczonymi?

licensing-answer-17 =
  | Licencja Creative Commons została celowo sformułowania w taki sposób, aby była egzekwowana
  | w różnych systemach prawnych. Niemniej jednak Creative Commons nie uwzględnia każdego
  | najdrobniejszego niuansu w przepisach dotyczących prawa autorskiego obowiązujących
  | w różnych krajach czy stanach. Licencja Creative Commons zawiera klauzule „rozdzielności” –
  | co oznacza, że jeśli pewne zapisy uznane zostaną za niewykonalne w jakimś miejscu na świecie,
  | to tylko te zapisy nie zostaną uwyględnione, a pozostała część umowy licencyjnej pozostanie
  | w mocy.

# LICENSING - Content - src/scripts/pages/license/license-template.html



### ROLE ACCEPTANCES ###
# Content of the Role Acceptances page.

# ROLE ACCEPTANCES - Title - src/scripts/modules/role-acceptances/role-acceptances.coffee, src/scripts/pages/role-acceptance/role-acceptance.coffee

role-acceptances-pageTitle = Nadawanie uprawnień{$suffix}

# ROLE ACCEPTANCES - Content - src/scripts/modules/role-acceptances/role-acceptances-template.html

role-acceptances-title = Tytuł:

role-acceptances-role = Uprawnienia

role-acceptances-requester = Wnioskodawca

role-acceptances-assignment-date = Data przydzielenia

role-acceptances-license-i-license =
  | Udostępniam ten zasób na licencji <a href="{ $url }">Creative Commons Attribution License (CC-BY).</a>

role-acceptances-license-understand = Rozumiem,

role-acceptances-license-retain-copyright =
  | że zachowuję prawa autorskie do mojego dzieła

role-acceptances-license-warrant =
  | Oświadczam, że jestem autorem tego dzieła lub mam zgodę na jego udostępnienie

role-acceptances-license-wish =
  | Zgadzam się na publikację tego dzieła na licencji CC-BY
  | (<strong>co obejmuje zgodę na modyfikację pod warunkiem uznania
  | autorstwa</strong>)

role-acceptances-license-agree =
  | Zgadzam się na uznanie autorstwa mojej pracy w dowolnej formie zawierającej
  | nazwiska autorów, tytuł pracy oraz link do niej na OpenStax CNX

role-acceptances-success-alert =
  | <strong>Sukces.</strong> Twoje nowe ustawienia zostały zapisane



### OTHER CONTENT ###
# Content that does not yet fit into any particular category. Instead organized
# only by file location,

# OTHER CONTENT - Modal Processing - src/scripts/modules/media/body/processing-instructions/modals/processing-instructions-template.html

modal-add-processing = Dodaj wskazówki

modal-cancel = Anuluj

modal-insert = Wstaw

# OTHER CONTENT - Media Body - src/scripts/modules/media/body/body-template.html

media-loading = Ładowanie

# OTHER CONTENT - Editbar Block Publish - src/scripts/modules/media/editbar/block-publish/modals/block-publish-template.html

media-editbar-title-cannot-publish = Nie możesz publikować

media-editbar-body-cannot-publish = Nie możesz publikować z następujących powodów:

media-editbar-okay-button = OK

# OTHER CONTENT - Editbar License Template - src/scripts/modules/media/editbar/license/modals/license-template.html

media-editbar-header-change-license = Zmień licencję dla { $title }

media-editbar-license-note =
  | <em><strong>UWAGA</strong></em> - Zmiana licencji obejmie tę książkę
  | i jej wszystkie wciąż nieopublikowane strony.

media-editbar-license-cancel = Anuluj

media-editbar-button-change-license = Zmień licencję

# OTHER CONTENT - Editbar Section Template - src/scripts/modules/media/editbar/modals/list/section-template.html

media-editbar-list-publishing = publikacja

# OTHER CONTENT - Publish Template - src/scripts/modules/media/editbar/modals/publish-template.html

media-publish-template-publish = Publikacja

media-publish-template-i-license =
  | Udostępniam ten zasób na licencji <a href="{ $url }">{ $name } { $version }.</a>

media-publish-template-i-license-new-license =
  | Udostępniam ten zasób na licencji <a href="{ $url }">{ $name } { $version }.</a>
  | <br/>
  | (poprzednio <a href="{ $original-url }">{ $original-name } { $original-version }.</a>)

media-publish-template-understand = Rozumiem, że:

media-publish-template-understand-li-1 = Że zachowuję prawa autorskie do mojego dzieła
media-publish-template-understand-li-2 = Oświadczam, że jestem autorem tego dzieła lub mam zgodę na jego udostępnienie
media-publish-template-understand-li-3 =
  | Zgadzam się na publikację tego dzieła na licencji "{ $code }"
  | (<strong>co obejmuje zgodę na modyfikację pod warunkiem uznania autorstwa<strong>)
media-publish-template-understand-li-4 =
  | Zgadzam się na uznanie autorstwa mojej pracy w dowolnej formie zawierającej nazwiska autorów
  | tytuł pracy oraz link do niej na OpenStax CNX

media-publish-template-textarea-description =
  [html/placeholder] Dołącz opis wprowadzonych przez ciebie zmian (wymagane)

media-publish-template-items-to-publish = Elementy do publikacji

media-publish-template-cancel-button = Anuluj

media-publish-template-publish-button = Publikuj

# OTHER CONTENT - Media Latest Template - src/scripts/modules/media/latest/latest-template.html

media-latest-content = <a href="{ $url }">Nowsza wersja</a> { $type } jest już dostępna.

# OTHER CONTENTS - Minimal Search Results Table Partial - src/scripts/modules/minimal/search/results/list/table-partial.html

# OTHER CONTENT - Advanced Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

# OTHER CONTENT - Search Minimal Page Title - src/scripts/modules/minimal/search/advanced/advanced.coffee

# OTHER CONTENT - Legacy Template - src/scripts/pages/app/modals/legacy-template.html

legacy-template-warning-header = Uwaga

legacy-template-warning-message =
  | Przechodzisz do starej wersji serwisu CNX. Aby powrócić do tej strony,
  | użyj przycisku „wstecz” przeglądarki

legacy-template-remind-again = Nie przypominaj mi ponownie

legacy-template-cancel-button = Anuluj

legacy-template-go-button = Dalej

# OTHER CONTENT - Contents Out of Date Alert - src/scripts/pages/contents/contents-template.html

contents-alert-out-of-date =
  | Ta strona jest nieaktualna. <a href="" data-bypass="true">Odśwież</a>,
  | aby zobaczyć najnowszą wersję.

# OTHER CONTENT - Contents Library Page title and description - src/scripts/pages/contents/contents.coffee

content-library-pageTitle = Biblioteka zasobów{$suffix}

content-library-summary = Biblioteka zasobów OpenStax

content-library-description = Szukaj darmowych, cyfrowych książek.



### ERROR PAGE ###
# Example link: http://cnx.org/error
# Content related to the error pages.

# ERROR PAGE - Error Page - src/scripts/pages/error/error-template.html

error-page-oops = Ups!

error-page-oh-no-message =
  | O, nie!<br />Niestety, strona nie została znaleziona.<br />Spróbuj użyć
  | <a href="/search">wyszukiwania</a> aby znaleźć to, czego szukasz.

error-page-something-not-right-message =
  | Coś poszło nie tak!<br />Przepraszamy, w systemie wystąpił błąd.
  | <br />Spróbuj przeładować stronę. Jeśli to nie pomoże, spróbuj ponownie
  | po kilku minutach.

error-page-reason = { $code ->
  [403] Dostęp wzbroniony
  [404] Nie znaleziono
  [408] Request Timed Out
  [500] Wewnętrzny błąd serwera
  [503] Service Unavailable
 *[unknown] Nieznany błąd
}

error-page-reason-pageTitle = { error-page-reason[code] }{$suffix}


### MAINTENANCE ###
# Content related to the page that displays when the site is in maintenance.

# MAINTENANCE - Maintenance - src/maintenance.html

maintenance-openstax-cnx-title = Serwis jest obecnie niedostępny ze względu na prace konserwatorskie

maintenance-message = Dopracowujemy ostatnie szczegóły i zaraz wracamy!
