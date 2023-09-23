# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ config
, pkgs
, ...
}: {
  imports = [
    ./wm/xmonad.nix
  ];


  time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/Berlin";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;

  users.users.nikolaiser = {
    isNormalUser = true;
    home = "/home/nikolaiser";
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      git
      tree
    ];
    shell = pkgs.zsh;
  };


  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  environment.systemPackages = with pkgs; [
    rustc
    cargo
  ];

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
