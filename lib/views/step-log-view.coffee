{ScrollView} = require 'atom-space-pen-views'
# list of commits sorted by chapter/step
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

      # Loop over Chapters
      #   Loop over Steps
  initialize: ->
    super
