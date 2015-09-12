# Markdown Package

class MarkdownEditor
  getAbove: ->
    return '<div class="tut--text-above">' +
        '<textarea class="native-key-bindings" cols="45" rows="3">' +
        '</textarea>' +
      '</div>'
  getBelow: ->
    return '<div class="tut--text-below">' +
        '<textarea class="native-key-bindings" cols="45" rows="3">' +
        '</textarea>' +
      '</div>'

module.exports = MarkdownEditor
