{CompositeDisposable} = require 'atom'
disposables = new CompositeDisposable

Path = require 'path'
fs = require 'fs-plus'
diffFilePath = null

Git = require './git'
Notifier = require '../../utils/notifier'
ProjectActions = require '../project-actions'

gitDiff = (repo, {diff, file}={}) ->
  # diffFilePath = Path.join(repo.getPath(), "tut.diff")
  file ?= repo.relativize(atom.workspace.getActiveTextEditor()?.getPath())
  if not file
    return Notifier.addError "No open file. Select 'Diff All'."
  console.log 'file', file
  console.log file.match(/\.[0-9a-z]+$/i)[0].slice(1)
  diff ?= ''
  args = ['diff', '--color=never']
  args.push file if diff is ''
  Git.cmd
    args: args
    cwd: repo.getWorkingDirectory()
    stdout: (data) ->
      diff += data
    exit: (code) ->
      if code is 0
        # target
        diff = processDiff diff

processDiff = (text) ->
  if text?.length > 0
    ProjectActions.updateCodeBlock _prettifyDiff(text)
  else
    Notifier.addInfo 'Nothing to show.'
    return null

# get patch only
# formatDiff = (text) ->
#   diffStatMatch = new RegExp(/^@@ (.+?(?= @@))/m)
#   diffStat = text.match(diffStatMatch)[0].slice(3)
#   start = text.indexOf('@@ ' + diffStat + ' @@') + diffStat.length + 6
#   patch = text.slice(start)
#   return patch

_prettifyDiff = (data) ->
  data = data.split(/^@@(?=[ \-\+\,0-9]*@@)/gm)
  data[1..data.length] = ('@@' + line for line in data[1..])
  data.unshift()
  return data

# break patch into { line: String, changes: '+/-' }
# labelChange = (line) ->
#   labelled = null
#   firstChar = line.charAt(0)
#   if firstChar is "+" or firstChar is "-"
#     return labelled =
#       line: line.slice(1).trim()
#       change: firstChar
#   return labelled = line: line.trim()

# filterDiff = (diffs) ->
#   code = ''
#   diffs.forEach (diff) ->
#     if diff.change is '+'
#       code += diff.line + '\n'
#   return code

module.exports = gitDiff
