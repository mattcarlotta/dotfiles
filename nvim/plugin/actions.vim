" Misc actions
nnoremap <leader>q :q<CR>
nnoremap <leader>fq :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>ins :PlugInstall<CR>
nnoremap <leader>cx :!chmod +x %<CR>
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

noremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y gg"+yG

vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

nnoremap <leader>md :MarkdownPreview<CR>
nnoremap <leader>mc :MarkdownPreviewStop<CR>
nnoremap <leader>mt :MarkdownPreviewToggle<CR>

