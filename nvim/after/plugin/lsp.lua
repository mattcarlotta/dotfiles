local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    "astro",
    "clangd",
    "eslint",
    "lua_ls",
    "rust_analyzer",
    "tailwindcss",
    "tsserver",
})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lsp.configure("ccls", { lsp = { use_defaults = true } })

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
})

lsp.set_preferences({
    suggest_lsp_servers = false,
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local keymap_set = vim.keymap.set
    lsp.buffer_autoformat()

    keymap_set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    keymap_set("n", "gt", function()
        vim.lsp.buf.type_definition()
    end, opts)
    keymap_set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)
    keymap_set("n", "<leader>ws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    keymap_set("n", "<leader>dof", function()
        vim.diagnostic.open_float()
    end, opts)
    keymap_set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, opts)
    keymap_set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, opts)
    keymap_set("n", "<leader>ca", function()
        vim.lsp.buf.code_action()
    end, opts)
    keymap_set("n", "<leader>rr", function()
        vim.lsp.buf.references()
    end, opts)
    keymap_set("n", "<leader>rn", function()
        vim.lsp.buf.rename()
    end, opts)
    keymap_set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
