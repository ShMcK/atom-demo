repo = atom.project.getRepositories()[0]

Git = require './git'
Notifier = require '../../utils/notifier'

gitCheckout = (hash) ->
  args = ['checkout']
  args.push hash if hash.length
  console.log args
  Git.cmd
    args: args
    cwd: repo.getWorkingDirectory()
    exit: (code) ->
      if code is 0
        console.log 'checkout failed: ', code

module.exports = gitCheckout
