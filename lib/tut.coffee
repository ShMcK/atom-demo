EditStepView = require './views/edit-step-view'
StepLogView = require './views/step-log-view'
InfoView = require './views/info-view'
{CompositeDisposable} = require 'atom'

module.exports = Tut =
  editStepView: null
  panel: null

  stepLogView: null
  logPanel: null

  infoView: null
  infoPanel: null

  subscriptions: null

  activate: (state) ->

    @editStepView = new EditStepView() #state.tutViewState
    @panel = atom.workspace.addRightPanel(item: @editStepView, priority: 100)

    @stepLogView = new StepLogView()
    @logPanel = atom.workspace.addRightPanel(item: @stepLogView, priority: 150, visible: false)

    @infoView = new InfoView()
    @infoPanel = atom.workspace.addRightPanel(item: @infoView, priority: 200, visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle': =>
      @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle-log': =>
      @toggle(@logPanel)
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle-info': =>
      @toggle(@infoPanel)

  deactivate: ->
    @panel.destroy()
    @logPanel.destroy()
    @infoPanel.destroy()
    @subscriptions.dispose()
    @editStepView.destroy()
    @stepLogView.destroy()
    @infoView.destroy()

  serialize: ->
    # tutViewState: @tutView.serialize()

  toggle: (panel = @panel)->
    console.log panel + ' was toggled!'

    if panel.isVisible()
      panel.hide()
    else
      panel.show()
