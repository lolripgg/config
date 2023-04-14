local M = {}

function M.setup()
  vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
  ]])

  return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use({
      "Shatur/neovim-ayu",
      config = function ()
        require('ayu').setup({})
        vim.cmd('colorscheme ayu')
      end
    })

    use({
      "easymotion/vim-easymotion",
      config = function ()
        vim.g.EasyMotion_smartcase = 1

        vim.keymap.set("n", "/", "<Plug>(easymotion-sn)")
      end,
    })

    use("editorconfig/editorconfig-vim")

    use("fisadev/vim-isort")

    use({
      "ibhagwan/fzf-lua",
      requires = {
        "nvim-tree/nvim-web-devicons",
      },
    })

    -- use("ludovicchabant/vim-gutentags")

    use({
      "neovim/nvim-lspconfig",
      config = function ()
        local lspconfig = require('lspconfig')
        local opts = { noremap=true, silent=true }

        vim.keymap.set("n", "<Leader>gd", "<CMD>lua vim.lsp.bug.definition()<CR>", opts)
        vim.keymap.set("n", "<Leader>gb", "<C-t>", opts)

        lspconfig.ruby_ls.setup({
          on_attach = function (client, buffer)
            pcall(on_attach, client, buffer)

            local diagnostics_handler = function ()
              local params = vim.lsp.util.make_text_document_params(buffer)

              client.request(
                "textDocument/diagnostic",
                {textDocument = params},
                function (err, result)
                  if err then
                    local err_msg = string.format("ruby-lsp - diagnostics error - %s", vim.inspect(err))
                    vim.lsp.log.error(err_msg)
                  end

                  if not result then return end

                  vim.lsp.diagnostic.on_publish_diagnostics(
                    nil,
                    vim.tbl_extend("keep", params, { diagnostics = result.items }),
                    { client_id = client.id }
                  )
                end
              )
            end

            diagnostics_handler()

            local ruby_group = vim.api.nvim_create_augroup("ruby_ls", {clear = false})

            vim.api.nvim_create_autocmd(
              {"BufEnter", "BufWritePre", "InsertLeave", "TextChanged"},
              {
                buffer = buffer,
                callback = diagnostics_handler,
                group = ruby_group,
              }
            )
          end,
        })
      end,
    })

    use("nvim-tree/nvim-web-devicons")

    use({
      "preservim/nerdcommenter",
      config = function ()
        vim.g.NERDCommentEmptyLines = 1
        vim.g.NERDDefaultAlign = "left"
        vim.g.NERDSpaceDelims = 1
        vim.g.NERDTrimTrailingWhitespace = 1
      end,
    })

    use({
      "preservim/nerdtree",
      config = function ()
        vim.g.NERDTreeIgnore = {"node_modules"}

        vim.keymap.set("n", "<Leader>nt", ":NERDTreeToggle<CR>")
        vim.keymap.set("n", "<Leader>nr", ":NERDTreeFind<CR>")
      end,
    })

    use("psf/black")

    -- use({
    --   "skywind3000/gutentags_plus",
    --   config = function ()
    --     vim.g.gutentags_cache_dir = "/Users/james/.cache/tags"
    --     vim.g.gutentags_modules = {"ctags", "gtags_cscope"}
    --     vim.g.gutentags_plus_switch = 1
    --
    --     vim.keymap.set("n", "<Leader>td", "<Plug>GscopeFindDefinition")
    --   end,
    -- })

    -- use({
    --   "preservim/tagbar",
    --   config = function ()
    --     vim.keymap.set("n", "<Leader>tt", ":TagbarOpen fj<CR>")
    --     vim.keymap.set("n", "<Leader>tc", ":TagbarClose<CR>")
    --   end,
    -- })
  end)
end

return M
