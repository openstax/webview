define (require) ->
  linksHelper = require('cs!helpers/links')
  validationHelper = require('cs!helpers/validation')
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./form-template')
  require('less!./form')

  countries = [
    {code: 'US', name: 'United States'}
    {code: 'CA', name: 'Canada'}
    {code: 'AF', name: 'Afghanistan'}
    {code: 'AX', name: 'Aland Islands'}
    {code: 'AL', name: 'Albania'}
    {code: 'DZ', name: 'Algeria'}
    {code: 'AS', name: 'American Samoa'}
    {code: 'AD', name: 'Andorra'}
    {code: 'AO', name: 'Angola'}
    {code: 'AI', name: 'Anguilla'}
    {code: 'AQ', name: 'Antarctica'}
    {code: 'AG', name: 'Antigua and Barbuda'}
    {code: 'AR', name: 'Argentina'}
    {code: 'AM', name: 'Armenia'}
    {code: 'AW', name: 'Aruba'}
    {code: 'AU', name: 'Australia'}
    {code: 'AT', name: 'Austria'}
    {code: 'AZ', name: 'Azerbaijan'}
    {code: 'BS', name: 'Bahamas'}
    {code: 'BH', name: 'Bahrain'}
    {code: 'BD', name: 'Bangladesh'}
    {code: 'BB', name: 'Barbados'}
    {code: 'BY', name: 'Belarus'}
    {code: 'BE', name: 'Belgium'}
    {code: 'BZ', name: 'Belize'}
    {code: 'BJ', name: 'Benin'}
    {code: 'BM', name: 'Bermuda'}
    {code: 'BT', name: 'Bhutan'}
    {code: 'BO', name: 'Bolivia'}
    {code: 'BA', name: 'Bosnia and Herzegovina'}
    {code: 'BW', name: 'Botswana'}
    {code: 'BV', name: 'Bouvet Island'}
    {code: 'BR', name: 'Brazil'}
    {code: 'IO', name: 'British Indian Ocean Territory'}
    {code: 'BN', name: 'Brunei Darussalam'}
    {code: 'BG', name: 'Bulgaria'}
    {code: 'BF', name: 'Burkina Faso'}
    {code: 'BI', name: 'Burundi'}
    {code: 'KH', name: 'Cambodia'}
    {code: 'CM', name: 'Cameroon'}
    {code: 'CV', name: 'Cape Verde'}
    {code: 'KY', name: 'Cayman Islands'}
    {code: 'CF', name: 'Central African Republic'}
    {code: 'TD', name: 'Chad'}
    {code: 'CL', name: 'Chile'}
    {code: 'CN', name: 'China'}
    {code: 'CX', name: 'Christmas Island'}
    {code: 'CC', name: 'Cocos (Keeling) Islands'}
    {code: 'CO', name: 'Columbia'}
    {code: 'KM', name: 'Comoros'}
    {code: 'CG', name: 'Congo'}
    {code: 'CD', name: 'Congo - The Democratic Republic of the'}
    {code: 'CK', name: 'Cook Islands'}
    {code: 'CR', name: 'Costa Rica'}
    {code: 'HR', name: 'Croatia'}
    {code: 'CU', name: 'Cuba'}
    {code: 'CY', name: 'Cyprus'}
    {code: 'CZ', name: 'Czech Republic'}
    {code: 'DK', name: 'Denmark'}
    {code: 'DJ', name: 'Djibouti'}
    {code: 'DM', name: 'Dominica'}
    {code: 'DO', name: 'Dominican Republic'}
    {code: 'EC', name: 'Ecuador'}
    {code: 'EG', name: 'Egypt'}
    {code: 'SV', name: 'El Salvador'}
    {code: 'GQ', name: 'Equatorial Guinea'}
    {code: 'ER', name: 'Eritrea'}
    {code: 'EE', name: 'Estonia'}
    {code: 'ET', name: 'Ethiopia'}
    {code: 'FK', name: 'Falkland Islands (Malvinas)'}
    {code: 'FO', name: 'Faroe Islands'}
    {code: 'FJ', name: 'Fiji'}
    {code: 'FI', name: 'Finland'}
    {code: 'FR', name: 'France'}
    {code: 'GF', name: 'French Guiana'}
    {code: 'PF', name: 'French Polynesia'}
    {code: 'TF', name: 'French Southern Territories'}
    {code: 'GA', name: 'Gabon'}
    {code: 'GM', name: 'Gambia'}
    {code: 'GE', name: 'Georgia'}
    {code: 'DE', name: 'Germany'}
    {code: 'GH', name: 'Ghana'}
    {code: 'GI', name: 'Gibraltar'}
    {code: 'GR', name: 'Greece'}
    {code: 'GL', name: 'Greenland'}
    {code: 'GD', name: 'Grenada'}
    {code: 'GP', name: 'Guadeloupe'}
    {code: 'GU', name: 'Guam'}
    {code: 'GT', name: 'Guatemala'}
    {code: 'GG', name: 'Guernsey'}
    {code: 'GN', name: 'Guinea'}
    {code: 'GW', name: 'Guinea-Bissau'}
    {code: 'GY', name: 'Guyana'}
    {code: 'HT', name: 'Haiti'}
    {code: 'HM', name: 'Heard Island and McDonald Islands'}
    {code: 'VA', name: 'Holy See (Vatican City State)'}
    {code: 'HN', name: 'Honduras'}
    {code: 'HK', name: 'Hong Kong'}
    {code: 'HU', name: 'Hungary'}
    {code: 'IS', name: 'Iceland'}
    {code: 'IN', name: 'India'}
    {code: 'ID', name: 'Indonesia'}
    {code: 'IR', name: 'Iran - Islamic Republic of'}
    {code: 'IQ', name: 'Iraq'}
    {code: 'IE', name: 'Ireland'}
    {code: 'IM', name: 'Isle of Man'}
    {code: 'IL', name: 'Israel'}
    {code: 'IT', name: 'Italy'}
    {code: 'JM', name: 'Jamaica'}
    {code: 'JP', name: 'Japan'}
    {code: 'JE', name: 'Jersey'}
    {code: 'JO', name: 'Jordan'}
    {code: 'KZ', name: 'Kazakhstan'}
    {code: 'KE', name: 'Kenya'}
    {code: 'KI', name: 'Kiribati'}
    {code: 'KP', name: 'Korea - Democratic Peoples Republic of'}
    {code: 'KR', name: 'Korea - Republic of'}
    {code: 'KW', name: 'Kuwait'}
    {code: 'KG', name: 'Kyrgyzstan'}
    {code: 'LA', name: 'Lao Peoples Democratic Republic'}
    {code: 'LV', name: 'Latvia'}
    {code: 'LB', name: 'Lebanon'}
    {code: 'LS', name: 'Lesotho'}
    {code: 'LR', name: 'Liberia'}
    {code: 'LY', name: 'Libyan Arab Jamahiriya'}
    {code: 'LI', name: 'Liechtenstein'}
    {code: 'LT', name: 'Lithuania'}
    {code: 'LU', name: 'Lexembourg'}
    {code: 'MO', name: 'Macao'}
    {code: 'MK', name: 'Macedonia - The Former Yugoslav Republic of'}
    {code: 'MG', name: 'Madagascar'}
    {code: 'MW', name: 'Malawi'}
    {code: 'MY', name: 'Malaysia'}
    {code: 'MV', name: 'Maldives'}
    {code: 'ML', name: 'Mali'}
    {code: 'MT', name: 'Malta'}
    {code: 'MH', name: 'Marshall Islands'}
    {code: 'MQ', name: 'Martinique'}
    {code: 'MR', name: 'Mauritania'}
    {code: 'MU', name: 'Mauritius'}
    {code: 'YT', name: 'Mayotte'}
    {code: 'MX', name: 'Mexico'}
    {code: 'FM', name: 'Micronesia - Federated States of'}
    {code: 'MD', name: 'Moldova'}
    {code: 'MC', name: 'Monaco'}
    {code: 'MN', name: 'Mongolia'}
    {code: 'ME', name: 'Montenegro'}
    {code: 'MS', name: 'Montserrat'}
    {code: 'MA', name: 'Morocco'}
    {code: 'MZ', name: 'Mozambique'}
    {code: 'MM', name: 'Myanmar'}
    {code: 'NA', name: 'Namibia'}
    {code: 'NR', name: 'Nauru'}
    {code: 'NP', name: 'Nepal'}
    {code: 'NL', name: 'Netherlands'}
    {code: 'AN', name: 'Netherlands Antilles'}
    {code: 'NC', name: 'New Caledonia'}
    {code: 'NZ', name: 'New Zealand'}
    {code: 'NI', name: 'Nicaragua'}
    {code: 'NE', name: 'Niger'}
    {code: 'NG', name: 'Nigeria'}
    {code: 'NU', name: 'Niue'}
    {code: 'NF', name: 'Norfolk Island'}
    {code: 'MP', name: 'Northern Mariana Islands'}
    {code: 'NO', name: 'Norway'}
    {code: 'OM', name: 'Oman'}
    {code: 'PK', name: 'Pakistan'}
    {code: 'PW', name: 'Palau'}
    {code: 'PS', name: 'Palestinian Territory - Occupied'}
    {code: 'PA', name: 'Panama'}
    {code: 'PG', name: 'Papua New Guinea'}
    {code: 'PY', name: 'Paraguay'}
    {code: 'PE', name: 'Peru'}
    {code: 'PH', name: 'Philippines'}
    {code: 'PN', name: 'Pitcairn'}
    {code: 'PL', name: 'Poland'}
    {code: 'PT', name: 'Portugal'}
    {code: 'PR', name: 'Puerto Rico'}
    {code: 'QA', name: 'Qatar'}
    {code: 'RE', name: 'Reunion'}
    {code: 'RO', name: 'Romania'}
    {code: 'RU', name: 'Russian Federation'}
    {code: 'RW', name: 'Rwanda'}
    {code: 'BL', name: 'Saint Barthelemy'}
    {code: 'SH', name: 'Saint Helena'}
    {code: 'KN', name: 'Saint Kitts and Nevis'}
    {code: 'LC', name: 'Saint Lucia'}
    {code: 'MF', name: 'Saint Martin'}
    {code: 'PM', name: 'Saint Pierre and Miquelon'}
    {code: 'VC', name: 'Saint Vincent and the Grenadines'}
    {code: 'WS', name: 'Samoa'}
    {code: 'SM', name: 'San Marino'}
    {code: 'ST', name: 'Sao Tome and Principe'}
    {code: 'SA', name: 'Saudi Arabia'}
    {code: 'SN', name: 'Senegal'}
    {code: 'RS', name: 'Serbia'}
    {code: 'SC', name: 'Seychelles'}
    {code: 'SL', name: 'Sierra Leone'}
    {code: 'SG', name: 'Singapore'}
    {code: 'SK', name: 'Slovakia'}
    {code: 'SI', name: 'Slovenia'}
    {code: 'SB', name: 'Solomon Islands'}
    {code: 'SO', name: 'Somalia'}
    {code: 'ZA', name: 'South Africa'}
    {code: 'GS', name: 'South Georgia and the South Sandwich Islands'}
    {code: 'ES', name: 'Spain'}
    {code: 'LK', name: 'Sri Lanka'}
    {code: 'SD', name: 'Sudan'}
    {code: 'SR', name: 'Suriname'}
    {code: 'SJ', name: 'Svalbard and Jan Mayen'}
    {code: 'SZ', name: 'Swaziland'}
    {code: 'SE', name: 'Sweden'}
    {code: 'CH', name: 'Switzerland'}
    {code: 'SY', name: 'Syrian Arab Republic'}
    {code: 'TW', name: 'Taiwan - Province of China'}
    {code: 'TJ', name: 'Tajikistan'}
    {code: 'TZ', name: 'Tanzania - United Republic of'}
    {code: 'TH', name: 'Thailand'}
    {code: 'TL', name: 'Timor-Leste'}
    {code: 'TG', name: 'Togo'}
    {code: 'TK', name: 'Tokelau'}
    {code: 'TO', name: 'Tonga'}
    {code: 'TT', name: 'Trinidad and Tobago'}
    {code: 'TN', name: 'Tunisia'}
    {code: 'TR', name: 'Turkey'}
    {code: 'TM', name: 'Turkmenistan'}
    {code: 'TC', name: 'Turks and Caicos Islands'}
    {code: 'TV', name: 'Tuvalu'}
    {code: 'UG', name: 'Uganda'}
    {code: 'UA', name: 'Ukraine'}
    {code: 'AE', name: 'United Arab Emirates'}
    {code: 'GB', name: 'United Kingdom'}
    {code: 'UM', name: 'United States Minor Outlying Islands'}
    {code: 'UY', name: 'Uruguay'}
    {code: 'UZ', name: 'Uzbekistan'}
    {code: 'VU', name: 'Vanuatu'}
    {code: 'VE', name: 'Venezuela'}
    {code: 'VN', name: 'Viet Nam'}
    {code: 'VG', name: 'Virgin Islands - British'}
    {code: 'VI', name: 'Virgin Islands - U.S.'}
    {code: 'WF', name: 'Wallis and Futuna'}
    {code: 'EH', name: 'Western Sahara'}
    {code: 'YE', name: 'Yemen'}
    {code: 'ZM', name: 'Zambia'}
    {code: 'ZW', name: 'Zimbabwe'}
  ]

  states = [
    {code: '--', name: 'Not Applicable'}
    {code: 'AL', name: 'Alabama'}
    {code: 'AK', name: 'Alaska'}
    {code: 'AZ', name: 'Arizona'}
    {code: 'AR', name: 'Arkansas'}
    {code: 'CA', name: 'California'}
    {code: 'CO', name: 'Colorado'}
    {code: 'CT', name: 'Connecticut'}
    {code: 'DE', name: 'Delaware'}
    {code: 'FL', name: 'Florida'}
    {code: 'GA', name: 'Georgia'}
    {code: 'HI', name: 'Hawaii'}
    {code: 'ID', name: 'Idaho'}
    {code: 'IL', name: 'Illinois'}
    {code: 'IN', name: 'Indiana'}
    {code: 'IA', name: 'Iowa'}
    {code: 'KS', name: 'Kansas'}
    {code: 'KY', name: 'Kentucky'}
    {code: 'LA', name: 'Louisiana'}
    {code: 'ME', name: 'Maine'}
    {code: 'MD', name: 'Maryland'}
    {code: 'MA', name: 'Massachusetts'}
    {code: 'MI', name: 'Michigan'}
    {code: 'MN', name: 'Minnesota '}
    {code: 'MO', name: 'Missouri'}
    {code: 'MS', name: 'Mississippi'}
    {code: 'MT', name: 'Montana'}
    {code: 'NE', name: 'Nebraska'}
    {code: 'NV', name: 'Nevada'}
    {code: 'NH', name: 'New Hampshire'}
    {code: 'NJ', name: 'New Jersey'}
    {code: 'NM', name: 'New Mexico'}
    {code: 'NY', name: 'New York'}
    {code: 'NC', name: 'North Carolina'}
    {code: 'ND', name: 'North Dakota'}
    {code: 'OH', name: 'Ohio'}
    {code: 'OK', name: 'Oklahoma'}
    {code: 'OR', name: 'Oregon'}
    {code: 'PA', name: 'Pennsylvania'}
    {code: 'RI', name: 'Rhode Island'}
    {code: 'SC', name: 'South Carolina'}
    {code: 'SD', name: 'South Dakota'}
    {code: 'TN', name: 'Tennessee'}
    {code: 'TX', name: 'Texas'}
    {code: 'UT', name: 'Utah'}
    {code: 'VT', name: 'Vermont'}
    {code: 'VA', name: 'Virginia'}
    {code: 'WA', name: 'Washington'}
    {code: 'WV', name: 'West Virginia'}
    {code: 'WI', name: 'Wisconsin'}
    {code: 'WY', name: 'Wyoming'}
    {code: 'AS', name: 'American Samoa'}
    {code: 'DC', name: 'District of Columbia '}
    {code: 'FM', name: 'Federated States of Micronesia'}
    {code: 'GU', name: 'Guam'}
    {code: 'MP', name: 'Northern Mariana Islands'}
    {code: 'PW', name: 'Palau'}
    {code: 'PR', name: 'Puerto Rico'}
    {code: 'VI', name: 'Virgin Islands'}
    {code: 'AA', name: 'Armed Forces Americas'}
    {code: 'AE', name: 'Armed Forces Europe'}
    {code: 'AP', name: 'Armed Forces Pacific'}
    {code: 'AB', name: 'Alberta '}
    {code: 'BC', name: 'British Columbia'}
    {code: 'MB', name: 'Manitoba'}
    {code: 'NB', name: 'New Brunswick'}
    {code: 'NF', name: 'Newfoundland'}
    {code: 'NT', name: 'Northwest Territories'}
    {code: 'NS', name: 'Nova Scotia'}
    {code: 'ON', name: 'Ontario'}
    {code: 'PE', name: 'Prince Edward Island'}
    {code: 'PQ', name: 'Province du Quebec'}
    {code: 'SK', name: 'Saskatchewan'}
    {code: 'YT', name: 'Yukon Territory'}
    {code: 'ZZ', name: 'Not Applicable'}
  ]

  return class DonateFormView extends BaseView
    template: template
    templateHelpers:
      countries: countries
      states: states
      amount: () -> @amount
      successUrl: () ->
        url = "#{location.protocol}//#{location.host}/donate/thankyou"
        url += "/#{@uuid}/#{@type}" if @uuid and @type
        return url
      cancelUrl: () ->
        url = "#{location.protocol}//#{location.host}/donate"
        url += "/download/#{@uuid}/#{@type}" if @uuid and @type
        return url

    events:
      'submit form': 'onSubmit'
      'change input': 'checkForValidity'

    formConversions: [{
      name: 'BILL_NAME'
      value: ($form) ->
        first = $form.find('input[name="First_Name"]').val()
        last = $form.find('input[name="Last_Name"]').val()
        suffix = $form.find('input[name="Suffix"]').val()

        name = first if first
        name += " #{last}" if last
        name += " #{suffix}" if suffix

        return name
    }, {
      name: 'Donation_Amount'
      value: 'AMT'
    }, {
      name: 'TNE_Customer_Email'
      value: 'BILL_EMAIL_ADDRESS'
    }, {
      name: 'Email'
      value: 'BILL_EMAIL_ADDRESS'
    }, {
      name: 'Mailing_Address'
      value: 'BILL_STREET1'
    }, {
      name: 'Mailing_Address2'
      value: 'BILL_STREET2'
    }, {
      name: 'Mailing_City'
      value: 'BILL_CITY'
    }, {
      name: 'Mailing_State'
      value: 'BILL_STATE'
    }, {
      name: 'Mailing_Zip'
      value: 'BILL_POSTAL_CODE'
    }, {
      name: 'Mailing_Country'
      value: 'BILL_COUNTRY'
    }]

    initialize: () ->
      super()
      queryString = linksHelper.serializeQuery(location.search)
      @amount = parseFloat(queryString.amount?.replace(',', '')) or 10
      @uuid = queryString.uuid
      @type = queryString.type

    checkForValidity: (e) ->
      validationHelper.checkForValidity(e)

    onRender: () ->
      # Ugly way to wait for l20n to translate the countreies list
      # since document.l10n.ready method & 'DOMRetranslated' event dosen't work in l20n.
      setTimeout =>
        sorted = @$el.find('#country-list option').sort (a,b) ->
          a.text.toLowerCase().localeCompare b.text.toLowerCase()
        # Apply sorted list.
        @$el.find("#country-list").empty().append sorted        
       , 100

    onSubmit: (e) ->
      if validationHelper.validateRequiredFields()
        $form = @$el.find('form')

        _.each @formConversions, (conversion) ->
          value = conversion.value?($form) or
            $form.find("input[name=\"#{conversion.value}\"], select[name=\"#{conversion.value}\"]").val()

          $form.find("input[name=\"#{conversion.name}\"]").val(value)
      else
        e.preventDefault()
