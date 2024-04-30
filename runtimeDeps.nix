{ pkgs }:
with pkgs; [
  silicon
  typos
  black
  stylua
  ltex-ls
  lazydocker
  terraform-ls
  gopls
  docker-compose-language-service
  vscode-langservers-extracted
  yaml-language-server
  yamllint
  markdown-oxide
  markdownlint-cli
  lua-language-server
  yamlfmt
  alejandra
  nil
  nixpkgs-fmt
  rustfmt
  cargo
  rust-analyzer
  # clippy
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
