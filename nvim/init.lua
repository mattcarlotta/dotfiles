require("m6d")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("Installing 'folke/lazy.nvim'...")
    vim.fn.system({ "git", "clone", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "Luxed/ayu-vim",
        lazy = false,
        priority = 1000,
        as = "ayu",
        config = function()
            vim.cmd([[colorscheme ayu]])
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = "nvim-lua/plenary.nvim",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                disable_filetype = { "TelescopePrompt" },
            })
        end,
    },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = "┊",
            show_trailing_blankline_indent = false,
        },
    },

    -- "gc" to comment visual regions/lines
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {},
    },
    {
        "lewis6991/gitsigns.nvim",
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
    },
    "theprimeagen/harpoon",
    "mbbill/undotree",
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    },
    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require("neodim").setup({
                alpha = 0.5,
                blend_color = "#000000",
                update_in_insert = {
                    enable = true,
                    delay = 100,
                },
                -- hide = {
                --     virtual_text = true,
                --     signs = true,
                --     underline = true,
                -- }
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
    },
    "jay-babu/mason-null-ls.nvim"
})
