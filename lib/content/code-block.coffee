# Syntax Highlighting
Highlights = require 'highlights'
highlighter = new Highlights()

class CodeBlock
  constructor: ->
    @code = '';

  getFromEditor: ->
    # TODO: change to git diff from previous commit
    # editor = atom.workspace.getActiveTextEditor()
    # code = editor.getText()

    #TODO: detect langauge type, "source.js", "source.coffee", etc.

    return @highlightCode(@code, "coffee")

  highlightCode: (code, fileType) ->
    return highlighter.highlightSync
      fileContents: code
      scopeName: 'source.' + fileType

  setCode: (code) ->
    @code = code;

module.exports = new CodeBlock()
