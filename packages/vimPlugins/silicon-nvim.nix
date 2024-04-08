{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "silicon-nvim";
  inherit src;
}
