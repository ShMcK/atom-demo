{ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextBuffer, TextEditor} = require 'atom'

CodeHighlight = require '../utils/code-highlight'
ProjectActions = require '../actions/project-actions'
NavActions = require '../actions/nav-actions'
GitActions = require '../actions/git-actions'
ProjectStore = require '../stores/project-store'

module.exports =
class EditStepView extends ScrollView
  @content: () ->
    # Text boxes
    @textABuffer = new TextBuffer
    @textBBuffer = new TextBuffer
    @textAEditor = new TextEditor
      buffer: @textABuffer
      placeholderText: 'Above text here'
    @textBEditor = new TextEditor
      buffer: @textBBuffer
      placeholderText: 'Below text here'

    @div class: 'tut', =>

      # Header
      @div class: 'tut--header', click: 'toggleInfo', =>
        @p =>
          @tag 'span', 'Tutorial Builder: '
          @tag 'span', class: 'text-success', outlet: 'title'
      @div class: 'tut--current', =>
        @p =>
          @tag 'span', 'Ch: '
          @tag 'span', class: 'text-success tut--chapter', outlet: 'chapter'
          @tag 'span', '  Step: '
          @tag 'span', class: 'text-success tut--step', outlet: 'step'

      # Text Inputs
      @div class: 'tut--text-box', =>
        @subview 'textAEditor', new TextEditorView(editor: @textAEditor)
      @div class: 'tut--code-block', outlet: 'codeBlock'
      @div class: 'tut--text-box', =>
        @subview 'textBEditor', new TextEditorView(editor: @textBEditor)

      # Events
      @div class: 'tut--options', =>
        @button class: 'btn btn-default', click: 'prevStep', 'Prev'
        @button class: 'btn btn-default', click: 'nextStep', 'Next'
      @div class: 'tut--options', =>
        @button class: 'btn btn-default', click: 'addStep', 'Add Step'
        @button class: 'btn btn-default', click: 'addChapter', 'Add Chapter'
      @div class: 'tut--options', =>
        @button class: 'btn btn-primary', click: 'save', 'save'
      @div class: 'tut-options', =>
        @button class: 'btn btn-primary', click: 'test1', 'Test 1'
        @button class: 'btn btn-primary', click: 'test2', 'Test 2'

  ###
  #  Initialize
  ###
  initialize: () ->
    super
    @project = ProjectStore
    @onUpdate()
    @project.listen () =>
      console.log 'change!'
      @onUpdate()

    # Register key subscriptions
    @subscriptions = new CompositeDisposable

  getCurrentStep: () ->
    console.log @project
    @currentStep = @project.data.chapters[@project.current.chapter].steps[@project.current.step]
    console.log 'currentStep', @currentStep

  onUpdate: () ->
    console.log 'onUpdate'
    @getCurrentStep()
    # View Data
    @title.text @project.info.title
    @step.text @project.current.step + 1
    @chapter.text @project.current.chapter + 1

    # Content
    @textAEditor.setText @currentStep.above
    @textBEditor.setText @currentStep.below
    @codeBlock.html CodeHighlight(@currentStep.code, @currentStep.fileType)

  save: ->
    text =
      above: @textAEditor.getText() || ''
      below: @textBEditor.getText() || ''
    ProjectActions.saveStep(text)

  ###
  #  Navigation
  ###
  nextStep: ->
    @save()
    NavActions.nextStep()

  prevStep: ->
    @save()
    NavActions.prevStep()

  ###
  #  Steps / Chapters
  ###
  addStep: ->
    @save()
    ProjectActions.addStep()

  addChapter: ->
    @save()
    ProjectActions.addChapter()


  toggleInfo: ->


  ###
  #  Git Tests
  ###
  test1: ->
    GitActions.diff()

  test2: ->
    GitActions.checkout('213a8c2')
    # console.log 'clicked';
    # ProjectActions.updateCurrent(1, 0)

  destroy: ->
    #TODO: destroy
