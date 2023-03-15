local builtin = require('telescope.builtin')

local keymap_set = vim.keymap.set

keymap_set('n', '<leader>pf', builtin.find_files, {})
keymap_set('n', '<C-p>', builtin.git_files, {})
keymap_set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
