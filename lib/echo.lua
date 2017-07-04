
ngx.log(ngx.NOTICE,'echo module loading ...')

local Echoer = {}

function Echoer.new(state)
  local running, socket, err
  if state then
    socket = state.socket
    running = state.running
  else
    socket, err = ngx.req.socket()
    if err then
      ngx.say(err)
      ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
    end
    socket:settimeout(1000)

    ngx.say('hello')

    running = true
  end

  local echoer = {socket = socket, running = running}
  setmetatable(echoer,{__index=Echoer})
  return echoer
end

function Echoer.hearbeat(echoer)
  local socket = echoer.socket
  local stream, err = socket:receive("*l")

  if not err or err == 'timeout' then
    if err ~= 'timeout' then
      socket:send("Echoing: "..stream.."\n")
    else
      socket:send("Hello? Is anybody out there?\n")
    end
  else
    echoer.running = false
  end
end

ngx.log(ngx.NOTICE,'echo module loaded')

return Echoer