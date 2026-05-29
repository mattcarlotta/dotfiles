return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
				},
			},
			window = {
				position = "current",
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt.relativenumber = true
					end,
				},
			},
		})
	end,
}
