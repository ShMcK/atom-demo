{$$$, ScrollView, TextEditorView} = require 'atom-space-pen-views'
{CompositeDisposable, TextEditor} = require 'atom'

codeBlock = require './content/code-block'
markdown = require './content/markdown'
project = require './data/project'

module.exports =
class FormView extends ScrollView
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

      @nav class: 'tut--nav', =>
        @ul =>
          @li class: 'tut--nav--prev', =>
           @a href: '#', click: "stepPrev", "<"
          @li class: 'tut--nav--next', =>
            @a href: '#', click: "stepNext", ">"

      @div class: 'tut--text-above', =>
         @subview 'textAboveEditor', new TextEditorView(editor: textAboveEditor)
      @raw codeBlock.getFromEditor()
      @div class: 'tut--text-below', =>
        @subview 'textBelowEditor', new TextEditorView(editor: textBelowEditor)

  initialize: ->
    @subscriptions = new CompositeDisposable
    console.log 'initialized'

  stepPrev: ->
      alert 'prev'
  stepNext: ->
      alert 'next'
