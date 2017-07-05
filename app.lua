local lapis = require("lapis")
local app = lapis.Application()
local respond_to = require("lapis.application").respond_to
local console = require("lapis.console")
local todos = require("models.todo")

app:match("/console", console.make())

app:get("/", function()
  return "Welcome to Lapis " .. require("lapis.version")
end)

app:get("/todos", function(req)
  local paginated = todos:paginated({per_page=req.params.per_page})
  local page = paginated:get_page(req.params.page or 1)
  return { json = {
    num_pages = paginated:num_pages(),
    total_items = paginated:total_items(),
    todos = page
  } }
end)

app:match("/todos/:id", respond_to({
  before = function (req)
    req.todo = todos:find(req.params.id)
  end,
  DELETE = function(req)
    return { json = req.todo:delete() }
  end,
  PUT = function(req)
    req.todo:update(req.params)
    return { json = req.todo }
  end,
  GET = function(req)
    return { json = req.todo }
end}))

app:post("/todos", function(req)
  local todo = todos:create(req.params)
  return { json = todo }
end)

return app
