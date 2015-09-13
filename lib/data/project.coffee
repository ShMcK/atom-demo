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
          code: ''
        ]
      ]
