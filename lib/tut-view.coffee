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
    @model = model
    @loadStep()


  loadStep: () ->
    @currentStep = @model.loadStep()
    @textAboveEditor.setText @currentStep.above
    @textBelowEditor.setText @currentStep.below
    codeBlock.setCode @currentStep.code

  save: ->
    # TODO: automate save
    @currentStep =
      above: @textAboveEditor.getText()
      below: @textBelowEditor.getText()
      code: codeBlock.code
    @model.saveStep(@currentStep)

  ###
  #  Navigation
  ###

  stepNext: ->
    step = @model.current.step
    if step < @model.data.chapters[@model.current.chapter - 1].steps.length
      @model.updateCurrent(@model.current.step + 1)
      @loadStep()
    else if @model.current.chapter < @model.data.chapters.length
      @model.updateCurrent(1, @model.current.chapter + 1)
      @loadStep()
    else
      console.log 'no next step'


  stepPrev: ->
    step = @model.current.step
    if step >= 1
      @model.updateCurrent(step -1)
      @loadStep()
    else
      console.log 'no earlier step'

  ###
  #  Add
  ###

  stepAdd: ->
    # console.log @textAboveEditor.getModel()
    console.log @textAboveEditor.getText()
    @model.addStep()
    @stepNext()

  chapterAdd: ->
    @model.addChapter()
    @model.updateCurrent(1, @model.current.chapter + 1)


    alert 'add chapter'
