local savestate = {}
local data = {}
local serialiser

function savestate:persist()
  local file = io.open(serialiser.path, "w")
  if not file then return error("EFILENOTFOUND: [[" .. serialiser.path .. "]]") end
  local datastring = serialiser.serialise(data)
  file:write(datastring)
  io.close(file)
end

function savestate:init(defaults, impl)
  defaults = defaults or {}
  for k,v in pairs(defaults) do
    data[k] = v
  end

  impl = impl or "coronasdk"
  if "table" == type(impl) then
    serialiser = impl
  elseif "string" == type(impl) then
    serialiser = require(impl)
  end
  assert(serialiser.path)
  assert(serialiser.serialise)
  assert(serialiser.deserialise)

  local file = io.open(serialiser.path, "r")
  if not file then return self:persist() end
  local readstring = file:read("*a")
  io.close(file)

  local readtable = serialiser.deserialise(readstring)
  for k,v in pairs(readtable) do
    data[k] = v
  end
end

function savestate:get (key)
  return data[key]
end

function savestate:set (key, value, persist)
  data[key] = value
  if persist then self:persist() end
end

function savestate:keys ()
  local result = {}
  for k in pairs(data) do
    table.insert(result, k)
  end
  return result
end

return savestate