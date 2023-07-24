{ pkgs }:
with pkgs.vimPlugins; [
  # theme
  onedark-nvim
  monokai-pro-nvim
  nvim-web-devicons

  # editing
  ssr-nvim
  kommentary
  nvim-autopairs
  indent-blankline-nvim-lua

  # git
  lazygit-nvim
  gitsigns-nvim
  diffview-nvim

  # ui
  glow-nvim
  toggleterm-nvim
  lualine-nvim
  lualine-lsp-progress
  nvim-tree-lua
  nvim-neoclip-lua
  telescope-nvim
  telescope-recent-files
  plenary-nvim
  sqlite-lua
  registers-nvim

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
  # copilot-vim
  copilot-lua
  copilot-cmp
  trouble-nvim
  lsplens
  lspkind-nvim
  lspsaga-nvim
  lsp-format-nvim
  lsp-status-nvim
  nvim-lspconfig
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-vsnip
  vim-vsnip
  cmp-cmdline
  cmp-emoji

  # rust
  rust-tools-nvim
]
