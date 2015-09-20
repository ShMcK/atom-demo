EditStepView = require './views/edit-step-view'
{CompositeDisposable} = require 'atom'

module.exports = Tut =
  editStepView: null
  panel: null
  subscriptions: null

  activate: (state) ->

    @editStepView = new EditStepView() #state.tutViewState
    @panel = atom.workspace.addRightPanel(item: @editStepView, priority: 100)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle': =>
      @toggle()

  deactivate: ->
    @panel.destroy()
    @subscriptions.dispose()
    @editStepView.destroy()

  serialize: ->
    # tutViewState: @tutView.serialize()

  toggle: () ->
    if @panel.isVisible()
      @panel.hide()
    else
      @panel.show()
