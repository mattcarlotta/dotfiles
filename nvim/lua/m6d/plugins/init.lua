return {
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{
		"mattcarlotta/depths.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("depths").setup()
		end,
	},
	-- {
	-- 	"Luxed/ayu-vim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	as = "ayu",
	-- 	config = function()
	-- 		vim.cmd([[colorscheme ayu]])
	-- 	end,
	-- },
}
