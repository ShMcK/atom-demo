{$, $$$, ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextBuffer, TextEditor} = require 'atom'
Reflux = require 'reflux'

CodeBlock = require './utils/code-block'
ProjectActions = require './actions/project-actions'
NavActions = require './actions/nav-actions'
ProjectStore = require './stores/project-store'

module.exports =
class FormView extends ScrollView

  # can load content
  @content: () ->

    @textABuffer = new TextBuffer
    @textBBuffer = new TextBuffer

    @textAEditor = new TextEditor
      buffer: @textABuffer
      placeholderText: 'Above text here'

    @textBEditor = new TextEditor
      buffer: @textBBuffer
      placeholderText: 'Below text here'

    @div class: 'tut', =>
      @div class: 'tut--header', =>
        @p =>
          @tag 'span', 'Tutorial Builder: '
          @tag 'span', class: 'text-success', outlet: 'title'
      @div class: 'tut--current', =>
        @p =>
          @tag 'span', 'Ch: '
          @tag 'span', class: 'text-success tut--chapter', outlet: 'chapter'
          @tag 'span', '  Step: '
          @tag 'span', class: 'text-success tut--step', outlet: 'step'

      @div class: 'tut--text-box', =>
        @subview 'textAEditor', new TextEditorView(editor: @textAEditor)

      # code-block
      # TODO: move into TextEditorView, load dynamically, clickable
      @div class: 'tut--code-block', outlet: 'codeBlock'

      @div class: 'tut--text-box', =>
        @subview 'textBEditor', new TextEditorView(editor: @textBEditor)

      @div class: 'tut--options', =>
        @button class: 'btn btn-default', click: 'prevStep', 'Prev'
        @button class: 'btn btn-default', click: 'nextStep', 'Next'
      @div class: 'tut--options', =>
        @button class: 'btn btn-default', click: 'addStep', 'Add Step'
        @button class: 'btn btn-default', click: 'addChapter', 'Add Chapter'
      @div class: 'tut--options', =>
        @button class: 'btn btn-primary', click: 'save', 'save'

      @div class: 'tut-options', =>
        @p 'testing'
        @button class: 'btn btn-primary', click: 'checkoutOld', 'Old'
        @button class: 'btn btn-primary', click: 'checkoutNew', 'New'

  ###
  #  Initialize
  ###

  initialize: () ->
    super
    @project = ProjectStore
    @currentStep = @project.data.chapters[@project.current.chapter].steps[@project.current.step]
    @subscriptions = new CompositeDisposable
    @loadStep()

    @project.listen () =>
      console.log 'change!'
      @loadStep()

  loadStep: () ->
    # View Data
    @title.text @project.info.title
    @step.text @project.current.step + 1
    @chapter.text @project.current.chapter + 1

    # Content
    @textAEditor.setText @currentStep.above
    @textBEditor.setText @currentStep.below
    @codeBlock.html CodeBlock.format(@currentStep.code)

  save: ->
    text =
      above: @textAEditor.getText()
      below: @textBEditor.getText()
    ProjectActions.saveStep(text)

  ###
  #  Navigation
  ###

  nextStep: -> NavActions.nextStep()

  prevStep: -> NavActions.prevStep()

  ###
  #  Add
  ###

  addStep: -> ProjectActions.addStep()

  addChapter: -> ProjectActions.addChapter()

  ###
  #  Git Tests
  ###

  checkoutOld: ->
    # repo = atom.project.getRepositories()[0]
    # processDiffPatch = new Promise((resolve, reject) ->
    #   patch = gitDiff(repo)
    #   resolve patch
    #   reject Error 'error processing diff patch'
    #   return
    # )
    # processDiffPatch.then (patch) ->
    #   console.log 'patch', patch
    #   alert patch
    #   codeBlock.render patch

  checkoutNew: ->
    console.log 'clicked';

    ProjectActions.updateCurrent(1, 0)
