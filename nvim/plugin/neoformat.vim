" Enable alignment
let b:neoformat_basic_format_retab = 1

" Try to save using node_modules/bin
let g:neoformat_try_node_exe = 1

" Formatters for file types 
let g:neoformat_enabled_html = ["prettier"]
let g:neoformat_enabled_javascript = ["prettier"]
let g:neoformat_enabled_typescript = ["prettier"]
let g:neoformat_enabled_rust = ["rustfmt"]

