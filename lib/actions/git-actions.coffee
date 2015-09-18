Reflux = require 'reflux'
# TODO: allow multiple repos
repo = atom.project.getRepositories()[0]

gitDiff = require './git/git-diff'

GitActions = Reflux.createActions([
  'diff'
  'checkout'
])

GitActions.diff = ->
  console.log 'GitActions:diff'
  gitDiff(repo)

GitActions.checkout = ->
  console.log 'GitActions:checkout'

module.exports = GitActions
