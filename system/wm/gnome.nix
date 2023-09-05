{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.gnupg.agent.pinentryFlavor = "gnome3";

  services = {
    # Gnome 3 config
    dbus.packages = [pkgs.dconf];
    udev.packages = [pkgs.gnome3.gnome-settings-daemon];
    # GUI interface
    xserver = {
      enable = true;
      layout = "us";

      #enable touchpad support
      libinput.enable = true;

      # Enable the Gnome 3 desktop manager
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false;
      desktopManager.gnome.enable = true;
    };
  };
}
