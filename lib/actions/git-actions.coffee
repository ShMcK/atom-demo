Reflux = require 'reflux'
# TODO: allow multiple repos
repo = atom.project.getRepositories()[0]

gitDiff = require './git/git-diff'
gitCheckout = require './git/git-checkout'
gitLog = require './git/git-log'

GitActions = Reflux.createActions([
  'diff'
  'checkout',
  'log'
])

GitActions.diff = ->
  console.log 'GitActions:diff'
  gitDiff(repo)

GitActions.checkout = (hash) ->
  console.log 'GitActions:checkout'
  gitCheckout(hash)

GitActions.log = ->
  console.log 'GitActions:log'
  gitLog()

module.exports = GitActions
