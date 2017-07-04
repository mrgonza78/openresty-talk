
local function echo()
  local socket, err = ngx.req.socket()
  if err then
    ngx.say(err)
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end

  socket:settimeout(1000)
  ngx.say('hello')
  local stream, err = socket:receive("*l")
  while not err or err == 'timeout' do
    if err ~= 'timeout' then
      socket:send("Echoing: "..stream.."\n")
    else
      socket:send("Hello? Is anybody out there?\n")
    end
    stream, err = socket:receive("*l")
  end
  ngx.say('bye')
end

return echo