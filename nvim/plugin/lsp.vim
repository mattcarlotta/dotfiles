" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" LSP Code navigation shortcuts
"nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gS    <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> ggD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gtd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gb    <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" LSP Saga Actions
" render hover doc
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" find cursor word definition and reference
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
" signature help
nnoremap <silent> gw <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" code actions
nnoremap <silent><leader>gt <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>gt :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
" preview definition
nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
" rename definition
nnoremap <silent> gr <cmd>lua require('lspsaga.rename').rename()<CR>
" jump diagnostic
nnoremap <silent> <F8> <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> <F9> <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

lua << EOF
local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

require('rust-tools').setup({
    tools = {
        inlay_hints = {
            parameter_hints_prefix = " ",
            other_hints_prefix = " ",
        }
    }
})

-- map buffer local keybindings when the language server attaches
nvim_lsp.tsserver.setup({
    --on_attach = on_attach,
    capabilities = capabilities,
})


require'lspconfig'.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = {
        'javascript', 'javascriptreact', 'json', 'typescript',
        'typescriptreact', 'css', 'less', 'scss', 'markdown'
    },
    init_options = {
        linters = {
            eslint = {
                command = 'eslint_d',
                rootPatterns = {'.git'},
                debounce = 100,
                args = {
                    '--stdin', '--stdin-filename', '%filepath', '--format',
                    'json'
                    },
                sourceName = 'eslint_d',
                parseJson = {
                    errorsRoot = '[0].messages',
                    line = 'line',
                    column = 'column',
                endLine = 'endLine',
            endColumn = 'endColumn',
            message = '[eslint] ${message} [${ruleId}]',
            security = 'severity'
            },
        securities = {
            [2] = 'error',
            [1] = 'warning'
            }
        }
    },
    filetypes = {
        javascript = 'eslint',
        javascriptreact = 'eslint',
        typescript = 'eslint',
        typescriptreact = 'eslint'
    },
    formatters = {
        eslint_d = {
            command = 'eslint_d',
            args = {
                '--stdin', '--stdin-filename', '%filename',
                '--fix-to-stdout'
            },
            rootPatterns = {'.git'}
        },
        prettier = {
            command = 'prettier',
            args = {'--stdin-filepath', '%filename'}
        }
    },
    formatFiletypes = {
        css = 'prettier',
        javascript = 'eslint_d',
        javascriptreact = 'eslint_d',
        json = 'prettier',
        scss = 'prettier',
        less = 'prettier',
        typescript = 'eslint_d',
        typescriptreact = 'eslint_d',
        markdown = 'prettier'
        }
    }
}


--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--  vim.lsp.diagnostic.on_publish_diagnostics, {
--    virtual_text = false,
--        signs = true,
--    update_in_insert = true,
--  }
--)
EOF

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
            \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
