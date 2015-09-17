Reflux = require 'reflux'

Actions = Reflux.createActions([
  'addStep'
  'addChapter'
  'updateCodeBlock'
])

  # Steps
Actions.addStep = ->
  console.log 'addStep'

  # Chapter
Actions.addChapter = ->
  console.log 'addStep'

  # Update
Actions.updateCodeBlock = ->
  console.log 'addStep'


module.exports = Actions
