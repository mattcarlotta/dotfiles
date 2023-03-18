local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"astro",
	"tailwindcss",
	"tsserver",
	"eslint",
	"lua_ls",
	"rust_analyzer",
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

local lsp_buf = vim.lsp.buf
local diagnostic = vim.diagnostic

lsp.on_attach(function(_client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local keymap_set = vim.keymap.set

	keymap_set("n", "gd", function()
		lsp_buf.definition()
	end, opts)
	keymap_set("n", "gt", function()
		lsp_buf.type_definition()
	end, opts)
	keymap_set("n", "K", function()
		lsp_buf.hover()
	end, opts)
	keymap_set("n", "<leader>ws", function()
		lsp_buf.workspace_symbol()
	end, opts)
	keymap_set("n", "<leader>dof", function()
		diagnostic.open_float()
	end, opts)
	keymap_set("n", "[d", function()
		diagnostic.goto_next()
	end, opts)
	keymap_set("n", "]d", function()
		diagnostic.goto_prev()
	end, opts)
	keymap_set("n", "<leader>ca", function()
		lsp_buf.code_action()
	end, opts)
	keymap_set("n", "<leader>rr", function()
		lsp_buf.references()
	end, opts)
	keymap_set("n", "<leader>rn", function()
		lsp_buf.rename()
	end, opts)
	keymap_set("i", "<C-h>", function()
		lsp_buf.signature_help()
	end, opts)
end)

local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

lsp.build_options("null_ls", {})

null_ls.setup({
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_buf.format({
						filter = function(c)
							return c.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,

	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint_d,
	},
})

require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
	automatic_setup = false,
})

lsp.setup()

diagnostic.config({
	virtual_text = true,
})
