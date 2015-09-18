Reflux = require 'reflux'
ProjectActions = require '../actions/project-actions'
NavActions = require '../actions/nav-actions'
GitActions = require '../actions/git-actions'
Notifier = require '../utils/notifier'

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
          above: '# Text Above\nexample text here'
          below: '# Text Below\nexample text here'
          code: '@i = 0\nfunc = ->\n  console.log "test"'
          fileType: 'coffee'
        ]
      ]

    @current =
      chapter: 0
      step: 0

  # Current
  chapter: ->
    return @data.chapters[@current.chapter]
  step: ->
    return @chapter().steps[@current.step]

  # Steps
  onAddStep: ->
    console.log 'ProjectStore:addStep'
    @trigger @chapter().steps[@current.step + 1] = defaultStep
    @onUpdateCurrent(@current.step + 1)

  onSaveStep: (text) ->
    console.log 'ProjectStore:saveStep'
    step =
      above: text.above
      below: text.below
      code: @step().code
    @trigger @data.chapters[@current.chapter].steps[@current.step] = step

  onLoadstep: ->
    console.log 'Projectstore:loadStep'
    @trigger @step()

  onAddChapter: ->
    console.log 'ProjectStore:addChapter'
    nextChapter = @current.chapter + 1
    if !@data.chapters[nextChapter]
      console.log 'creating new chapter'
      @data.chapters[nextChapter] =
        steps: []
      console.log @data.chapters[nextChapter]
      @data.chapters[nextChapter].steps.push(defaultStep)
    console.log 'added chapter', @data
    @onUpdateCurrent(0, nextChapter)

    # Update
  onUpdateCodeBlock: (code) ->
    console.log 'ProjectStore:updateCodeBlock'
    @trigger @data.chapters[@current.chapter].steps[@current.step].code = code

    # Current Position
  onUpdateCurrent: (step, chapter = @current.chapter) ->
    console.log 'onUpdateCurrent', step, chapter
    @trigger @current =
      step: step
      chapter: chapter
    console.log 'new @current', @current

  onNextStep: ->
    step = @current.step
    chapter = @current.chapter
    if step < @chapter().steps.length - 1
      console.log 'next step'
      @onUpdateCurrent(step + 1)
    else if chapter < @data.chapters.length - 1
      console.log 'next chapter'
      @onUpdateCurrent(0, chapter + 1)
    else
      console.log 'no next step'
      Notifier.addInfo 'No next step'

  onPrevStep: ->
    step = @current.step
    chapter = @current.chapter
    console.log 'onPrevStep', step, chapter
    if step > 0
      console.log 'prev step'
      @onUpdateCurrent(step - 1)
    else if chapter >= 1
      console.log chapter
      console.log 'prev chapter'
      prevChapterFinalStep = @data.chapters[chapter - 1].steps.length - 1
      console.log prevChapterFinalStep
      @onUpdateCurrent(prevChapterFinalStep, chapter - 1)
    else
      console.log 'no earlier step'
      Notifier.addInfo 'No earlier step'
