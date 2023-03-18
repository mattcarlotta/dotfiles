vim.o.completeopt = "menuone,noselect"
vim.g.ayucolor = "dark"
vim.g.ayu_extended_palette = true

local opt = vim.opt

opt.guicursor = ""
opt.nu = true
opt.relativenumber = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.wrap = false

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.splitright = true
opt.splitbelow = true

opt.updatetime = 50

-- opt.colorcolumn = "120"
