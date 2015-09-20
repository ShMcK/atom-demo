Reflux = require 'reflux'
# TODO: allow multiple repos
repo = atom.project.getRepositories()[0]

gitDiff = require './git/git-diff'
gitCheckout = require './git/git-checkout'

GitActions = Reflux.createActions([
  'diff'
  'checkout'
])

GitActions.diff = ->
  console.log 'GitActions:diff'
  gitDiff(repo)

GitActions.checkout = (hash) ->
  console.log 'GitActions:checkout'
  gitCheckout(hash)


module.exports = GitActions
