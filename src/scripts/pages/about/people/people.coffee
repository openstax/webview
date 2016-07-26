define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./people-template')
  require('less!./people')

  foundations = [{
    name: 'William and Flora Hewlett Foundation'
    image: 'wfhf.jpg'
    url: 'http://www.hewlett.org/'
    about: 'about-foundations-hewlett'
  }, {
    name: 'Gates Foundation'
    image: 'gates.jpg'
    url: 'http://www.gatesfoundation.org/'
    about: 'about-foundations-gates'
  }, {
    name: 'Maxfield Foundation'
    image: 'maxfield.png'
    url: ''
    about: 'about-foundations-maxfield'
  }, {
    name: 'Rice University'
    image: 'rice.jpg'
    url: 'http://www.rice.edu/'
    about: 'about-foundations-rice'
  }, {
    name: 'Laura and John Arnold Foundatation (LJAF)'
    image: 'ljaf.png'
    url: 'http://www.arnoldfoundation.org/'
    about: 'about-foundations-ljaf'
  }, {
    name: 'Twenty Million Minds Foundation'
    image: '20mm.png'
    url: 'http://www.20mm.org/'
    about: 'about-foundations-20mm'
  }, {
    name: 'Calvin K. Kazanjian'
    image: 'kazanjian.png'
    url: 'http://www.kazanjian.org'
    about: 'about-foundations-kazanjian'
  }, {
    name: 'Bill and Stephanie Sick Fund'
    image: 'sick-fund.gif'
    url: null
    about: 'about-foundations-sick'
  }]

  people = {
    advisors: [{
      name: 'Robert Maxfield'
      image: 'robert_maxfield.jpg'
    }, {
      name: 'William Sick'
      image: 'william_n_sick.jpg'
    }, {
      name: 'C. Sidney Burrus'
      image: 'c_sidney_burrus.jpg'
    }, {
      name: 'Susan Badger'
      image: 'susan_badger.png'
    }, {
      name: 'Eric C. Johnson'
      image: 'eric_c_johnson.jpg'
    }, {
      name: 'Stephan M. Schwanauer'
      image: 'stephan_m_schwanauer.jpg'
    }]

    members: [{
      name: 'Rich Baraniuk'
      image: 'richard_baraniuk.jpg'
      title: 'Director'
    }, {
      name: 'Daniel Williamson'
      image: 'daniel_williamson.jpg'
      title: 'Managing Director'
    }, {
      name: 'David Harris'
      image: 'david_harris.jpg'
      title: 'Editor in Chief'
    }, {
      name: 'Kathi Fletcher'
      image: 'kathi_fletcher.jpg'
      title: 'Technical Director'
    }, {
      name: 'Beth Cassidy'
      image: 'beth_cassidy.jpg'
      title: 'Director Finance & Operations'
    }, {
      name: 'Nicole Finkbeiner'
      image: 'nicole_finkbeiner.jpg'
      title: 'Assoc Dir Insitutional Relations'
    }, {
      name: 'Dani Nicholson'
      image: 'dani_nicholson.jpg'
      title: 'Asst Dir Communications'
    }, {
      name: 'Denver Greene'
      image: 'denver_greene.jpg'
      title: 'Digital Media Specialist'
    }, {
      name: 'Ed Woodward'
      image: 'ed_woodward.jpg'
      title: 'Senior Dev Manager'
    }, {
      name: 'Norm Woody'
      image: 'norm_woody.jpg'
      title: 'Project Manager'
    }, {
      name: 'Alana Lemay-Gibson'
      image: 'alana_lemay-gibson.jpg'
      title: 'Project Manager'
    }, {
      name: 'Alina Slavik'
      image: 'alina_slavik.jpg'
      title: 'Asst Dir Content Development'
    }, {
      name: 'Jeff Digiovanni'
      image: 'jeff_digiovanni.jpg'
      title: 'Asst Dir Customer Service'
    }, {
      name: 'Ross Reedstrom'
      image: 'ross_reedstrom.jpg'
      title: 'System Administrator'
    }, {
      name: 'Dennis Williamson'
      image: 'dennis_williamson.jpg'
      title: 'Systems Administrator'
    }, {
      name: 'Chris Nuber'
      image: 'chris_nuber.jpg'
      title: 'Systems Administrator'
    }, {
      name: 'JP Slavinksy'
      image: 'jp_slavinsky.jpg'
      title: 'Senior Developer'
    }, {
      name: 'Phil Schatz'
      image: 'phil_schatz.jpg'
      title: 'Senior Developer'
    }, {
      name: 'Kevin Burleigh'
      image: 'kevin_burleigh.jpg'
      title: 'Senior Developer'
    }, {
      name: 'Phil Grimaldi'
      image: 'phil_grimaldi.jpg'
      title: 'Research Scientist'
    }, {
      name: 'Drew Waters'
      image: 'drew_waters.jpg'
      title: 'Machine Learning Scientist'
    }, {
      name: 'Kim Davenport'
      image: 'kim_davenport.jpg'
      title: 'Product Analyst'
    }, {
      name: 'Micaela Mcglone'
      image: 'micaela_mcglone.jpg'
      title: 'Research Specialist'
    }, {
      name: 'Heather Seeba'
      image: 'heather_seeba.jpg'
      title: 'Research Specialist'
    }, {
      name: 'Greg Fitch'
      image: 'greg_fitch.jpg'
      title: 'Software Support Specialist'
    }, {
      name: 'Tory Watterson'
      image: 'tory_watterson.jpg'
      title: 'Accounting & Financial Analyst'
    }, {
      name: 'Jemel Agulto'
      image: 'jemel_agulto.jpg'
      title: 'Marketing & Communications Asst'
    }, {
      name: 'Kerwin So'
      image: 'kerwin_so.jpg'
      title: 'Quality Assurance Analyst'
    }, {
      name: 'Ryan Stickney'
      image: 'ryan_stickney.jpg'
      title: 'Digital Media Specialist'
    }, {
      name: 'Britney Blodget'
      image: 'britney_blodget.jpg'
      title: 'Digital Media Specialist'
    }, {
      name: 'Larissa Chu'
      image: 'larissa_chu.jpg'
      title: 'Digital Media Specialist'
    }, {
      name: 'Jason Holmes'
      image: 'jason_holmes.jpg'
      title: 'UX Manager'
    }, {
      name: 'Fred Lindner'
      image: 'fred_lindner.jpg'
      title: 'UX Visual Designer'
    }, {
      name: 'Derek Ford'
      image: 'derek_ford.jpg'
      title: 'Developer'
    }, {
      name: 'Dante Soares'
      image: 'dante_soares.jpg'
      title: 'Developer'
    }, {
      name: 'Zach Roehr'
      image: 'zach_roehr.jpg'
      title: 'Developer'
    }, {
      name: 'Helene McCarron'
      image: 'helene_mccarron.jpg'
      title: 'Developer'
    }, {
      name: 'Amber Webb'
      image: 'amber_webb.jpg'
      title: 'Developer'
    }, {
      name: 'Richard Hart'
      image: 'richard_hart.jpg'
      title: 'Developer'
    }, {
      name: 'Amanda Shih'
      image: 'amanda_shih.jpg'
      title: 'Developer'
    }, {
      name: 'Karen Chan'
      image: 'karen_chan.jpg'
      title: 'Developer'
    }, {
      name: 'Michael Mulich'
      image: 'michael.jpg'
      title: 'Developer'
    }, {
      name: 'Derek Kent'
      image: 'derek_kent.jpg'
      title: 'Developer'
    }, {
      name: 'Patrick Wolfert'
      image: 'patrick_wolfert.jpg'
      title: 'Developer'
    }, {
      name: 'Sonya Bennett Brandt'
      image: 'sonya_bennett_brandt.jpg'
      title: 'Social Media Assistant'
    }]
  }

  return class AboutPeopleView extends BaseView
    template: template
    templateHelpers:
      foundations: foundations
      advisors: people.advisors
      members: people.members
