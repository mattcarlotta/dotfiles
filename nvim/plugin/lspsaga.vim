" lsp provider to find the cursor word definition and reference
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

" code action
nnoremap <silent><leader>da <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>da :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>

" show hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>

" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>

" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" show signature help
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>

" rename
nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>

" preview definition
nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>

" show
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

" only show diagnostic if cursor is over the area
" nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>

" jump diagnostic
nnoremap <silent> <F8> <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> <F9> <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

" float terminal also you can pass the cli command in open_float_terminal function
nnoremap <silent> <leader>t <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
tnoremap <silent> <leader>tc <cmd>lua require('lspsaga.floaterm').close_float_terminal()<CR>

lua << EOF
require'lspsaga'.init_lsp_saga({
    -- add your config value here
    -- default value
    -- use_saga_diagnostic_sign = true
    error_sign = '',
    warn_sign = '',
    hint_sign = '',
    -- infor_sign = '',
    -- dianostic_header_icon = '   ',
    code_action_icon = '',
    -- code_action_prompt = {
    --   enable = true,
    --   sign = true,
    --   sign_priority = 20,
    --   virtual_text = true,
    -- },
    -- finder_definition_icon = '  ',
    -- finder_reference_icon = '  ',
    -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
    -- finder_action_keys = {
    --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    -- },
    -- code_action_keys = {
    --   quit = 'q',exec = '<CR>'
    -- },
    -- rename_action_keys = {
    --   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
    -- },
    definition_preview_icon = '',
    -- "single" "double" "round" "plus"
    -- border_style = "single"
    -- rename_prompt_prefix = '➤',
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = {metals = {'sbt', 'scala'}}
    -- server_filetype_map = {}
})
EOF
