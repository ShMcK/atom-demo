Reflux = require 'reflux'
ProjectActions = require '../actions/project-actions'
# GitActions = require '../actions/git-actions'
defaultStep =
  above: ''
  below: ''
  code: ''

module.exports = ProjectStore = Reflux.createStore
  listenables: ProjectActions

  init: ->
    @info =
      title: 'Untitled'
      description: ''

    @data =
      chapters: [
        steps: [
          above: 'above'
          below: 'below'
          code: '@i = 0\n func: ->\n console.log "test"'
        ]
      ]

    @current =
      chapter: 0
      step: 0

  load: ->
    project =
      info: @info
      data: @data
      current: @current
    return project


    # Steps
  onAddStep: ->
    console.log 'ProjectStore:addStep'
    @trigger @data.chapters[@current.chapter].steps[@current.step + 1] = defaultStep

  onSaveStep: (step) ->
    console.log 'ProjectStore:saveStep'
    @trigger @data.chapters[@current.chapter].steps[@current.step] = step

  onLoadstep: ->
    console.log 'Projectstore:loadStep'
    @trigger @data.chapters[@current.chapter].steps[@current.step]

    # Chapter
  onAddChapter: ->
    console.log 'ProjectStore:addChapter'
    @trigger @data.chapters.push(steps = [defaultStep])

    # Update
  onUpdateCodeBlock: (code) ->
    console.log 'ProjectStore:updateCodeBlock'
    @trigger @data.chapters[@current.chapter].steps[@current.step].code = code

    # Current Position
  onUpdateCurrent: (step, chapter) ->
    console.log 'onUpdateCurrent', step, chapter
    @trigger @current =
      step: step
      chapter: chapter || @current.chapter
