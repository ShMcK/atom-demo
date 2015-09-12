TutView = require './tut-view'
{CompositeDisposable} = require 'atom'

module.exports = Tut =
  tutView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->

    console.log state # object

    @tutView = new TutView(state.tutViewState)
    @modalPanel = atom.workspace.addRightPanel(item: @tutView.getElement(), priority: 100)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @tutView.destroy()

  serialize: ->
    tutViewState: @tutView.serialize()

  toggle: ->
    console.log 'Tut was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      #atom.commands.dispatch(atom.views.getView(atom.workspace), "git-plus:diff");
      @modalPanel.show()
