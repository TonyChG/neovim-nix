{ pkgs, src }:
pkgs.vimUtils.buildVimPlugin {
  name = "neogit";
  inherit src;
}
