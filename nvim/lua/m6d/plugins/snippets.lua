return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",

		dependencies = { "rafamadriz/friendly-snippets" },

		config = function()
			local ls = require("luasnip")
			ls.filetype_extend("javascript", { "jsdoc" })

			require("m6d.snippets").load()

			vim.keymap.set({ "i", "s" }, "<Tab>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
}
-- return {
-- 	{
-- 		"L3MON4D3/LuaSnip",
-- 		-- follow latest release.
-- 		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
-- 		-- install jsregexp (optional!).
-- 		build = "make install_jsregexp",

-- 		dependencies = { "rafamadriz/friendly-snippets" },

-- 		config = function()
-- 			local ls = require("luasnip")
-- 			ls.filetype_extend("javascript", { "jsdoc" })

-- 			require("m6d.snippets").load()

-- 			vim.keymap.set({ "i" }, "<C-s>e", function()
-- 				ls.expand()
-- 			end, { silent = true })

-- 			vim.keymap.set({ "i", "s" }, "<C-s>;", function()
-- 				ls.jump(1)
-- 			end, { silent = true })
-- 			vim.keymap.set({ "i", "s" }, "<C-s>,", function()
-- 				ls.jump(-1)
-- 			end, { silent = true })

-- 			vim.keymap.set({ "i", "s" }, "<C-E>", function()
-- 				if ls.choice_active() then
-- 					ls.change_choice(1)
-- 				end
-- 			end, { silent = true })
-- 		end,
-- 	},
-- }
