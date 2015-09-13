{$$$, ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextEditor} = require 'atom'

codeBlock = require './content/code-block'
markdown = require './content/markdown'

module.exports =
class FormView extends ScrollView

  @content: (project) ->

    @div class: 'tut', =>
      @div class: 'tut--header', =>
        @p "Tutorial Builder: " + project.title

      @div class: 'tut--text-above', =>
         @subview 'textAboveEditor', new TextEditorView(editor: @textAboveEditor)

      # code-block
      # TODO: move into TextEditorView, load dynamically, clickable
      @raw codeBlock.getFromEditor()

      @div class: 'tut--text-below', =>
        @subview 'textBelowEditor', new TextEditorView(editor: @textBelowEditor)

      @div class: 'tut--options', =>
        @button click: "stepPrev", "Previous"
        @button click: 'stepAdd', 'Add Step'
        @button click: 'chapterAdd', 'Add Chapter'

  ###
  #  Initialize
  ###

  initialize: ->
    super
    @subscriptions = new CompositeDisposable

    @textAboveEditor = new TextEditor
      tabLength: 2
      softTabs: true
      softWrapped: true
      placeholderText: 'Text above'

    @textBelowEditor = new TextEditor
      tabLength: 2
      softTabs: true
      softWrapped: true
      placeholderText: 'Text below'

  ###
  #  Nav Project
  ###

  # Nav
  stepPrev: ->
      alert 'prev'
  stepNext: ->
      alert 'next'

  ###
  #  Change project
  ###

  stepAdd: ->
    alert @textAboveEditor.getText()
  chapterAdd: ->
    alert 'add chapter'
