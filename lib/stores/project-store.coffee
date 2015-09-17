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
    @title = 'Untitled'
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

    # Steps
  onAddStep: ->
    console.log 'ProjectStore:addStep'
    @data.chapters[@current.chapter].steps[@current.step + 1] = defaultStep

  onSaveStep: (step) ->
    console.log 'ProjectStore:saveStep'
    @data.chapters[@current.chapter].steps[@current.step] = step

  onLoadstep: ->
    console.log 'Projectstore:loadStep'
    return @data.chapters[@current.chapter].steps[@current.step]

    # Chapter
  onAddChapter: ->
    console.log 'ProjectStore:addChapter'
    @data.chapters.push(steps = [defaultStep])

    # Update
  onUpdateCodeBlock: ->
    console.log 'ProjectStore:updateCodeBlock'
    # git diff

    # Current Position
  onUpdateCurrent: (step, chapter) ->
    console.log 'onUpdateCurrent', step, chapter
    @current =
      step: step
      chapter: chapter || @current.chapter
