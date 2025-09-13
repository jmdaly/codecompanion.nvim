local h = require("tests.helpers")
local adapter

local new_set = MiniTest.new_set
T = new_set()

T["Goose ACP adapter"] = new_set({
  hooks = {
    pre_case = function()
      adapter = require("codecompanion.adapters.acp").resolve("goose")
    end,
  },
})

T["Goose ACP adapter"]["can be resolved"] = function()
  h.eq("goose", adapter.name)
  h.eq("Goose 🪿", adapter.formatted_name)
  h.eq("acp", adapter.type)
end

T["Goose ACP adapter"]["has correct roles"] = function()
  h.eq({
    llm = "assistant",
    user = "user",
  }, adapter.roles)
end

T["Goose ACP adapter"]["has correct default command"] = function()
  h.eq({
    "goose",
    "acp",
  }, adapter.commands.default)
end

T["Goose ACP adapter"]["has proper parameters"] = function()
  h.eq(1, adapter.parameters.protocolVersion)
  h.eq("CodeCompanion.nvim", adapter.parameters.clientInfo.name)
  h.eq(true, adapter.parameters.clientCapabilities.fs.readTextFile)
  h.eq(true, adapter.parameters.clientCapabilities.fs.writeTextFile)
end

T["Goose ACP adapter"]["has map_roles method"] = function()
  h.eq("function", type(adapter.map_roles))
end

return T
