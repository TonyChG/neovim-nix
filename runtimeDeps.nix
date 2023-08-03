{ pkgs }:
with pkgs; [
  fd
  gh
  ghq
  glab
  fasd
  sops
  neovim-remote
  chezmoi
  ripgrep
  xsel
  typos
  black
  stylua
  ltex-ls
  lazygit
  lazydocker
  terraform-ls
  gopls
  docker-compose-language-service
  vscode-langservers-extracted
  yaml-language-server
  lua-language-server
  # nix
  alejandra
  rnix-lsp
  nixpkgs-fmt
  # rust
  rust-analyzer
  rustfmt
  # packages with results in /lib/node_modules/.bin must come at the end
  pyright
  nodePackages.dockerfile-language-server-nodejs
  nodePackages.bash-language-server
  nodePackages.prettier
  nodePackages.typescript
  nodePackages."@volar/vue-language-server"
]

