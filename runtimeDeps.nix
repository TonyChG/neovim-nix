{ pkgs }:
with pkgs; [
  typos
  black
  stylua
  ltex-ls
  lazydocker
  terraform-ls
  gopls
  opentofu
  docker-compose-language-service
  vscode-langservers-extracted
  yaml-language-server
  yamllint
  lua-language-server
  yamlfmt
  # nix
  alejandra
  nil
  nixpkgs-fmt
  # rust
  cargo
  rust-analyzer
  rustfmt
  clippy
  # php
  phpactor
  # packages with results in /lib/node_modules/.bin must come at the end
  pyright
  nodejs
  nodePackages.dockerfile-language-server-nodejs
  nodePackages.bash-language-server
  nodePackages.prettier
  nodePackages.typescript
  nodePackages."@volar/vue-language-server"
]
