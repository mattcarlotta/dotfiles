local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local keymap_set = vim.keymap.set

keymap_set("n", "<leader>a", mark.add_file)
keymap_set("n", "<C-e>", ui.toggle_quick_menu)

keymap_set("n", "<leader>1", function()
	ui.nav_file(1)
end)
keymap_set("n", "<leader>2", function()
	ui.nav_file(2)
end)
keymap_set("n", "<leader>3", function()
	ui.nav_file(3)
end)
keymap_set("n", "<leader>4", function()
	ui.nav_file(4)
end)
