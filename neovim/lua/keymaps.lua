-- Don't require the shift key for every command.
vim.keymap.set("n", ";", ":")

-- Don't copy deleted lines to the clipboard.
vim.keymap.set({"n", "x"}, "x", '"_x')

-- Copy the path of the current buffer to the clipboard.
vim.keymap.set("n", "<Leader>cl", ":let @*=expand('%:p')<CR>")

-- FZF shortcuts
vim.keymap.set(
  "n",
  "<Leader>t",
  "<CMD>lua require(\"fzf-lua\").files({ cmd=\"rg --files --follow --global '!.git/*' --glob '!vendor/' --hidden\" })<CR>"
)
