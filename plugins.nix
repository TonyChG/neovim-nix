{ pkgs }:
with pkgs.vimPlugins; [
  # theme
  rose-pine
  nvim-web-devicons

  # editing
  ssr-nvim
  kommentary
  nvim-spectre
  indent-blankline-nvim-lua
  nvim-surround
  undotree
  venn-nvim

  # git
  gitsigns-nvim
  diffview-nvim
  neogit

  # ui
  glow-nvim
  toggleterm-nvim
  lualine-nvim
  lualine-lsp-progress
  nvim-tree-lua
  nvim-neoclip-lua
  telescope-nvim
  telescope-ghq
  telescope-recent-files
  plenary-nvim
  sqlite-lua
  registers-nvim
  fzf-lua
  which-key-nvim
  nvim-bqf

  # syntax
  (nvim-treesitter.withPlugins (
    p: [
      p.javascript
      p.typescript
      p.lua
      p.html
      p.bash
      p.css
      p.jsdoc
      p.nix
      p.scss
      p.tsx
      p.rust
      p.yaml
      p.json
      p.dockerfile
      p.gomod
      p.puppet
      p.scss
      p.sql
      p.terraform
      p.jsonnet
      p.markdown
      p.python
      p.vim
      p.vimdoc
      p.php
      p.vue
    ]
  ))
  nvim-treesitter-context

  # completion
  copilot-lua
  copilot-cmp
  trouble-nvim
  lsplens
  lspsaga-nvim
  lspkind-nvim
  lsp-format-nvim
  lsp-status-nvim
  null-ls-nvim
  nvim-lspconfig
  vim-vsnip
  vim-vsnip-integ
  nvim-cmp
  cmp-git
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-vsnip
  cmp-cmdline
  cmp-emoji

  # rust
  crates-nvim
  rust-tools-nvim
]
