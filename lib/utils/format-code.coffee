module.exports = DiffFormat = (code) ->
  formatted = ''
  code.split('\n').map (line) ->
    status = line.charAt(0)
    # added or existing lines
    if status is '+' or status is ' '
      formatted += line.slice(1) + '\n'
    else if status is '-'
      console.log 'removed: ', line
  return formatted
