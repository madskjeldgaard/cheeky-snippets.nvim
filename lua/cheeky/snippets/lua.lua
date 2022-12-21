local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local parse = ls.parser.parse_snippet

local SN = {

	-- Snippets for snippets
	s("s", fmt(
		"s({}, {})",
		{ i(1, [["name"]]), i(2, [[fmt("static_cast<{}>({})", { i(1, "int"), i(2, "val") })]]) }
		)
	),
	s("fmt", fmt(
		[[fmt("{}", {{ {} }}, {{ {} }})]],
		{ i(1, [[var = {}]]), i(2, "i(1, 2000)"), i(3, [[ delimiters = "{}" ]]) }
		)
	)
}

return SN
