{ScrollView} = require 'atom-space-pen-views'
ProjectStore = require '../stores/project-store'

# title, code
module.exports =
class LogView extends ScrollView
  @content: (project) ->
    @div class: 'tut', =>

      # Header
      @div class: 'tut--header', =>
        @p =>
          @tag 'span', 'Tutorial Builder: '
          @tag 'span', class: 'text-success', outlet: 'title'
      @div class: 'tut--log', =>
        @p 'STEP LOG VIEW'

      # console.log 'chapters', project.chapters.length
      # Loop over Chapters // title
      #   Loop over Steps // message

  toggleChapter: (index) ->

  toggleStep: (index) ->
