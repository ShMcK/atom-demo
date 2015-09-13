# codeBlock = require './content/code-block'
# markdown = require './content/markdown'
# project = require './data/project'
#
# module.exports =
# class TutView
#   constructor: (serializedState) ->
#     # Create root element
#     @element = document.createElement('div')
#     @element.classList.add('tut')
#
#     # Nav
#     header = '<div class="tut--header">Tutorial Builder: ' + project.title + '</div>'
#
#     button = '<button class="tut--submit">Submit</button>'
#
#     # Create content
#     content = document.createElement('div')
#     content.classList.add('tut--view')
#     content.innerHTML = header +
#         button +
#         # TODO: chapter / step
#         markdown.getAbove() +
#         codeBlock.getFromEditor() +
#         markdown.getBelow()
#
#     @element.appendChild(content)
#
#
#
#   submit: ->
#     alert 'submit!'
# #
# #   # Returns an object that can be retrieved when package is activated
#   serialize: ->
# #
# #   # Tear down any state and detach
#   destroy: ->
#     @element.remove()
#
#   getElement: ->
#     @element
#
#
# $("tut .tut--submit").on 'click', (event) ->
#   alert "User clicked on 'foo.'"
