local M = {}

local ls = require "luasnip"

local defaults = require "cheeky.defaults"

-- Reloads all snippets for cheeky snippets
M.reload = function(opts)
	opts = opts or vim.g.cheeky_config or defaults

	-- Set snippet package to nil
	package.loaded["cheeky.snippets"] = nil

	local snippets = require "cheeky.snippets"

	-- Adds enabled languages' snippets
	for lang, enable in pairs(opts.langs) do
		if enable then

			-- Set all snippet language caches to nil in case this is a reload
			local packageName = "cheeky.snippets." .. lang
			package.loaded[packageName] = nil

			-- and now (re)load
			local reloadOpts = {
				key = "cheeky" -- This is used to make sure old snippets are removed when reused
			}

			ls.add_snippets(lang, snippets[lang], reloadOpts)

		end
	end

end

M.setup = function(opts)
	if opts == nil then
		opts = {}
	end

	-- Merges the given opts with default opts (prefers theirs)
	opts = vim.tbl_deep_extend("force", defaults, opts)

	-- Make cfg global so it will be accessible in snippets
	vim.g.cheeky_config = opts

	-- Load or reload
	M.reload(opts)

	-- Register CheekyReload autocommand
	vim.api.nvim_create_user_command(
        'CheekyReload',
        function(_)
        		M.reload(opts)
        	end,
        {
            nargs = 0,
        }
    )
end

return M
