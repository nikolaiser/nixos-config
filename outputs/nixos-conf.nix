{ inputs, system, ... }:

let 
  inherit (inputs.nixpkgs.lib) nixosSystem;

  lib = inputs.nixpkgs.lib;

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

in {
  home-desktop = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      ../system/machine/home-desktop
      ../system/configuration.nix
    ];
  };
}
