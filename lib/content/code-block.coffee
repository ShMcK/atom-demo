# Syntax Highlighting
Highlights = require 'highlights'
highlighter = new Highlights()

class CodeBlock
  getFromEditor: ->
    editor = atom.workspace.getActiveTextEditor()
    code = editor.getText()
    highlightedCode = highlighter.highlightSync
      fileContents: code
      scopeName: 'source.coffee'

    #TODO: detect langauge type, "source.js", "source.coffee", etc.

    wrappedCode = '<div class="tut--code-block">' +
      '<pre><code>' + highlightedCode + '</code></pre>' +
      '</div>'

    return wrappedCode

module.exports = new CodeBlock()
