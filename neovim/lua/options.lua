vim.g.mapleader = ","
vim.g.python3_host_prog = "/Users/james/.asdf/shims/python"
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.tabstop = 2

-- Removing trailing whitespace on save.
vim.cmd("autocmd BufWritePre * :%s/\\s\\+$//ge")
vim.cmd("hi Visual ctermfg=NONE ctermbg=254")
vim.cmd("syntax on")
