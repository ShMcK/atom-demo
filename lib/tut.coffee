# TutView = require './tut-view'
TutView = require './tut-view'
Git = require './content/git'
{CompositeDisposable} = require 'atom'
Project = require './data/project'

module.exports = Tut =
  # tutView: null
  tutView: null
  panel: null
  subscriptions: null

  activate: (state) ->

    Git.init()

    # console.log state # object
    projectInit =
        title: 'Untitled'
        description: 'some description'
        current:
          chapter: 1
          step: 1
        keywords: ['test', 'test2']
        
    project = new Project(projectInit)
    @tutView = new TutView(project) #state.tutViewState
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
