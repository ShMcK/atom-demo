{$$$, ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextEditor} = require 'atom'

codeBlock = require './content/code-block'
markdown = require './content/markdown'

module.exports =
class FormView extends ScrollView

  @content: (project) ->
    console.log project

    @div class: 'tut', =>
      @div class: 'tut--header', =>
        @p "Tutorial Builder: " + project.title
      @div class: 'tut--current', =>
        @p "Ch: " + project.current.chapter + ", Step: " + project.current.step

      @div class: 'tut--text-above', =>
         @subview 'textAboveEditor', new TextEditorView(editor: @textAboveEditor)

      # code-block
      # TODO: move into TextEditorView, load dynamically, clickable
      @raw codeBlock.getFromEditor()

      @div class: 'tut--text-below', =>
        @subview 'textBelowEditor', new TextEditorView(editor: @textBelowEditor)

      @div class: 'tut--options', =>
        @button class: 'btn btn-default', click: "stepPrev", "Previous"
        @button class: 'btn btn-default', click: 'stepAdd', 'Add Step'
        @button class: 'btn btn-default', click: 'chapterAdd', 'Add Chapter'

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
    console.log atom.workspace.getTextEditors()
  chapterAdd: ->
    alert 'add chapter'
