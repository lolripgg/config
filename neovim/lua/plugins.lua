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

        lspconfig.ruff_lsp.setup({
          init_options = {
            settings = {
              args = {},
            },
          },
          on_attach = function (client, bufnr)
            local opts = { noremap=true, silent=true }
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap=true, silent=true, buffer=bufnr }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
            vim.keymap.set('n', '<space>wl', function()
              print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, bufopts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
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
  end)
end

return M
