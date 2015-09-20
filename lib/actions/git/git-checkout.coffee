{CompositeDisposable} = require 'atom'
disposables = new CompositeDisposable

Path = require 'path'
fs = require 'fs-plus'
repo = atom.project.getRepositories()[0]


Git = require './git'
Notifier = require '../../utils/notifier'

gitCheckout = (hash) ->
  args = ['checkout']
  args.push hash if hash.length
  console.log args
  Git.cmd
    args: args
    cwd: repo.getWorkingDirectory()
    # stdout: (data) ->
    #   console.log 'checkout: ', data
    # exit: (code) ->
    #   console.log 'code', code
    #   if code is 0

module.exports = gitCheckout
