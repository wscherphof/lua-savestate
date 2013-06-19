# lua-savestate

Persist some keys and values

# Usage

## 1. Install
Setup [lua-loader](https://github.com/wscherphof/lua-loader) and then just `npm install lua-savestate`

## 2. Require
```lua
local savestate = require("lua-savestate")
```

## 3. Init
Comes with one packaged implementation, for the [Corona SDK](http://www.coronalabs.com/products/corona-sdk/), which is also the default, but you still have to initialise it:
```lua
savestate:init()
```
You can provide some default values:
```lua
savestate:init({
  foo = "bar",
  bar = "baz"
})
```
And of course you can provide your own implementation, which would be the second argument to `init`:
```lua
savestate:init(nil, {
  path = "/full/path/to/the/file.ext",
  serialise = function (object)
    return convert_table_with_keys_and_values_to_a_string(object)
  end,
  deserialise = function (text)
    return convert_string_to_a_table_with_keys_and_values(text)
  end
})
```
If you have a custom implementation in a separate lua file, you can pass the module load string for it, eg: `savestate:init(nil, "coronasdk")` (which happens to be equivalent to `savestate:init()`)

## 4. Read & write
To read a value:
```lua
savestate:get("foo")
```
To create or update a value:
```lua
savestate:set("foo", "foobar")
```
To save all values:
```lua
savestate:persist()
```
To get all values saved when setting a value:
```lua
savestate:set("foo", "foobar", true)
```
To get all known values:
```lua
for _,key in savestate:keys() do
  print(key, savestate:get(key))
end
```

# Limitations

- Currently only file-based persistence. API must break to support others.
