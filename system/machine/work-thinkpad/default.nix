{ config
, pkgs
, ...
}:
let
  hostname = "ri-t-0929";
in
{
  imports = [
    ./hardware-configuration.nix
    #../../autorandr/work-thinkpad.nix
  ];

  #networking.wireless.enable = true;
  #networking.wireless.userControlled.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = [ pkgs.networkmanager-fortisslvpn ];
  networking.hostName = hostname;
  networking.hosts = {
    "127.0.0.2" = pkgs.lib.mkForce [ ];
  };
  networking.extraHosts = ''
    127.0.0.1 ${hostname}
  '';

  services.pppd = {
    enable = true;
  };
  services.pptpd.extraPppdOptions = ''
    ipcp-accept-local
    ipcp-accept-remote
  '';

}
