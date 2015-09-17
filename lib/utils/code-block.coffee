ProjectActions = require '../actions/project-actions'
# Syntax Highlighting
Highlights = require 'highlights'
highlighter = new Highlights()

class CodeBlock

  format: (code) ->
    # TODO: change to git diff from previous commit
    # editor = atom.workspace.getActiveTextEditor()
    # code = editor.getText()

    #TODO: detect langauge type, "source.js", "source.coffee", etc.

    return @highlight(code, "coffee")

  highlight: (code, fileType) ->
    return highlighter.highlightSync
      fileContents: code
      scopeName: 'source.' + fileType

  # render: (patch) ->
  #   console.log 'patch', patch
  #   output = '';
  #   patch.map (line) ->
  #     if !line.change then return
  #     if line.change is '+'
  #       output += '\n' + line.line
  #   console.log output
  #   return output

module.exports = new CodeBlock()
