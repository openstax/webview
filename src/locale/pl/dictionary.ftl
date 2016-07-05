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

main-learn-more = Ucz Się Więcej

# MAIN PAGE - Title - src/scripts/pages/home/home.coffee

home-pageTitle = Propagując wiedzę i budując społeczności - OpenStax CNX

# MAIN PAGE - Featured Textbooks - src/scripts/modules/featured-books/featured-books-partial.html



### HEADER ###
# Content located in the header on each page. This includes the navigation
# and account interface.

# HEADER - Top Right Message - src/scripts/modules/header/header-template.html

all-cnx-author-legacy-site = Autor CNX | Stara Strona
  [html/title] Przejdź do starej wersji CNX

# HEADER - Nav Bar - src/scripts/modules/header/header-template.html

all-navbar-search = Szukaj

all-navbar-about-us = O nas

all-navbar-give = Wesprzyj nas

all-navbar-workspace = Moje biurko

all-header-skip-to-content =

all-header-skip-to-results =

all-header-account-profile = Ustawienia konta

all-header-log-out = Wyloguj { $username }

all-navbar-toggle-navigation = Przełącz nawigację

all-header-support = Pomoc
  [html/title] Przejdź do strony pomocy CNX



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

# ABOUT - Foundations - src/scripts/pages/about/people/people-template.html & src/scripts/pages/about/people/people.coffee

about-foundations-hewlett =
  | William and Flora Hewlett Foundation od 1967 roku sponsoruje inicjatywy
  | zmierzające do rozwiązania problemów społecznych i przyrodniczych w USA i
  | na całym świecie. Szczególną uwagę Fundacja poświęca edukacji, środowisku
  | naturalnemu, rozwojowi świata i jego populacji, sztuce aktorskiej i
  | działalności charytatywnej, w tym wspierając trudne środowiska w rejonie
  | Zatoki San Francisco.

about-foundations-gates =
  | Wiedziona przekonaniem, że każde życie ma taką samą wartość, Bill &amp;
  | Melinda Gates Foundation stara się pomóc wszystkim ludziom żyć zdrowiej i
  | owocniej. W krajach rozwijających się Fundacja skupia się na polepszeniu
  | zdrowia ludzi poprzez programy szczepień i inne ratujące życie, dając im
  | jednocześnie narzędzia do wyrwania się z głodu i skrajnej biedy. W Stanach
  | Zjednoczonych stara się polepszyć jakość edukacji, aby wszyscy młodzi
  | ludzie mogli zrealizować swój pełny potencjał. Fundacja ma siedzibę w
  | Seattle w stanie Washington. Kierują nią Jeff Raikes (CEO) i William H.
  | Gates Senior, według wskazań Billa i Melindy Gatesów i Warrena Buffetta.

about-foundations-maxfield =
  | Maxfield Foundation wspiera inicjatywy z dużym potencjałem dla nauki,
  | edukacji, zrównoważonego wzrostu i innych obszarów kluczowych dla
  | społeczeństwa.

about-foundations-rice =
  | Jako jeden z czołowych ośrodków zarówno naukowych jak i akademickich Rice
  | University aspiruje do najwyższych standardów w zakresie badań i nauczania,
  | a także pragnie mieć znaczący wkład w ulepszanie naszego świata. Aby
  | wypełnić tę misję, tworzy bogatą wspólnotę ludzi z pasją do nauki i
  | odkrywania, która wydaje z siebie liderów wszelkich inicjatyw, jakie
  | podejmuje ludzkość.

about-foundations-ljaf =
  | Laura and John Arnold Foundation (LJAF) aktywnie szuka sposobności do
  | wspierania organizacji i liderów, którzy mają szczery zamiar wprowadzania
  | fundamentalnych zmian nie tylko w celu zaspokojenia bieżących potrzeb, ale
  | też w celu naprawienia źle działających systemów dla przyszłych pokoleń.
  | LJAF obecnie koncentruje się na edukacji, wymiarze sprawiedliwości,
  | integracji badań naukowych i kwestii rozliczania instytucji publicznych z
  | powierzonych im obowiązków.

about-foundations-20mm =
  | Misją Twenty Million Minds Foundation jest polepszanie dostępności i szans
  | na sukces poprzez usuwanie przeszkód finansowych. Wspieramy tworzenie,
  | udostępnianie i rozpowszechnianie skutecznych i niedrogich zasobów
  | edukacyjnych poprzez inwestowanie w innowacje, otwarte narzędzia edukacyjne
  | i nowe modele współpracy pomiędzy firmami, organizacjami i instytucjami.

about-foundations-kazanjian =
  | Calvin K. Kazanjian był założycielem i prezesem firmy Peter Paul Inc.,
  | produkującej batony Mounds i Almond Joy i mieszczącej się w Naugatuck w
  | stanie Connecticut. Był głęboko przekonany, że gdyby więcej ludzi znało
  | podstawy ekonomii, świat byłby lepszy. Dlatego kierując się autentyczną
  | dobrą wolą powołał do życia Fundację. Jak stwierdził, chciałby "pomóc
  | osiągnąć szczęście i zamożność wszystkim ludziom poprzez nauczenie ich
  | ekonomii". Calvin K. Kazanjian Economics Foundation Inc. to apolityczna
  | fundacja edukacyjna zarejestrowana w 1947 roku na mocy prawa stanu
  | Connecticut.

about-foundations-sick =
  | Bill and Stephanie Sick Fund wspiera innowacyjne projekty z dziedziny
  | edukacji, sztuki, nauki oraz inżynierii.



### PEOPLE ###
# Link: http://cnx.org/about/people
# Content on the People page among the about pages.

# PEOPLE - People - src/scripts/pages/about/people/people-template.html

