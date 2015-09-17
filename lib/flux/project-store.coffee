Reflux = require 'reflux'
Actions = require './actions'

module.exports = ProjectStore = Reflux.createStore
  listenables: [Actions]
  init: ->
    @project = {}
