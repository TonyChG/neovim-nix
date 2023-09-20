# vim: ft=lua
{ pkgs }:
''
    require("lspkind").init({
      mode = 'symbol_text',
      preset = 'codicons',
    })

    require("trouble").setup({})

    require('treesitter-context').setup({
      enable = true,
    })

    require("lsp-format").setup {}

    require("copilot").setup({
      panel = {
        enabled = true,
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
        enabled = true,
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
      },
      copilot_node_command = 'node', -- node.js version must be > 16.x
      server_opts_overrides = {},
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

    --[[ require'lspconfig'.docker_compose_language_service.setup {
      capabilities = capabilities,
      cmd = { "docker-compose-langserver", "--stdio" },
      root_dir = require('lspconfig/util').root_pattern("docker-compose.yml", "docker-compose.yaml"),
      on_attach = require("lsp-format").on_attach,
    } ]]

    require'lspconfig'.gopls.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach,
    }

    require'lspconfig'.rnix.setup {
      capabilities = capabilities,
      on_attach = require("lsp-format").on_attach,
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
      on_attach = require("lsp-format").on_attach,
      settings = {
        yaml = {
          format = {
              bracketSpacing = false,
          },
          schemas = {
            ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "k8s/**/*.yml",
            ["https://taskfile.dev/schema.json"] = "**/Taskfile.yml",
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
            ["https://json.schemastore.org/container-structure-test.json"] = ".cst.yml",
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
      server = {
        on_attach = require("lsp-format").on_attach,
        capabilities = capabilities,
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
            null_ls.builtins.diagnostics.dotenv_linter,
            null_ls.builtins.formatting.black,
            null_ls.builtins.diagnostics.typos,
        },
    })
''
