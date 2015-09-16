{flux} = require './constants'

flux.on("dispatch", (type, payload) ->
  if (console && console.log)
    console.log("[Dispatch]", type, payload);
