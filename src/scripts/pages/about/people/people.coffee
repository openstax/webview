define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./people-template')
  require('less!./people')

  foundations = [{
    name: 'William and Flora Hewlett Foundation'
    image: 'wfhf.jpg'
    url: 'http://www.hewlett.org/'
    about: 'The William and Flora Hewlett Foundation has been making grants since 1967 to help
            solve social and environmental problems at home and around the world. The Foundation
            concentrates its resources on activities in education, the environment, global development
            and population, performing arts, and philanthropy, and makes grants to support disadvantaged
            communities in the San Francisco Bay Area.'
  }, {
    name: 'Gates Foundation'
    image: 'gates.jpg'
    url: 'http://www.gatesfoundation.org/'
    about: 'Guided by the belief that every life has equal value, the Bill &amp; Melinda Gates
            Foundation works to help all people lead healthy, productive lives. In developing countries,
            it focuses on improving people’s health with vaccines and other life-saving tools and giving
            them the chance to lift themselves out of hunger and extreme poverty. In the United States,
            it seeks to significantly improve education so that all young people have the opportunity to
            reach their full potential. Based in Seattle, Washington, the foundation is led by CEO Jeff
            Raikes and Co-chair William H. Gates Sr., under the direction of Bill and Melinda Gates
            and Warren Buffett.'
  }, {
    name: 'Maxfield Foundation'
    image: 'maxfield.png'
    url: ''
    about: 'The Maxfield Foundation supports projects with potential for high impact in science,
            education, sustainability, and other areas of social importance.'
  }, {
    name: 'Rice University'
    image: 'rice.jpg'
    url: 'http://www.rice.edu/'
    about: 'As a leading research university with a distinctive commitment to undergraduate education,
            Rice University aspires to pathbreaking research, unsurpassed teaching, and contributions
            to the betterment of our world. It seeks to fulfill this mission by cultivating a diverse
            community of learning and discovery that produces leaders across the spectrum of human endeavor.'
  }, {
    name: 'Laura and John Arnold Foundatation (LJAF)'
    image: 'ljaf.png'
    url: 'http://www.arnoldfoundation.org/'
    about: 'Laura and John Arnold Foundation (LJAF) actively seeks opportunities to invest in
            organizations and thought leaders that have a sincere interest in implementing fundamental
            changes that not only yield immediate gains, but also repair broken systems for future generations.
            LJAF currently focuses its strategic investments on education, criminal justice, research integrity,
            and public accountability.'
  }, {
    name: 'Twenty Million Minds Foundation'
    image: '20mm.png'
    url: 'http://www.20mm.org/'
    about: 'Our mission at the Twenty Million Minds Foundation is to grow access and success by eliminating
            unnecessary hurdles to affordability.  We support the creation, sharing, and proliferation of
            more effective, more affordable educational content by leveraging disruptive technologies,
            open educational resources, and new models for collaboration between for-profit, nonprofit,
            and public entities.'
  }, {
    name: 'Calvin K. Kazanjian'
    image: 'kazanjian.png'
    url: 'http://www.kazanjian.org'
    about: 'Calvin K. Kazanjian was the founder and president of Peter Paul Inc., the maker of the Mounds
            and Almond Joy candy bars, located in Naugatuck, Connecticut. He firmly believed that if more
            people understood basic economics the world would be a better place in which to live.
            Accordingly, he established the Foundation in the true spirit of unselfish service.
            In his own words, he wished to “help bring a greater happiness and prosperity to all,
            through a better understanding of economics.” The Calvin K. Kazanjian Economics Foundation Inc.
            is a non-political education organization that was incorporated as a nonprofit organization
            under the Statue Laws of the State of Connecticut on April 4, 1947.'
  }]

  people = {
    advisors: [{
      name: 'Robert Maxfield'
      image: 'robert_maxfield.jpg'
    }, {
      name: 'William Sick'
      image: 'william_sick.jpg'
    }, {
      name: 'C. Sidney Burrus'
      image: 'csb.jpg'
    }, {
      name: 'Stephan M. Schwanauer'
      image: 'schwanauer.jpg'
    }]

    members: [{
      name: 'Rich Baraniuk'
      image: 'richb.jpg'
      title: 'Director'
    }, {
      name: 'David Harris'
      image: 'david.jpg'
      title: 'Editor in Chief'
    }, {
      name: 'Daniel Williamson'
      image: 'daniel.jpg'
      title: 'Managing Director'
    }, {
      name: 'Ed Woodward'
      image: 'ed.jpg'
      title: 'Technical Director'
    }, {
      name: 'Beth Cassidy'
      image: 'beth.jpg'
      title: 'Director Finance & Operations'
    }, {
      name: 'Ross Reedstrom'
      image: 'ross.jpg'
      title: 'Systems Administrator'
    }, {
      name: 'Dani Nicholson'
      image: 'dani.jpg'
      title: 'Asst Dir Communications'
    }, {
      name: 'JP Slavinsky'
      image: 'jp.jpg'
      title: 'Web Developer'
    }, {
      name: 'Charmaine St. Rose'
      image: 'charmaine.jpg'
      title: 'Administrative Assistant'
    }, {
      name: 'Phil Schatz'
      image: 'phil.jpg'
      title: 'Developer'
    }, {
      name: 'Ryan Stickney'
      image: 'ryan.jpg'
      title: 'Digital Media Specialist'
    }, {
      name: 'Denver Greene'
      image: 'denver.jpg'
      title: 'Digital Media Specialist'
    }, {
      name: 'Stacey Yates'
      image: 'stacey.jpg'
      title: 'Developer'
    }, {
      name: 'Derek Ford'
      image: 'derek_ford.jpg'
      title: 'Developer'
    }, {
      name: 'Michael Mulich'
      image: 'michael.jpg'
      title: 'Developer'
    }, {
      name: 'Derek Kent'
      image: 'derek.jpg'
      title: 'Developer'
    }, {
      name: 'Karen Chan'
      image: 'karen.jpg'
      title: 'Developer'
    }, {
      name: 'Marvin Reimer'
      image: 'marvin.jpg'
      title: 'Developer'
    }, {
      name: 'Javier Lozano'
      image: 'javier.jpg'
      title: 'Communications Asst'
    }, {
      name: 'Kathi Fletcher'
      image: 'kef.jpg'
      title: 'Shuttleworth Foundation Fellow'
    }]
  }

  return class AboutPeopleView extends BaseView
    template: template
    templateHelpers:
      foundations: foundations
      advisors: people.advisors
      members: people.members
