local function prequire(...)
  local status, lib = pcall(require, ...)
  if status then
    return lib
  end
  return nil
end

local ls = prequire "luasnip"
local cmp = prequire "cmp"
local s = ls.snippet
local ps = ls.parser.parse_snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local ai = require "luasnip.nodes.absolute_indexer"
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.conditions"

-- snippets
local SN = {
  s(
    "autocommand",
    fmt(
      [[ vim.api.nvim_create_autocmd(
    [],
    { command = [] })]],
      { i(1, [["BufReadPost"]]), i(2, [[print("oh hey guys!")]]) },
      { delimiters = "[]" }
    )
  ),

  s(
    "excommand",
    fmt([[vim.api.nvim_create_user_command('[]', [], [])]], {
      i(1, "MyCrazyCommand"),
      i(2, "function() print([[yeeey]]) end"),
      i(3, "{}"),
    }, {
      delimiters = "[]",
    })
  ),
  s(
    "table-print",
    fmta(
      [[
    for index, data in ipairs(<table>) do
        print(index)
        for key, value in pairs(data) do
            print('\t', key, value)
        end
    end
    ]],
      {
        table = i(1, "?"),
      }
    )
  ),
  s(
    "table-merge",
    fmta(
      [[
    for k,v in pairs(<2>) do <1>[k] = v end
    ]],
      {
        i(1, "first table"),
        i(2, "second table"),
      }
    )
  ),
}

-- snippets for snippets
local SN4SN = {
  s("s", fmt([[s("{}", {})]], { i(1, [[name]]), i(2, [[fmt("static_cast<{}>({})", { i(1, "int"), i(2, "val") })]]) })),
  s(
    "fmt",
    fmt([[fmt("{}", {{ {} }}, {{ {} }})]], { i(1, [[var = {}]]), i(2, "i(1, 2000)"), i(3, [[ delimiters = "{}" ]]) })
  ),
}

--[[
if the parent folder of a lua buffer is named 'snippets'
append snippets for snippets to the snippets :)~
--]]
-- if vim.fn.expand "%:p:h:t" == "snippets" then
-- print "lets write some snippets"
local snippets = { unpack(SN) }
for I = 1, #SN4SN do
  snippets[#SN + I] = SN4SN[I]
end
SN = snippets
-- end

return SN
