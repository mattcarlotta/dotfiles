vim.g.mapleader = " "

local keymap_set = vim.keymap.set

keymap_set("n", "<leader>pv", vim.cmd.Ex)

-- window splitting vertical/horiztonal
keymap_set("n", "<leader>sv", "<C-w>v")
keymap_set("n", "<leader>sh", "<C-w>s")
keymap_set("n", "<leader>se", "<C-w>=")
keymap_set("n", "<leader>sx", ":close<CR>")

-- regex find and replace all
keymap_set("n", "<leader>ra", ":%s/")
-- regex find and replace current line
keymap_set("n", "<leader>rl", ":s/")

-- format on save
keymap_set("n", "<leader>f", vim.cmd.Format)

-- move selection up or down
keymap_set("v", "J", ":m '>+1<CR>gv=gv")
keymap_set("v", "K", ":m '<-2<CR>gv=gv")

keymap_set("n", "J", "mzJ`z")

-- keep cursor in center when skipping lines
keymap_set("n", "<C-d>", "<C-d>zz")
keymap_set("n", "<C-u>", "<C-u>zz")
keymap_set("n", "n", "nzzzv")
keymap_set("n", "N", "Nzzzv")

-- greatest remap ever
keymap_set("x", "<leader>p", [["_dP]])

-- copy to clipboard
keymap_set({"n", "v"}, "<leader>y", [["+y]])
keymap_set("n", "<leader>Y", [["+Y]])

keymap_set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
keymap_set("i", "<C-c>", "<Esc>")

keymap_set("n", "Q", "<nop>")
keymap_set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap_set("n", "<leader>f", vim.lsp.buf.format)
keymap_set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap_set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap_set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap_set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap_set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

keymap_set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
