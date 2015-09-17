Reflux = require 'reflux'

ProjectActions = Reflux.createActions([
  # steps
  'addStesp'
  'saveStep'
  'loadStep'
  # chapter
  'addChapter'
  # code block
  'updateCodeBlock'
  # position
  'updateCurrent'
])

module.exports = ProjectActions
