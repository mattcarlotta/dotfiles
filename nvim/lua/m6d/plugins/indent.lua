return {
	"lukas-reineke/indent-blankline.nvim",
	-- Enable `lukas-reineke/indent-blankline.nvim`
	-- See `:help indent_blankline.txt`
	main = "ibl",
	config = function()
		require("ibl").update({
			indent = {
				char = "¦",
			},
			scope = {
				enabled = true,
				show_start = false,
				char = "▎",
				-- highlight = { "CursorLineNr" },
			},
		})
	end,
	-- opts = {
	--     char = "┊",
	--     show_trailing_blankline_indent = false,
	-- },
}
