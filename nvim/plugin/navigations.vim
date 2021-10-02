" Prevent arrow navigations in visual mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>

" Menu Navigations
nnoremap <C-j> :cprev<CR> 
nnoremap <C-k> :cnext<CR> 

" Pain (pane) navigations
nnoremap <leader>pc <C-w>o<CR>
nnoremap <leader>h <C-w>h<CR>
nnoremap <leader>l <C-w>l<CR>

" Search navigations
nnoremap <leader>ps :Sex<CR>
nnoremap <leader>pv :Vex!<CR><C-w>=
nnoremap <leader>pe :Ex<CR>
nnoremap <leader>ts :!tmux neww tmux-sessionizer<CR>
nnoremap <leader>d  :Telescope live_grep<cr>
nnoremap <leader>pf :Files<CR>

