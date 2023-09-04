# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, inputs, ... }:

{

  imports = [
    ./wm/xmonad.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.gfxmodeEfi = "1280x1024x32,auto";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  time.hardwareClockInLocalTime = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.zsh.enable = true;

  users.users.nikolaiser = {
     isNormalUser = true;
     home = "/home/nikolaiser";
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       firefox
       tree
       git
    ];
    shell = pkgs.zsh;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;

    open= false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

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

  system.stateVersion = "23.11"; # Did you read the comment?

}

