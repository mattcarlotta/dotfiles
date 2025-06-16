vim.o.completeopt = "menuone,noselect"
-- vim.g.ayucolor = "dark"
-- vim.g.ayu_extended_palette = true

local opt = vim.opt

opt.guicursor = "n-c:block,v:hor1,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- opt.guicursor = ""
opt.nu = true
opt.relativenumber = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.wrap = false

opt.scrolloff = 20
opt.sidescroll = 10
opt.sidescrolloff = 10
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.splitright = true
opt.splitbelow = true

opt.updatetime = 50

-- opt.colorcolumn = "120"
