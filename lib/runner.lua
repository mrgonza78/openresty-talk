

local function run()
  local reloader = require('lib.reloader').new()
  local echoer = require('lib.echo').new()

  while echoer.running do
    echoer:hearbeat()
    if reloader:should_reload() then
      reloader:do_reload()
      echoer = require('lib.echo').new(echoer)
    end
  end
end

return run