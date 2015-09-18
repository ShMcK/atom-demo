{ScrollView} = require 'atom-space-pen-views'
ProjectStore = require '../stores/project-store'

# title, code
module.exports =
class StepLogView extends ScrollView
  @content: () ->
    @div class: 'tut', =>

      # Header
      @div class: 'tut--header', =>
        @p =>
          @tag 'span', 'Tutorial Builder: '
          @tag 'span', class: 'text-success', outlet: 'title'
      @div class: 'tut--log', =>
        @p 'STEP LOG VIEW'

      # Loop over Chapters // title
      #   Loop over Steps // message

  initialize: ->
    super

  toggleChapter: (index) ->

  toggleStep: (index) ->
