{$, $$$, ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextBuffer, TextEditor} = require 'atom'

diff = require './git/model/git-diff'

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
          @tag 'span', class: 'text-success tut--chapter', project.current.chapter + 1
          @tag 'span', '  Step: '
          @tag 'span', class: 'text-success tut--step', project.current.step + 1

      @div class: 'tut--text-box', =>
        @subview 'textAboveEditor', new TextEditorView(editor: @textAboveEditor)

      # code-block
      # TODO: move into TextEditorView, load dynamically, clickable
      @raw codeBlock.getFromEditor()

      @div class: 'tut--text-box', =>
        @subview 'textBelowEditor', new TextEditorView(editor: @textBelowEditor)

      @div class: 'tut--options', =>
        @button class: 'btn btn-default', click: 'stepPrev', 'Prev'
        @button class: 'btn btn-default', click: 'stepNext', 'Next'
      @div class: 'tut--options', =>
        @button class: 'btn btn-default', click: 'stepAdd', 'Add Step'
        @button class: 'btn btn-default', click: 'chapterAdd', 'Add Chapter'
      @div class: 'tut--options', =>
        @button class: 'btn btn-primary', click: 'save', 'save'

      @div class: 'tut-options', =>
        @p 'git tests'
        @button class: 'btn btn-primary', click: 'checkoutOld', 'Old'
        @button class: 'btn btn-primary', click: 'checkoutNew', 'New'

  ###
  #  Initialize
  ###

  initialize: (model) ->
    super
    @subscriptions = new CompositeDisposable
    @model = model
    @loadStep()


  loadStep: () ->
    $('.tut--chapter').text(@model.current.chapter + 1)
    $('.tut--step').text(@model.current.step + 1)

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
    chapter = @model.current.chapter
    if step < @model.data.chapters[chapter].steps.length - 1
      console.log 'next step'
      @model.updateCurrent(step + 1)
      @loadStep()
    else if chapter < @model.data.chapters.length - 1
      console.log 'next chapter'
      @model.updateCurrent(0, chapter + 1)
      @loadStep()
    else
      console.log 'no next step'


  stepPrev: ->
    step = @model.current.step
    chapter = @model.current.chapter
    if step > 0
      console.log 'prev step'
      @model.updateCurrent(step - 1)
      @loadStep()
    else if chapter > 0
      console.log 'prev chapter'
      prevChapterFinalStep = @model.data.chapters[chapter - 1].steps.length
      @model.updateCurrent(prevChapterFinalStep, chapter - 1)
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
    @model.updateCurrent(0, @model.current.chapter + 1)

  ###
  #  Git Tests
  ###
  checkoutOld: ->
    repo = atom.project.getRepositories()[0]
    console.log diff(repo)
    # git.checkout '213a8c2'

  checkoutNew: ->
    # git.checkout 'ada7ac5'
