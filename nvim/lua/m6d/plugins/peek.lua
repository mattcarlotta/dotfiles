return {
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			local peek = require("peek")
			peek.setup({
				filetype = { "markdown", "conf" },
				app = "browser",
			})
			vim.keymap.set("n", "<leader>pe", function()
				peek.open()
			end)
			vim.keymap.set("n", "<leader>pc", function()
				peek.close()
			end)
		end,
	},
}
