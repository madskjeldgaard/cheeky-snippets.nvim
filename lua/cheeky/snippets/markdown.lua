local ls = require "luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local parse = ls.parser.parse_snippet
local rep = require("luasnip.extras").rep

local common = require "cheeky.common"

local MD = {}

-- code snippets
local filetypes = {
  "bash",
  "lua",
  "markdown",
  "supercollider",
  "cpp",
  "c",
  "javascript",
  "rust",
}

for _, value in pairs(filetypes) do
  local codesnip = s(
    value,
    fmt(
      string.format(
        [[```%s
	{}
```]],
        value
      ),
      { i(1, "") }
    )
  )

  MD[value] = codesnip
end

MD["img"] = s(
  "img",
  fmt([[ ![{}]({}) ]], {
    i(1, "imagename"),
    i(2, "path/to/img"),
  })
)

return MD
