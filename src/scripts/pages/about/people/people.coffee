define (require) ->
  BaseView = require('cs!helpers/backbone/views/base')
  template = require('hbs!./people-template')
  require('less!./people')

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
      advisors: people.advisors
      members: people.members
