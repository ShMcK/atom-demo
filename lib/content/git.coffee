{GitRepository} = require 'atom'

class Git
  init: ->
  #TODO: handle multiple repos
    repo = atom.project.getRepositories()[0]
    path = repo.getPath()
    type = repo.getType()

    diff = repo.getDiffStats(path)
    diffLines = repo.getLineDiffs(path, )

    console.log path, type
    console.log diff


module.exports = new Git()
