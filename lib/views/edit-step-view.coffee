{ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextBuffer, TextEditor} = require 'atom'

Highlight = require '../utils/highlight'
FormatCode = require '../utils/format-code'
ProjectActions = require '../actions/project-actions'
NavActions = require '../actions/nav-actions'
GitActions = require '../actions/git-actions'
ProjectStore = require '../stores/project-store'

LogView = require './log-view'
InfoView = require './info-view'

module.exports =
class EditStepView extends ScrollView
  stepLogView: null
  logPanel: null
  infoView: null
  infoPanel: null

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
      @div class: 'tut--current', click: 'toggleStepLog', =>
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
        @button class: 'btn btn-primary', click: 'diff', 'Diff'
        @button class: 'btn btn-primary', click: 'checkout', 'Checkout'
        @button class: 'btn btn-primary', click: 'log', 'Log'

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

    @LogView = new LogView()
    @logPanel = atom.workspace.addRightPanel(item: @LogView, priority: 150, visible: false)

    @infoView = new InfoView()
    @infoPanel = atom.workspace.addModalPanel(item: @infoView, priority: 200, visible: false)

    # Register key subscriptions
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle-log': =>
      @toggle(@logPanel)
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle-info': =>
      @toggle(@infoPanel)

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
    @codeBlock.html Highlight (FormatCode @currentStep.code), @currentStep.fileType

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
    @toggle @infoPanel

  toggleStepLog: ->
    @toggle @logPanel

  toggle: (panel) ->
    if panel.isVisible()
      panel.hide()
    else
      panel.show()

  ###
  #  Git Tests
  ###
  diff: ->
    GitActions.diff()

  checkout: ->
    GitActions.checkout('213a8c2')
    # console.log 'clicked';
    # ProjectActions.updateCurrent(1, 0)
    #
  log: ->
    GitActions.log()

  destroy: ->
    @subscriptions.dispose()
    @infoPanel.destroy()
    @logPanel.destroy()
    StepLogView.destroy()
    InfoView.destroy()
    @textABuffer.destroy()
    @textAEditor.destroy()
    @textBBuffer.destroy()
    @textBEditor.destroy()
