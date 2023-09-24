{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../autorandr/work-thinkpad.nix
  ];

  #networking.wireless.enable = true;
  #networking.wireless.userControlled.enable = true;
  networking.networkmanager.enable = true;
}
