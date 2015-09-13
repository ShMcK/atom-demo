{$, $$$, ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextBuffer, TextEditor} = require 'atom'

codeBlock = require './content/code-block'
markdown = require './content/markdown'

module.exports =
class FormView extends ScrollView

  @content: (project) ->

    @aboveBuffer = new TextBuffer
    @belowBuffer = new TextBuffer

    @textAboveEditor = new TextEditor
      buffer: @aboveBuffer
      placeholderText: 'Above text here'

    @textBelowEditor = new TextEditor
      buffer: @belowBuffer
      placeholderText: 'Below text here'

    @div class: 'tut', =>
      @div class: 'tut--header', =>
        @p =>
          @tag 'span', 'Tutorial Builder: '
          @tag 'span', class: 'text-success', project.title
      @div class: 'tut--current', =>
        @p =>
          @tag 'span', 'Ch: '
          @tag 'span', class: 'text-success', project.current.chapter
          @tag 'span', '  Step: '
          @tag 'span', class: 'text-success', project.current.step

      @div class: 'tut--text-box', =>
        @subview 'textAboveEditor', new TextEditorView(editor: @textAboveEditor)

      # code-block
      # TODO: move into TextEditorView, load dynamically, clickable
      @raw codeBlock.getFromEditor()

      @div class: 'tut--text-box', =>
        @subview 'textBelowEditor', new TextEditorView(editor: @textBelowEditor)

      @div class: 'tut--options', =>
        @button class: 'btn btn-default', click: 'stepPrev', 'Above'
        @button class: 'btn btn-default', click: 'stepAdd', 'Below'
        @button class: 'btn btn-default', click: 'chapterAdd', 'Add Chapter'
      @button class: 'btn btn-primary', click: 'save', 'save'

  ###
  #  Initialize
  ###

  initialize: (model) ->
    super
    @subscriptions = new CompositeDisposable
    @data = model.data
    @current = model.current
    console.log @current
    console.log @data
    @currentStep = @data.chapters[@current.chapter - 1].steps[@current.step - 1]

    # Init values
    @textAboveEditor.setText(@currentStep.above);
    @textBelowEditor.setText(@currentStep.below);


  save: ->
    # TODO: automate save
    @currentStep =
      above: @textAboveEditor.getText()
      below: @textBelowEditor.getText()
      code: codeBlock.code
    console.log @currentStep

  ###
  #  Nav Project
  ###

  # Nav
  stepPrev: ->
    console.log @textAboveEditor.getText()

  ###
  #  Change project
  ###

  stepAdd: ->
    # console.log @textAboveEditor.getModel()
    console.log @textAboveEditor.getText()

  chapterAdd: ->
    alert 'add chapter'
