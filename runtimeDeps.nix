{ pkgs }:
with pkgs; [
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
  lua-language-server
  # nix
  alejandra
  rnix-lsp
  nixpkgs-fmt
  # rust
  rust-analyzer
  rustfmt
  yamlfmt
  # packages with results in /lib/node_modules/.bin must come at the end
  pyright
  nodejs
  nodePackages.dockerfile-language-server-nodejs
  nodePackages.bash-language-server
  nodePackages.prettier
  nodePackages.typescript
  nodePackages."@volar/vue-language-server"
]

