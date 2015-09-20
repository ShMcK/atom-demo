repo = atom.project.getRepositories()[0]

Git = require './git'
Notifier = require '../../utils/notifier'

gitLog = (hash) ->
  logs = ''
  args = ['log', '--pretty=format:%h']
  args.push hash if hash
  console.log args
  Git.cmd
    args: args
    cwd: repo.getWorkingDirectory()
    stdout: (data) ->
      logs += data
    exit: (code) ->
      if code is 0
        logs = logs.split('\n')
        console.log logs

module.exports = gitLog
