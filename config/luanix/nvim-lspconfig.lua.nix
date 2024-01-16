# vim: ft=lua
{ pkgs }:
''  -- Set up nvim-cmp.
  local cmp = require'cmp'

  require('crates').setup()

  require("copilot").setup({
    panel = {
      enabled = false,
      auto_refresh = true,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<cr>",
        refresh = "gr",
        open = "<m-cr>"
      },
      layout = {
        position = "bottom", -- | top | left | right
        ratio = 0.4
      },
    },
    suggestion = {
      enabled = false,
      auto_trigger = false,
      debounce = 75,
      keymap = {
        accept = "<m-l>",
        accept_word = false,
        accept_line = false,
        next = "<m-]>",
        prev = "<m-[>",
        dismiss = "<c-]>",
      },
    },
    filetypes = {
      ["*"] = true,
      yaml = true,
    },
    copilot_node_command = 'node', -- node.js version must be > 16.x
    server_opts_overrides = {},
  })
  require("copilot_cmp").setup()

  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() and has_words_before() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'copilot' },
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'crates' },
    }, {
      { name = 'buffer' },
      { name = 'path' },
      { name = 'emoji' },
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

  require("lspkind").init({
    mode = 'symbol_text',
    preset = 'codicons',
  })

  require("trouble").setup({})

  require('treesitter-context').setup({
    enable = true,
  })

  require("lsp-format").setup {}

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require'lspconfig'.pyright.setup {
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
  }

  require'lspconfig'.terraformls.setup {
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
    root_dir = require("lspconfig.util").root_pattern(".git")
  }

  require'lspconfig'.dockerls.setup {
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
    settings = {
      docker = {
        languageserver = {
          formatter = {
            ignoreMultilineInstructions = true,
          }
        }
      }
    }
  }

  require'lspconfig'.gopls.setup {
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
  }

  require'lspconfig'.nil_ls.setup {
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
    settings = {
      ['nil'] = {
        formatting = {
          command = {"nixpkgs-fmt"},
        },
      },
    },
  }

  require'lspconfig'.eslint.setup {
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
  }

  require'lspconfig'.lua_ls.setup{
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
  }

  require'lspconfig'.yamlls.setup {
    capabilities = capabilities,
    -- on_attach = require("lsp-format").on_attach,
    settings = {
      yaml = {
        format = {
            bracketSpacing = false,
            enable = true,
        },
        customTags = {"!reference sequence"},
        schemas = {
          ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "k8s/**/*.yml",
          ["https://taskfile.dev/schema.json"] = "**/Taskfile.*",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {".gitlab-ci.yml", "ci/environments/**/*.yaml", "ci/modules/**/*.yaml"},
          ["https://json.schemastore.org/container-structure-test.json"] = ".cst.yml",
        },
        editor = {
          formatOnType = true,
          tabSize = 2,
        },
      },
    },
  }

  require("lsp-format").setup {
    typescript = {
      tab_width = function()
        return vim.opt.shiftwidth:get()
      end,
    },
    javascript = { tab_width = 2 },
    vue = { tab_width = 2 },
  }

  local prettier = {
    formatCommand = [[prettier --stdin-filepath ''${INPUT} ''${--tab-width:tab_width}]],
    formatStdin = true,
  }

  require'lspconfig'.volar.setup{
    filetypes = {
      'javascript',
      'json',
      'vue',
    },
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
    init_options = {
      typescript = {
        tsdk = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib"
      }
    },
    settings = {
      languages = {
        javascript = { prettier },
        typescript = { prettier },
        vue = { prettier },
      }
    }
  }

  local rt = require("rust-tools")

  rt.setup({
    tools = {
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = true,
        show_parameter_hints = false,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
      },
    },
    server = {
      on_attach = require("lsp-format").on_attach,
      capabilities = capabilities,
      cmd = { "direnv",  "exec", ".", "rust-analyzer" },
      root_pattern = {"Cargo.toml", "Cargo.lock"},
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    },
  })

  local null_ls = require("null-ls")
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  null_ls.setup({
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
      sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.completion.spell,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.code_actions.impl,
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.completion.vsnip,
          null_ls.builtins.diagnostics.dotenv_linter.with({
            command = "dotenv-linter",
            args = {"--skip", "UnorderedKey"},
          }),
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.typos,
          null_ls.builtins.formatting.yamlfmt,
      },
  })
''
