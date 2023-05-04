vim.g.mapleader = ','

vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.tabstop = 2

-- Don't copy deleted lines to the clipboard.
vim.keymap.set({'n', 'x'}, 'x', '"_x')

-- Hitting the shift key every time you type a command is a pain in the ass.
vim.keymap.set('n', ';', ':')

-- Copy the path of the current buffer to the clipboard.
vim.keymap.set('n', '<Leader>cl', ':let @*=expand("%:p")<CR>')

vim.keymap.set("n", ",t", "<CMD>lua require(\"fzf-lua\").files({ cmd=\"rg --files --follow --glob '!.git/*' --glob '!vendor/' --hidden\" })<CR>")
vim.keymap.set("n", ",b", "<CMD>lua require(\"fzf-lua\").buffers()<CR>")
vim.keymap.set("n", ",r", "<CMD>lua require(\"fzf-lua\").tags()<CR>")

require("plugins").setup()

vim.cmd("syntax on")
vim.cmd("hi Visual ctermfg=NONE ctermbg=254")
vim.cmd("autocmd BufWritePre * :%s/\\s\\+$//ge")
