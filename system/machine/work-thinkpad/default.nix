{ config
, pkgs
, ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../autorandr/work-thinkpad.nix
  ];

  #networking.wireless.enable = true;
  #networking.wireless.userControlled.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = [ pkgs.networkmanager-fortisslvpn ];
  networking.hostName = "ri-t-0929";
  services.pppd = {
    enable = true;
  };
  services.pptpd.extraPppdOptions = ''
    ipcp-accept-local
    ipcp-accept-remote
  '';

}
