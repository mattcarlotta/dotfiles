return {
    "folke/trouble.nvim",
    config = function()
        require("trouble").setup({
            icons = {},
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        })

        local keymap_set = vim.keymap.set
        keymap_set(
            "n",
            "<leader>tt",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            { desc = "[T]rouble [T]oggle", silent = true, noremap = true }
        )
        keymap_set(
            "n",
            "<leader>td",
            "<cmd>Trouble diagnostics toggle<cr>",
            { desc = "[T]rouble [D]ocument", silent = true, noremap = true }
        )
        keymap_set(
            "n",
            "<leader>tf",
            "<cmd>Trouble qflist toggle<cr>",
            { desc = "[T]rouble Quick [F]ix", silent = true, noremap = true }
        )
    end,
}
