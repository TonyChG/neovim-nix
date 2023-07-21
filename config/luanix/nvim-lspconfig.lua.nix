# vim: ft=lua
{ pkgs }:
''
  require("lspsaga").setup({})
  require("lspkind").init({
      mode = 'symbol_text',
      preset = 'codicons',
  })
  require("trouble").setup({})
  require('treesitter-context').setup({
      enable = true,
  })
  require("lsp-format").setup {}

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
      snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
              -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
      },
      window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
      }, {
          { name = 'buffer' },
      })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
          { name = 'buffer' },
      })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
          { name = 'buffer' }
      }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
          { name = 'path' }
      }, {
          { name = 'cmdline' }
      })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require'lspconfig'.pyright.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach
  }

  require'lspconfig'.terraformls.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach,
  }

  require'lspconfig'.dockerls.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach,
  }

  require'lspconfig'.gopls.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach,
  }

  require'lspconfig'.rnix.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach
  }

  require'lspconfig'.eslint.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach
  }

  require'lspconfig'.yamlls.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach,
      settings = {
          yaml = {
              schemas = {
                  ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "k8s/**/*.yml",
                  ["https://taskfile.dev/schema.json"] = "**/Taskfile.yml",
                  ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
                  ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.yml",
              },
          },
      },
  }

  require'lspconfig'.lua_ls.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach,
      settings = {
          Lua = {
              runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = 'LuaJIT',
              },
              diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = {'vim'},
              },
              workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                  enable = false,
              },
          },
      },
  }
''
