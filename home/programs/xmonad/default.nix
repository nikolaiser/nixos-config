{ pkgs, ... }:

let 
  extra = ''
  '';

  polybarOpts = ''
  '';
in 
{

  xresources.properties = {
    "Xft.dpi" = 102;
  };

  home.packages = with pkgs; [
    dialog                 # Dialog boxes on the terminal (to show key bindings)
    networkmanager_dmenu   # networkmanager on dmenu
    networkmanagerapplet   # networkmanager applet
    xorg.xrandr            # display manager (X Resize and Rotate protocol)
    xorg.xmessage
    xorg.xorgserver
    dmenu
    gmrun
    pavucontrol
  ];

  xsession = {
    enable = true;

    initExtra = extra + polybarOpts;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
      ];
      config = ./config.hs;
    };
  };

}
