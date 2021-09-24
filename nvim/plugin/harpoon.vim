lua << EOF
require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
    },
})
EOF

nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <A-m> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <A-y> :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

nnoremap <A-1> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <A-2> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <A-3> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <A-4> :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <leader>hq :lua require("harpoon.term").gotoTerminal(1)<CR>
nnoremap <leader>hw :lua require("harpoon.term").gotoTerminal(2)<CR>
nnoremap <leader>he :lua require("harpoon.term").sendCommand(1, 1)<CR>
nnoremap <leader>hr :lua require("harpoon.term").sendCommand(1, 2)<CR>

