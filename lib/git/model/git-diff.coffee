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
  return git.cmd
    args: args
    cwd: repo.getWorkingDirectory()
    stdout: (data) ->
      diffStat += data
    exit: (code) ->
      if code is 0
        return processDiff diffStat

processDiff = (text) ->
  if text?.length > 0
    formattedPatch = formatDiff(text).split('\n').map (item) ->
      labelChange(item)
    console.log formattedPatch
    return formattedPatch
  else
    notifier.addInfo 'Nothing to show.'

# get patch only
formatDiff = (text) ->
  diffStatMatch = new RegExp(/^@@ (.+?(?= @@))/m)
  diffStat = text.match(diffStatMatch)[0].slice(3)
  start = text.indexOf('@@ ' + diffStat + ' @@') + diffStat.length + 6
  patch = text.slice(start)
  return patch

# break patch into { line: String, changes: '+/-' }
labelChange = (line) ->
  labelled = null
  firstChar = line.charAt(0)
  if firstChar is "+" or firstChar is "-"
    return labelled =
      line: line.slice(1).trim()
      change: firstChar
  return labelled = line: line.trim()

module.exports = gitDiff
