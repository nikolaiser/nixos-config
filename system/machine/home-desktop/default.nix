{ config
, pkgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];


  networking.networkmanager.enable = true;
}
