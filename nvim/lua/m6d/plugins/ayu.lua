return {
    "Luxed/ayu-vim",
    lazy = false,
    priority = 1000,
    as = "ayu",
    config = function()
        vim.cmd([[colorscheme ayu]])
    end,
}
