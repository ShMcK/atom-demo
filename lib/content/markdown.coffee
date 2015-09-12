# Markdown Package

class MarkdownEditor
  getAbove: ->
    return '<div class="tut--text-above">' +
        '<textarea class="native-key-bindings" cols="43" rows="3">' +
        '</textarea>' +
      '</div>'
  getBelow: ->
    return '<div class="tut--text-below">' +
        'A text area below' +
      '</div>'

module.exports = MarkdownEditor
