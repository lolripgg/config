vim.cmd([[
  augroup python_format_on_save
    autocmd!
    autocmd BufWritePre *.py Black
    autocmd BufWritePre *.py Isort
  augroup end
]])
