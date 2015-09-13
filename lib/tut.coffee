# TutView = require './tut-view'
FormView = require './form-view'
{CompositeDisposable} = require 'atom'

module.exports = Tut =
  # tutView: null
  formView: null
  panel: null
  subscriptions: null

  activate: (state) ->

    console.log state # object

    @formView = new FormView()
    @panel = atom.workspace.addRightPanel(item: @formView, priority: 100)
    # @tutView = new TutView(state.tutViewState)
    # @panel = atom.workspace.addRightPanel(item: @tutView.getElement(), priority: 100)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'tut:toggle': =>
      @toggle()

  deactivate: ->
    @panel.destroy()
    @subscriptions.dispose()
    # @tutView.destroy()
    # @formView.destroy()

  serialize: ->
    # tutViewState: @tutView.serialize()
    formViewState: @formView.serialize()

  toggle: ->
    console.log 'Tut was toggled!'

    if @panel.isVisible()
      @panel.hide()
    else
      #atom.commands.dispatch(atom.views.getView(atom.workspace), "git-plus:diff");
      @panel.show()
