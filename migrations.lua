local schema = require("lapis.db.schema")
local types = schema.types

return {
  [1] = function()
    schema.create_table("todos", {
      { "id", types.serial },
      "PRIMARY KEY (id)"
    })
  end,
  [2] = function()
    schema.add_column("todos", "text", types.varchar)
  end
}