CodeBlock = require './content/code-block'
codeBlock = new CodeBlock()

MarkdownEditor = require './content/markdown'
markdown = new MarkdownEditor()

project = require './data/project'

module.exports =
class TutView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('tut')

    # Nav
    header = '<div class="tut--header">Tutorial Builder: ' + project.title + '</div>'

    # Markdown Text
    # TODO: move into markdown file
    above = '<div class="tut--text-above">' +
        'A text area above' +
      '</div>'
    below = '<div class="tut--text-above">' +
        'A text area above' +
      '</div>'

    # Create content
    content = document.createElement('div')
    content.classList.add('tut--view')
    content.innerHTML = header +
        # TODO: chapter / step
        markdown.getAbove() +
        codeBlock.getFromEditor() +
        markdown.getBelow()

    @element.appendChild(content)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
