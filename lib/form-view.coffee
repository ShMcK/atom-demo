{$$$, View, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextEditor} = require 'atom'

codeBlock = require './content/code-block'
markdown = require './content/markdown'
project = require './data/project'

module.exports =
class FormView extends View
  @content: (params) ->

    textAboveEditor = new TextEditor
      mini: true
      tabLength: 2
      softTabs: true
      softWrapped: false
      placeholderText: 'Text above'

    textBelowEditor = new TextEditor
      mini: true
      tabLength: 2
      softTabs: true
      softWrapped: false
      placeholderText: 'Text below'

    @div class: 'tut', =>
      @div class: 'tut--header', =>
        @p "Tutorial Builder: Untitled"
      @button click: 'openAlert', 'Submit'
      @div class: 'tut--text-above', =>
         @subview 'textAboveEditor', new TextEditorView(editor: textAboveEditor)
      @raw codeBlock.getFromEditor()
      @div class: 'tut--text-below', =>
        @subview 'textBelowEditor', new TextEditorView(editor: textBelowEditor)

  initialize: ->
    @subscriptions = new CompositeDisposable
    console.log 'initialized'

  openAlert: () ->
    alert 'open'
