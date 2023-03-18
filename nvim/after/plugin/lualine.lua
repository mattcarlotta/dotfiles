require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			"mode",
		},
		lualine_b = {
			{
				"branch",
				color = { fg = "#aad541", bg = "#0f131a" },
			},
			{
				"diff",
				symbols = { added = " ", modified = "柳", removed = " " },
				diff_color = {
					added = { fg = "#98be65" },
					modified = { fg = "#ff8800" },
					removed = { fg = "#ec5f67" },
				},
				color = { bg = "#0f131a" },
			},
			{
				"diagnostics",
				symbols = { error = "  ", warn = "  ", info = "  ", hint = " " },
				diagnostics_color = {
					error = { fg = "#ec5f67" },
					warn = { fg = "#ecbe7b" },
					info = { fg = "#008080" },
					hint = { fg = "#ecbe7b" },
				},
				color = { bg = "#0f131a" },
			},
		},
		lualine_c = { "filename" },
		lualine_x = { "progress", "filetype" },
		lualine_y = {
			{
				function()
					local msg = "No Active Lsp"
					local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
				icon = "   LSP:",
				color = { fg = "#555a65", bg = "#0f131a" },
			},
		},
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
