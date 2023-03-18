local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local keymap_set = vim.keymap.set

keymap_set("n", "<leader>a", mark.add_file)
keymap_set("n", "<C-e>", ui.toggle_quick_menu)

keymap_set("n", "<C-h>", function()
	ui.nav_file(1)
end)
keymap_set("n", "<C-t>", function()
	ui.nav_file(2)
end)
keymap_set("n", "<C-n>", function()
	ui.nav_file(3)
end)
keymap_set("n", "<C-s>", function()
	ui.nav_file(4)
end)
