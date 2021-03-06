{ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextBuffer, TextEditor} = require 'atom'
ProjectStore = require '../stores/project-store'

# title, code
module.exports =
class InfoView extends ScrollView
  @content: () ->

    @title = new TextEditor
      placeholderText: 'Title'
    @description = new TextEditor
      placeholderText: 'Description'

    @div class: 'tut', =>

      @div class: 'tut--header', =>
        @p =>
          @tag 'span', 'Project Info'

      @div class: 'tut--info', =>
        @div class: 'tut--text-box', =>
          @subview 'titleInput', new TextEditorView(editor: @title)
        @div class: 'tut--code-block', outlet: 'codeBlock'
        @div class: 'tut--text-box', =>
          @subview 'descriptionInput', new TextEditorView(editor: @description)
      @div class: 'tut-options', =>
        @button class: 'btn btn-primary', click: 'update', 'Update'
        @button class: 'btn btn-warning', click: 'cancel', 'Cancel'


      # title
      # description
      # keywords: []

  initialize: ->
    super

  update: ->
    console.log 'update'

  cancel: ->
    console.log 'cancel'
