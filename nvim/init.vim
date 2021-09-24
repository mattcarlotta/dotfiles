let g:python3_host_prog = '/usr/bin/python3'
" let g:python_host_prog = '/usr/bin/python2'

syntax enable
filetype plugin indent on

call plug#begin('~/.vim/plugged')

" theme
Plug 'ayu-theme/ayu-vim'

" Completion framework
Plug 'hrsh7th/nvim-compe'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Floating window overlay for defs
Plug 'glepnir/lspsaga.nvim'

" Rust tools
Plug 'rust-lang/rust.vim'

" Format on save
Plug 'sbdchd/neoformat'

" Auto pairs
Plug 'LunarWatcher/auto-pairs'

" Quick comments
Plug 'preservim/nerdcommenter'

" Allow extensions
Plug 'nvim-lua/lsp_extensions.nvim'

" Git commands in vim
Plug 'tpope/vim-fugitive'

" Markdown previewer
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }

" Various snippets 
Plug 'L3MON4D3/LuaSnip'
Plug 'SirVer/ultisnips'
Plug 'rafamadriz/friendly-snippets'

call plug#end()

" Dark version of ayu theme
let ayucolor="dark"   
colorscheme ayu

" Set <leader> keys as spacebar
let mapleader = " "

" Resize window on change
augroup AutoAdjustResize
    autocmd!
    "  autocmd VimResized * wincmd =
    autocmd VimResized * execute "normal! \<C-w>="
augroup end

" Format on save
" Prevents a formatting error when undo was the last action
" before trying to save
augroup fmt
  autocmd!
  au BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup END
