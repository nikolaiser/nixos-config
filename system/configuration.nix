# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{ config
, pkgs
, inputs
, ...
}: {
  imports = [
    ./wm/hyprland.nix
  ];

  time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/Berlin";

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  programs.fish.enable = true;

  users.users.nikolaiser = {
    isNormalUser = true;
    home = "/home/nikolaiser";
    extraGroups = [ "wheel" "docker" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      git
      tree
    ];
    shell = pkgs.fish;
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
    git
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  programs.nix-ld.enable = true;
}
