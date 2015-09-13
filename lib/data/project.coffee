defaultStep =
  above: ''
  below: ''
  code: ''

module.exports =
class Project
  constructor: ->
    @title = 'Untitled'
    @current = {chapter: 1, step: 1}
    @data =
      chapters: [
        steps: [
          above: 'above'
          below: 'below'
          code: '@i = 0\n func: ->\n console.log "test"'
        ]
      ]

  loadStep: () ->
    return @data.chapters[@current.chapter - 1].steps[@current.step - 1]

  save: (step) ->
    @data.chapters[@current.chapter - 1].steps[@current.step - 1] = step
    console.log @data

  updateCurrent: (step, chapter) ->
    @current.step = step
    @current.chapter = chapter

  addStep: ->
    @data.chapters[@current.chapter - 1].steps.push(defaultStep)

  addChapter: ->
    @data.chapters.push(steps.push(defaultStep))
