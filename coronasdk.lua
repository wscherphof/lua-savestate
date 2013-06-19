local json = require("json")

local coronasdk = {}

coronasdk.path = system.pathForFile("savestate.json", system.DocumentsDirectory)

function coronasdk.serialise (object)
  return json.encode(object)
end

function coronasdk.deserialise (text)
  return json.decode(text)
end

return coronasdk
