{constants} = require './constants'
Fluxxor = require 'fluxxor'

module.exports = ProjectStore = Fluxxor.createStore
  initialize: ->
    @project = {}

    @bindActions()
