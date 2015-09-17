# TutView = require './tut-view'
TutView = require './tut-view'
{CompositeDisposable} = require 'atom'
ProjectStore = require './stores/project-store'

module.exports = Tut =
  # tutView: null
  tutView: null
  panel: null
  subscriptions: null

  activate: (state) ->

    initProject = ProjectStore.load()

    @tutView = new TutView(initProject) #state.tutViewState
    @panel = atom.workspace.addRightPanel(item: @tutView, priority: 100)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle': =>
      @toggle()

  deactivate: ->
    @panel.destroy()
    @subscriptions.dispose()
    @tutView.destroy()

  serialize: ->
    # tutViewState: @tutView.serialize()

  toggle: ->
    console.log 'Tut was toggled!'

    if @panel.isVisible()
      @panel.hide()
    else
      #atom.commands.dispatch(atom.views.getView(atom.workspace), "git-plus:diff");
      @panel.show()
