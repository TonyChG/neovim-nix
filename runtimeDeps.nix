{ pkgs }:
with pkgs; [
  ripgrep
  xsel
  stylua
  ltex-ls
  lazygit
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
  rustc
  rust-analyzer
  rustfmt
  cargo
  # packages with results in /lib/node_modules/.bin must come at the end
  pyright
  nodePackages.dockerfile-language-server-nodejs
  nodePackages.bash-language-server
]

