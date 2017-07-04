
local Reloader = {}

function Reloader.new()
  local reloader = { reloaded_at = ngx.time() }
  setmetatable(reloader,{__index=Reloader})
  return reloader
end

function Reloader.should_reload(reloader)
  local f = io.popen("stat -c %Y /code/reload.txt")
  local modified = f:read()
  return modified and tonumber(modified) > reloader.reloaded_at
end

function Reloader.do_reload(reloader)
  local compiled_echo = loadfile('/code/lib/echo.lua')
  local echo = compiled_echo()
  package.loaded['lib.echo'] = echo
  reloader.reloaded_at = ngx.time()
end

return Reloader
