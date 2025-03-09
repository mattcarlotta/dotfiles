return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        require("telescope").setup({})

        local builtin = require("telescope.builtin")
        local keymap_set = vim.keymap.set

        keymap_set("n", "<leader>sk", builtin.help_tags, { desc = "[S]earch [K]eymaps" })
        keymap_set("n", "<leader>pf", builtin.find_files, { desc = "[P]review [F]iles" })
        keymap_set("n", "<leader>pg", builtin.git_files, { desc = "[P]review [G]it files" })
        keymap_set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
    end,
}
