{CompositeDisposable} = require 'atom'
Path = require 'path'
fs = require 'fs-plus'

git = require '../git'
notifier = require '../notifier'

disposables = new CompositeDisposable
diffFilePath = null

gitDiff = (repo, {diffStat, file}={}) ->
  diffFilePath = Path.join(repo.getPath(), "tut.diff")
  file ?= repo.relativize(atom.workspace.getActiveTextEditor()?.getPath())
  if not file
    return notifier.addError "No open file. Select 'Diff All'."
  diffStat ?= ''
  args = ['diff', '--color=never']
  args.push file if diffStat is ''
  git.cmd
    args: args
    cwd: repo.getWorkingDirectory()
    stdout: (data) ->
      diffStat += data
    exit: (code) ->
      prepFile diffStat if code is 0

prepFile = (text) ->
  if text?.length > 0
    # data here
    console.log text
  else
    notifier.addInfo 'Nothing to show.'

module.exports = gitDiff
