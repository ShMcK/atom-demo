Reflux = require 'reflux'
# TODO: allow multiple repos
repo = atom.project.getRepositories()[0]

GitActions = Reflux.createActions([
  'diff'
  'checkout'
])

GitActions.diff = ->

GitActions.checkout = ->

module.exports = GitActions
