local ls = require("luasnip")

local function load_snippets()
	local snippets = {
		typescript = require("m6d.snippets.typescript"),
		-- javascript = require("m6d.snippets.javascript"),
		-- lua = require("m6d.snippets.lua"),
	}

	for ft, snips in pairs(snippets) do
		ls.add_snippets(ft, snips)
	end

	-- Extend filetypes that share snippets
	ls.filetype_extend("typescriptreact", { "typescript" })
	ls.filetype_extend("javascriptreact", { "javascript" })
end

return { load = load_snippets }
