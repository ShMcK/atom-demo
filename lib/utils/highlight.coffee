# Syntax Highlighting
Highlights = require 'highlights'
highlighter = new Highlights()

module.exports = Highlight = (code, fileType) ->
  console.log code
  return highlighter.highlightSync
    fileContents: code
    scopeName: 'source.' + fileType
    classPrefix: 'tut'
