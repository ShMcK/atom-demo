Reflux = require 'reflux'
ProjectActions = require '../actions/project-actions'
NavActions = require '../actions/nav-actions'
# GitActions = require '../actions/git-actions'
defaultStep =
  above: ''
  below: ''
  code: ''

module.exports = ProjectStore = Reflux.createStore
  listenables: [ProjectActions, NavActions]

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
    @onUpdateCurrent(@current.step + 1)

  onSaveStep: (text) ->
    console.log 'ProjectStore:saveStep'
    step =
      above: text.above
      below: text.below
      code: @currentStep.code
      
    @trigger @data.chapters[@current.chapter].steps[@current.step] = step

  onLoadstep: ->
    console.log 'Projectstore:loadStep'
    @trigger @data.chapters[@current.chapter].steps[@current.step]

    # Chapter
  onAddChapter: ->
    console.log 'ProjectStore:addChapter'
    @trigger @data.chapters.push(steps = [defaultStep])
    @onUpdateCurrent(0, @current.chapter + 1)

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

  onNextStep: ->
    step = @current.step
    chapter = @current.chapter
    if step < @data.chapters[chapter].steps.length - 1
      console.log 'next step'
      @onUpdateCurrent(step + 1)
    else if chapter < @data.chapters.length - 1
      console.log 'next chapter'
      @onUpdateCurrent(0, chapter + 1)
    else
      console.log 'no next step'

  onPrevStep: ->
    step = @current.step
    chapter = @current.chapter
    if step > 0
      console.log 'prev step'
      @onUpdateCurrent(step - 1)
    else if chapter > 0
      console.log 'prev chapter'
      prevChapterFinalStep = @data.chapters[chapter - 1].steps.length
      @onUpdateCurrent(prevChapterFinalStep, chapter - 1)
    else
      console.log 'no earlier step'
