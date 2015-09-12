{$, $$, $$$, View, TextEditorView} = require 'atom-space-pen-views'
CodeBlock = require './content/code-block'
codeBlock = new CodeBlock()

MarkdownEditor = require './content/markdown'
markdown = new MarkdownEditor()

project = require './data/project'

module.exports =
class TutView extends View
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('tut')

    # Nav
    header = '<div class="tut--header">Tutorial Builder: ' + project.title + '</div>'


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
