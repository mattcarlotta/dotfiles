vim.g.mapleader = " "

local keymap_set = vim.keymap.set

keymap_set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Open file explorer' })
keymap_set("n", "<leader>sk", ":Telescope keymaps<CR>", { desc = '[S]earch [K]eymaps' })

-- window splitting vertical/horiztonal
keymap_set("n", "<leader>sv", "<C-w>v", { desc = '[S]plit [V]ertical' })
keymap_set("n", "<leader>sh", "<C-w>s", { desc = '[S]plit [H]orizontal' })
keymap_set("n", "<leader>se", "<C-w>=", { desc = '[S]plit [E]qual' })
keymap_set("n", "<leader>lw", "<C-w>h<CR>", { desc = 'lL]eft [W]indow' })
keymap_set("n", "<leader>rw", "<C-w>l<CR>", { desc = '[R]ight [W]indow' })
keymap_set("n", "<leader>tw", "<C-w>k<CR>", { desc = '[T]op [W]indow' })
keymap_set("n", "<leader>bw", "<C-w>j<CR>", { desc = '[B]ottom [W]indow' })
keymap_set("n", "<leader>cw", ":close<CR>", { desc = '[C]lose [W]indow' })

-- regex find and replace all
keymap_set("n", "<leader>ra", ":%s/", { desc = '[R]egex applies to [A]ll' })
-- regex find and replace current line
keymap_set("n", "<leader>rl", ":s/", { desc = '[R]egex applies to current [L]ine' })

-- format on save
keymap_set("n", "<leader>f", vim.cmd.Format, { desc = '[F]ormat' })

-- move selection up or down
keymap_set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Moves highlighted selection up' })
keymap_set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Moves highlighted selection down' })

keymap_set("n", "J", "mzJ`z")

-- keep cursor in center when skipping lines
keymap_set("n", "<C-d>", "<C-d>zz", { desc = 'Keeps cursor in center while navigating down' })
keymap_set("n", "<C-u>", "<C-u>zz", { desc = 'Keeps cursor in center while navigating up' })
keymap_set("n", "n", "nzzzv", { desc = 'Keeps cursor in center while jumping to next highlight' })
keymap_set("n", "N", "Nzzzv", { desc = 'Keeps cursor in center while jumping to prev highlight' })

-- greatest remap ever
keymap_set("x", "<leader>p", [["_dP]])

--copy to clipboard
keymap_set({"n", "v"}, "<leader>y", [["+y]], { desc = 'Copies selection to clipboard' })
keymap_set("n", "<leader>Y", [["+Y]])

keymap_set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
keymap_set("i", "<C-c>", "<Esc>")

keymap_set("n", "Q", "<nop>", { desc = 'No op' })
keymap_set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = 'Opens new tmux session' })
keymap_set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap_set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap_set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap_set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap_set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = 'Changes file to be executable', silent = true })

keymap_set("n", "<leader><leader>", function()
    vim.cmd("so")
end, { desc = 'Sources current file' })