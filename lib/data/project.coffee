defaultStep =
  above: ''
  below: ''
  code: ''

module.exports =
class Project
  constructor: ->
    @title = 'Untitled'
    @current = {chapter: 0, step: 0}
    @data =
      chapters: [
        steps: [
          above: 'above'
          below: 'below'
          code: '@i = 0\n func: ->\n console.log "test"'
        ]
      ]

  ###
  #   Current step/chapter
  ###

  updateCurrent: (step, chapter) ->
    @current.step = step
    @current.chapter = chapter || @current.chapter

  ###
  #   Step
  ###

  addStep: ->
    @data.chapters[@current.chapter].steps[@current.step + 1] = defaultStep
    console.log 'step added', @data

  saveStep: (step) ->
    @data.chapters[@current.chapter].steps[@current.step] = step
    console.log 'step saved', @data

  loadStep: () ->
    console.log 'step loaded', @current
    return @data.chapters[@current.chapter].steps[@current.step]

  ###
  #   Chapter
  ###

  addChapter: ->
    @data.chapters.push(steps = [defaultStep])
    console.log 'chapter added', @data