about-people-header = Ludzie

about-people-foundation-header = Darczyńcy

about-people-foundation-content =
  | OpenStax College jest wdzięczny za
  | ogromne wsparcie ze strony sponsorów. Bez ich głębokiego
  | zaangażowania, realizacja naszej misji upowszechniania
  | darmowego dostępu do najwyższej jakości podręczników byłaby poza naszym zasięgiem.

about-people-strategic-advisors = Doradcy

about-people-team-header = Zespół OpenStax College

about-people-team-content =
  | OpenStax College powstał dzięki grupie
  | specjalistów od otwartych zasobów edukacyjnych, którzy postanowili
  | polepszyć dostęp do wysokiej jakości podręczników dla studentów i nauczycieli z całego świata.



### CONTACT ###
# Link: http://cnx.org/about/contact
# Content on the Contact page among the about pages.

# CONTACT - Content - src/scripts/pages/about/contact/contact-template.html

about-contact-google-maps = Mapa Google™

about-contact-header = Kontakt

about-contact-phone = Telefon: { $phone }

about-contact-email = E-mail: <a href="mailto:{ $email }">{ $email }</a>

about-contact-questions-header = Masz pytanie?

about-contact-questions-content = Napisz do nas, jeśli potrzebujesz dodatkowych informacji.

about-contact-technical-support-header = Pomoc techniczna

about-contact-technical-support-content =
  | W przypadku problemów technicznych na naszej stronie prosimy o wysłanie wiadomości e-mail na adres
  | <a href="mailto:techsupport@cnx.org">techsupport@cnx.org</a>.
  | Możesz również wysłać raport o błędzie przy użyciu formularza do zgłaszania błędów.

about-contact-general-questions-header = Pytania ogólne

about-contact-general-questions-content =
  | Jeśli masz pytania dotyczące naszego serwisu, chcesz zapisać się na
  | szkolenie dla autorów lub uzyskać inne informacje na temat Openstax CNX,
  | wyślij e-mail na adres <a href="mailto:cnx@cnx.org">cnx@cnx.org</a>.



### SEARCH ###
# Link: http://cnx.org/browse
# Content on the page with subject categories.

# SEARCH - Page Summary and Description - src/scripts/pages/search/search.coffee

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
  | <strong>modułów</strong>, stanowiących małe "porcje wiedzy," oraz
  | <strong>kolekcji</strong>, stanowiących zestawy modułów ułożone w formę
  | książki, kursu lub kompletu o innym przeznaczeniu. Otwarte licencje
  | pozwalają na swobodne użytkowanie wszystkich zasobów.

search-pages = Strony: { $count }

search-books = Książki: { $count }



### ADVANCED SEARCH ###
# Link: http://cnx.org/search
# Content related to the advanced search form.

# ADVANCED SEARCH - Page Title - src/scripts/modules/search/advanced/advanced.coffee

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

advanced-search-sort-default-relevance = Trafności

advanced-search-sort-publication-date = Roku publikacji

advanced-search-sort-popularity = Popularności

advanced-search-submit = Wybierz

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

textbook-view-btn-edit = Edytuj

textbook-view-btn-create = Utwórz kopię do edycji

textbook-view-book-by =
  | Utworzone przez: <span class="collection-authors">{ TAKE(50, $authors) }</span>

textbook-view-page-by =
  | Utworzone przez: <span class="collection-authors">{ TAKE(50, $authors) }</span>

# TEXTBOOK VIEW - Downloads - src/scripts/modules/media/footer/downloads/downloads-template.html

textbook-view-downloads-header = Do pobrania

textbook-view-loading = Ładowanie

textbook-view-loading-more-details-btn = Więcej szczegółów

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

# TEXTBOOK VIEW - Endorsement - src/scripts/modules/media/endorsed/endorsed-template.html

textbook-view-endorsed-by = Zatwierdzone przez: OpenStax College

# TEXTBOOK VIEW - Header - src/scripts/modules/media/header/header-template.html

textbook-view-btn-create-copy = Utwórz kopię do edycji

textbook-view-btn-edit-page = Edytuj stronę

textbook-view-btn-jump-to-concept-coach = Idź do Concept Coach

textbook-view-btn-get-this-book = Weź tę książkę!

textbook-view-btn-get-this-page = Weź tę stronę!

textbook-view-summary = Podsumowanie

textbook-view-header-publishing = <span class="label label-info">publikujesz</span> { $title }

textbook-view-header-publishing-chapter =
  | <span class="label label-info">publikujesz</span> <span class="title-chapter">{ $chapter }</span> { $title }

textbook-view-header-no-publishing = { $title }

textbook-view-header-no-publishing-chapter = <span class="title-chapter">{ $chapter }</span> { $title }

textbook-view-header-derived-from =
  | Utworzone z <a href="{ $url }">{ $title }</a> przez <span class="book-authors">{ TAKE(50, $authors) }</span>

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
  | Nazwa OpenStax College, logo OpenStax College, okładki książek OpenStax College,
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

# TEXTBOOK VIEW - Footer Toggle - src/scripts/modules/media/footer/inherits/tab/toggle-partial.html

# TEXTBOOK VIEW - Footer license - src/scripts/modules/media/footer/license/license-template.html

# TEXTBOOK VIEW - Table of Content Search - src/scripts/modules/media/tabs/contents/toc/page-template.html



### MY WORKSPACE ###
# Content related to the user starting the creation of a new textbook or viewing
# the current books in their workspace.

# MY WORKSPACE - Header and Buttons - src/scripts/modules/workspace/workspace-template.html

workspace-header = Moje biurko

workspace-button-new = Nowa

workspace-button-recently-published = Ostatnio opublikowane

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
