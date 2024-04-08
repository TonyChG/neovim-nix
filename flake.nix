{
  description = "TonyChG neovim flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };

    neovim = {
      url = "github:neovim/neovim/nightly?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    telescope-ghq-src = {
      url = "github:tonychg/telescope-ghq.nvim";
      flake = false;
    };

    telescope-recent-files-src = {
      url = "github:smartpde/telescope-recent-files";
      flake = false;
    };

    neogit-src = {
      url = "github:NeogitOrg/neogit/nightly";
      flake = false;
    };

    lsplens-src = {
      url = "github:VidocqH/lsp-lens.nvim";
      flake = false;
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        overlayFlakeInputs = prev: final: {
          neovim = inputs.neovim.packages.${prev.system}.neovim;

          vimPlugins = final.vimPlugins // {
            telescope-recent-files = import ./packages/vimPlugins/telescopeRecentFiles.nix {
              src = inputs.telescope-recent-files-src;
              pkgs = prev;
            };

            telescope-ghq = import ./packages/vimPlugins/telescopeghq.nix {
              src = inputs.telescope-ghq-src;
              pkgs = prev;
            };

            lsplens = import ./packages/vimPlugins/lsplens.nix {
              src = inputs.lsplens-src;
              pkgs = prev;
            };

            neogit = import ./packages/vimPlugins/neogit.nix {
              src = inputs.neogit-src;
              pkgs = prev;
            };
          };
        };

        overlayNeovimOverride = prev: final: {
          neovimOverride = import ./packages/neovimOverride.nix {
            pkgs = prev;
          };
        };

        pkgs = import inputs.nixpkgs {
          system = system;
          overlays = [ overlayFlakeInputs overlayNeovimOverride ];
        };
      in
      {
        packages = rec {
          nvim = pkgs.neovimOverride;
          default = nvim;
        };

        apps = rec {
          nvim = inputs.flake-utils.lib.mkApp { drv = self.packages.${system}.nvim; };
          default = nvim;
        };
      });
}
