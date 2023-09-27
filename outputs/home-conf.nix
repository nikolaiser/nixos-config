{ inputs
, system
, ...
}:
with inputs; let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
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
