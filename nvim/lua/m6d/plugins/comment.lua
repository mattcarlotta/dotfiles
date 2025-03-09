return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	opts = {
		mappings = {
			basic = true,
		},
		toggler = {
			line = "<leader>gcc",
			block = "<leader>gcb",
		},
		opleader = {
			line = "<leader>gc",
			block = "<leader>gb",
		},
		extra = {
			above = "<leader>gcO",
			below = "<leader>gco",
			eol = "<leader>gcA",
		},
		ignore = "^$", -- Ignore empty lines
		pre_hook = function(ctx)
			if vim.bo.filetype == "typescriptreact" then
				local c_utils = require("Comment.utils")
				local ts_context_utils = require("ts_context_commentstring.utils")
				local type = ctx.ctype == c_utils.ctype.linewise and "__default" or "__multiline"
				local location

				if ctx.ctype == c_utils.ctype.blockwise then
					location = ts_context_utils.get_cursor_location()
				elseif ctx.cmotion == c_utils.cmotion.v or ctx.cmotion == c_utils.cmotion.V then
					location = ts_context_utils.get_visual_start_location()
				end

				return require("ts_context_commentstring.internal").calculate_commentstring({
					key = type,
					location = location,
				})
			end
		end,
	},
}
