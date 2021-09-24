" Turn off default nerd commenter mappings
let g:NERDCreateDefaultMappings = 0

" Comment out the current line or text selected in visual mode.
map <silent> <leader>dc <Plug>NERDCommenterComment<CR>

" Same as above but forces nesting
map <silent> <leader>dn <Plug>NERDCommenterNested<CR>

" Comments the current line from the cursor to the end of line
map <silent> <leader>dg <Plug>NERDCommenterToEOL<CR>

" Toggles the comment state of the selected line(s). 
map <silent> <leader>dt <Plug>NERDCommenterToggle<CR>

" Uncomments lines
map <silent> <leader>du <Plug>NERDCommenterUncomment<CR>

" Yanks and comments lines
map <silent> <leader>dy <Plug>NERDCommenterYank<CR>
