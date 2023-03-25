vim.g.mapleader = " "

local keymap_set = vim.keymap.set

keymap_set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })
keymap_set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "[S]earch [K]eymaps" })
keymap_set("n", "<leader>pc", "<cmd>PackerSync<CR>", { desc = "[P]acker syn[C]" })

-- window splitting vertical/horiztonal
keymap_set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertical" })
keymap_set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [H]orizontal" })
keymap_set("n", "<leader>se", "<C-w>=", { desc = "[S]plit [E]qual" })
keymap_set("n", "<leader>wl", "<C-w>h<CR>", { desc = "lL]eft [W]indow" })
keymap_set("n", "<leader>wr", "<C-w>l<CR>", { desc = "[R]ight [W]indow" })
keymap_set("n", "<leader>wt", "<C-w>k<CR>", { desc = "[T]op [W]indow" })
keymap_set("n", "<leader>wb", "<C-w>j<CR>", { desc = "[B]ottom [W]indow" })
keymap_set("n", "<leader>wc", "<cmd>close<CR>", { desc = "[C]lose [W]indow" })

keymap_set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

keymap_set("n", "<leader>lr", "<cmd>LspRestart<CR>", { desc = "[L]sp [R]estart" })

keymap_set(
	"n",
	"<leader>qf",
	"<cmd>TroubleToggle quickfix<cr>",
	{ desc = "[Q]uick [F]ix", silent = true, noremap = true }
)

keymap_set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- regex find and replace all
keymap_set("n", "<leader>rf", ":%s/", { desc = "[R]egex applies to [F]ile" })
-- regex find and replace current line
keymap_set("n", "<leader>rl", ":s/", { desc = "[R]egex applies to current [L]ine" })

-- format
keymap_set("n", "<leader>fd", vim.lsp.buf.format, { desc = "[F]ormat using [D]efault formatter" })
keymap_set("n", "<leader>fl", function()
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end, { desc = "[F]ormat using [L]SP formatter" })

-- move selection up or down
keymap_set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves highlighted selection up" })
keymap_set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves highlighted selection down" })

keymap_set("n", "J", "mzJ`z")

-- keep cursor in center when skipping lines
keymap_set("n", "<C-d>", "<C-d>zz", { desc = "Keeps cursor in center while navigating down" })
keymap_set("n", "<C-u>", "<C-u>zz", { desc = "Keeps cursor in center while navigating up" })
keymap_set("n", "n", "nzzzv", { desc = "Keeps cursor in center while jumping to next highlight" })
keymap_set("n", "N", "Nzzzv", { desc = "Keeps cursor in center while jumping to prev highlight" })

-- greatest remap ever
keymap_set("x", "<leader>p", [["_dP]])

--copy to clipboard
keymap_set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copies selection to clipboard" })
keymap_set("n", "<leader>Y", [["+Y]])

keymap_set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
keymap_set("i", "<C-c>", "<Esc>")

keymap_set("n", "Q", "<nop>", { desc = "No op" })
keymap_set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Opens new tmux session" })
keymap_set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap_set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap_set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap_set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap_set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Changes file to be executable", silent = true })

keymap_set("n", "<leader><leader>", function()
	vim.cmd("so")
end, { desc = "Sources current file" })
