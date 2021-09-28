" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Code navigation shortcuts
" as found in :help lsp
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gS <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gb    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Quick-fix
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> <F8> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <F9> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

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

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
    capabilities=capabilities,
    -- on_attach is a callback called when the language server attachs to the buffer
    -- on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy diagnostics on save
        checkOnSave = {
            command = "clippy"
        },
        inlayHints = {
            typeHints = true,
            parameterHints = false,
            chainingHints = false
        }
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
