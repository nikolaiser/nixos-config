{ inputs
, system
, ...
}:
with inputs; let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    chromium.commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  };

  imports = [
    neovim-flake.nixosModules.${system}.hm
    hacl.nixosModules.${system}.hm
    ../home/home.nix
  ];
in
{
  nikolaiser-home = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    modules = [{ inherit imports; }];
  };
}
