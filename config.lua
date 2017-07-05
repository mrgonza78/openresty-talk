local config = require("lapis.config")

config("development", {
  postgres = {
    host = "172.17.0.3",
    user = nil,
    password = nil,
    database = "todos_db"
  }
})