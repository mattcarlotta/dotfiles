local filetype = require("Comment.ft")
local keymap_set = vim.keymap.set

require("Comment").setup({
	mappings = {
		basic = false,
	},
	toggler = {
		line = "<leader>cc",
		block = "<leader>cbb",
	},
	opleader = {
		line = "<leader>c",
	},
	extra = {
		above = "<leader>cO",
		below = "<leader>co",
		eol = "<leader>cA",
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
})

-- Custom comment strings
filetype.http = "# %s"

-- local api = require("Comment.api")
-- keymap_set("n", "<leader>c>", api.call("comment.linewise", "g@"), { expr = true, desc = "Comment region linewise" })
-- keymap_set(
-- 	"n",
-- 	"<leader>c>>",
-- 	api.call("comment.current.linewise", "g@$"),
-- 	{ expr = true, desc = "Comment current line" }
-- )
-- keymap_set(
-- 	"n",
-- 	"<leader>cb>>",
-- 	api.call("comment.current.blockwise", "g@$"),
-- 	{ expr = true, desc = "Comment current block" }
-- )
-- keymap_set(
-- 	"x",
-- 	"<leader>>",
-- 	api.call("comment_current_linewise_op", "g@$"),
-- 	{ expr = true, desc = "Comment region linewise" }
-- )

-- keymap_set("n", "<leader>cu", api.call("uncomment.linewise", "g@"), { expr = true, desc = "Uncomment region linewise" })
-- keymap_set(
-- 	"n",
-- 	"<leader>c<<",
-- 	api.call("uncomment.current.linewise"),
-- 	{ expr = true, desc = "Uncomment current block" }
-- )
-- keymap_set(
-- 	"n",
-- 	"<leader>cb<<",
-- 	api.call("uncomment.current.blockwise"),
-- 	{ expr = true, desc = "Uncomment current block" }
-- )
-- keymap_set("x", "<leader><", api.call("uncomment.current.linewise.op"), { expr = true, desc = "Comment current block" })

keymap_set("n", "<leader>cp", "yycmp", {
	remap = true,
	desc = "Comment and duplicate line",
})
