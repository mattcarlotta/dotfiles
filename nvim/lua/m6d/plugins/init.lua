return {
	{
		"mattcarlotta/depths.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("depths").setup()
		end,
	},
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
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
