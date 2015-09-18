EditStepView = require './views/edit-step-view'
StepLogView = require './views/step-log-view'
{CompositeDisposable} = require 'atom'

module.exports = Tut =
  editStepView: null
  panel: null

  stepLogView: null
  logPanel: null

  subscriptions: null

  activate: (state) ->

    @editStepView = new EditStepView() #state.tutViewState
    @panel = atom.workspace.addRightPanel(item: @editStepView, priority: 100)

    @stepLogView = new StepLogView()
    @logPanel = atom.workspace.addRightPanel(item: @stepLogView, priority: 150)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle': =>
      @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle-log': =>
      @toggleLog()

  deactivate: ->
    @panel.destroy()
    @subscriptions.dispose()
    @editStepView.destroy()

  serialize: ->
    # tutViewState: @tutView.serialize()

  toggle: ->
    console.log 'Tut was toggled!'

    if @panel.isVisible()
      @panel.hide()
    else
      @panel.show()

# toggle other panels
  toggleLog: ->
    console.log 'Log was toggled'

    if @logPanel.isVisible()
      @logPanel.hide()
    else
      @logPanel.show()
