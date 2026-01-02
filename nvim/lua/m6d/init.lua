require("m6d.set")
require("m6d.remap")
require("m6d.lazy-init")

local augroup = vim.api.nvim_create_augroup
local m6dGroup = augroup("m6dGroup", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = m6dGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = m6dGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		local keymap_set = vim.keymap.set

		keymap_set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		keymap_set("n", "gt", function()
			vim.lsp.buf.type_definition()
		end, opts)
		keymap_set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts)
		keymap_set("n", "<leader>ws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		keymap_set("n", "<leader>wf", function()
			vim.diagnostic.open_float()
		end, opts)
		keymap_set("n", "]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, opts)
		keymap_set("n", "[d", function()
			vim.diagnostic.jump({ count = -1 })
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
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, opts)
	end,
})
