ProjectStore = require './project-store'
actions = require './actions'

var stores =
  ProjectStore: new ProjectStore()

module.exports = flux = new Fluxxor.Flux(stores, actions)

module.exports = constants =
  UPDATE_CODEBLOCK: "UPDATE_CODEBLOCK"
