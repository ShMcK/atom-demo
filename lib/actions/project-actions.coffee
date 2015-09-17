Reflux = require 'reflux'

module.exports = ProjectActions = Reflux.createActions([
  # steps
  'addStep'
  'saveStep'
  'loadStep'
  # chapter
  'addChapter'
  # code block
  'updateCodeBlock'
  # position
  'updateCurrent'
])
