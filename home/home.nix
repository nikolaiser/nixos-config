{ pkgs, ... }:

let 
  username = "nikolaiser";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    wezterm    
    nix-init
    telegram-desktop
    xclip
    nerdfonts
    gnome.nautilus
  ];

in {
  programs.home-manager.enable = true;
  
  imports = builtins.concatMap import [
    ./programs
    ./modules
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "23.11";

    packages = defaultPkgs;

    sessionVariables = {
      EDITOR = "nvim";
    };

    file."${configHome}/wezterm/wezterm.lua" = {
      source = ./programs/wezterm/wezterm.lua;
      recursive = true;
    };
  };

  fonts.fontconfig.enable = true;

  systemd.user.startServices = "sd-switch";

  news.display = "silent";
}
