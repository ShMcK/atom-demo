# Markdown Package

{GitRepository} = require 'atom'

class MarkdownEditor
  getAbove: ->
    return '<div class="tut--text-above">' +
        '<textarea class="native-key-bindings" cols="45" rows="3">' +
        '</textarea>' +
      '</div>'
  # getAbove: ->
  #   @div class: 'tut--text-above', =>
  #     @subview 'textA', new TextEditorView
  #       mini: true,
  #       placholderText: 'text above'
  getBelow: ->
    return '<div class="tut--text-below">' +
        '<textarea class="native-key-bindings" cols="45" rows="3">' +
        '</textarea>' +
      '</div>'

module.exports = new MarkdownEditor()
