{ pkgs, ... }:
let
  username = "nikolaiser";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";


  ghcWithPkgs = (pkgs.haskellPackages.ghcWithPackages (hpkgs: [
    hpkgs.xmobar
    hpkgs.xmonad
    hpkgs.xmonad-contrib
  ]));

  defaultPkgs = with pkgs; [
    arandr
    bat # cat alternative
    bottom # alternative to htop
    docker-compose
    eza # better ls
    fd
    fzf
    ghcWithPkgs
    gnome.nautilus
    micro # nano alternative
    nerdfonts
    nix-init
    ripgrep
    telegram-desktop
    wezterm
    xclip
    jq
    tldr
    procs
    yazi
    scala_3
    scala-cli
  ];
in
{
  programs.home-manager.enable = true;

  imports = builtins.concatMap import [
    ./programs
    ./modules
    ./services
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

  services.mpris-proxy.enable = true;
}
