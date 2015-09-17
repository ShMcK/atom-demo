# Syntax Highlighting
Highlights = require 'highlights'
highlighter = new Highlights()

module.exports = highlight = (code, fileType) ->
  return highlighter.highlightSync
    fileContents: code
    scopeName: 'source.' + fileType
