{ inputs
, system
, ...
}:
let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  lib = inputs.nixpkgs.lib;

  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  alienModule =
    { _
    , s
    , ...
    }: {
      environment.systemPackages = with inputs.nix-alien.packages.${system}; [
        nix-alien
      ];
      # Optional, needed for `nix-alien-ld`
      programs.nix-ld.enable = true;
    };

  alejandraModule = {
    environment.systemPackages = [ inputs.alejandra.defaultPackage.${system} ];
  };
in
{
  home-desktop = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      alienModule
      alejandraModule
      ../system/machine/home-desktop
      ../system/configuration.nix
      ../system/bootloader/grub.nix
      ../system/video/nvidia.nix
      inputs.nix-ld.nixosModules.nix-ld
    ];
  };

  work-thinkpad = nixosSystem {
    inherit lib pkgs system;
    specialArgs = { inherit inputs; };
    modules = [
      alienModule
      alejandraModule
      ../system/machine/work-thinkpad
      ../system/configuration.nix
      ../system/bootloader/systemd.nix
      ../system/encryption/work.nix
      ../system/video/intel.nix
    ];
  };
}
