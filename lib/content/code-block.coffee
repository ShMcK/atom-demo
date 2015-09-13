# Syntax Highlighting
Highlights = require 'highlights'
highlighter = new Highlights()

class CodeBlock
  getFromEditor: ->
    # TODO: change to git diff from previous commit
    # editor = atom.workspace.getActiveTextEditor()
    # code = editor.getText()

    code = '@i = 0\n
    func: ->\n
      console.log "test"'

    #TODO: detect langauge type, "source.js", "source.coffee", etc.

    return '<div class="tut--code-block"><pre><code>' +
      @highlightCode(code, "coffee") +
    '</code></pre></div>'

  highlightCode: (code, fileType) ->
    console.log fileType
    return highlighter.highlightSync
      fileContents: code
      scopeName: 'source.' + fileType

module.exports = new CodeBlock()
