{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "telescope-ghq";
  inherit src;
}
