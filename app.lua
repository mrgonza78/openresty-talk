local lapis = require("lapis")
local app = lapis.Application()
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

app:get("/todos/:id", function(req)
  local todo = todos:find(req.params.id)
  return { json = todo }
end)

app:post("/todos", function(req)
  local todo = todos:create(req.params)
  return { json = todo }
end)

app:put("/todos/:id", function(req)
  local todo = todos:find(req.params.id)
  todo:update(req.params)
  return { json = todo }
end)

app:delete("/todos/:id", function(req)
  local todo = todos:find(req.params.id)
  return { json = todo:delete() }
end)

return app
