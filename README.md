# Cheeky Snippets

Some useful snippets for [LuaSnip](https://github.com/L3MON4D3/LuaSnip).

Inspired by [spoon.nvim](https://github.com/utilyre/spoon.nvim)

## Supported Languages

* General Snippets aka `all` (available everywhere)
* Lua
* CPP (with support for a lot of STL containers and algos and modern c++ stuff etc.)
* Assembly

## Installation

```lua
use{
	"madskjeldgaard/cheeky-snippets.nvim",
	requires = {
		"L3MON4D3/LuaSnip"
	},
	config = function()
	local cheeky = require("cheeky")
		cheeky.setup({
			langs = {
				all = true,
				lua = true,
				cpp = true,
				asm = true,
			},
		})			
	end
}
```

## Development

The command `:CheekyReload` will reload all snippets. This is useful when developing new snippets for this plugin. Run it after you've added something new and want to test it imediately.
