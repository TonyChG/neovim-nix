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
  local lsp_status = require("lsp-status")

  lsp_status.register_progress()
  lsp_status.config {
    status_symbol = "",
    indicator_separator = "",
    component_separator = "",
    show_filename = false,
    diagnostics = false,
    current_function = false,
  }

  capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

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

  require'lspconfig'.docker_compose_language_service.setup {
    capabilities = capabilities,
    cmd = { "docker-compose-langserver", "--stdio" },
    filetypes = { "yaml", "yml" },
    root_dir = require('lspconfig/util').root_pattern("docker-compose.yml", "docker-compose.yaml"),
    on_attach = require("lsp-format").on_attach,
  }

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
        schemas = {
          ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "k8s/**/*.yml",
          ["https://taskfile.dev/schema.json"] = "**/Taskfile.yml",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
          ["https://json.schemastore.org/container-structure-test.json"] = ".cst.yml",
        },
      },
    },
  }

  require'lspconfig'.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach = require("lsp-format").on_attach,
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = false;
        },
      }
    }
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
      'vue',
              'json',
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
''
