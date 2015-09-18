# form displaying title, description, keywords, etc.
# settings
{ScrollView} = require 'atom-space-pen-views'
ProjectStore = require '../stores/project-store'

# title, code
module.exports =
class InfoView extends ScrollView
  @content: () ->
    @div class: 'tut', =>

      # Header
      @div class: 'tut--header', =>
        @p =>
          @tag 'span', 'Tutorial Builder'

      @div class: 'tut--info', =>
        @p 'INFO VIEW'

      # title
      # description
      # keywords: []

  initialize: ->
    super
