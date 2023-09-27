{ inputs, pkgs, ... }:
let
  username = "nikolaiser";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  ghcWithPkgs = pkgs.haskellPackages.ghcWithPackages (hpkgs: [
    hpkgs.xmobar
    hpkgs.xmonad
    hpkgs.xmonad-contrib
  ]);

  defaultPkgs = with pkgs; [
    arandr
    bat # cat alternative
    bottom # alternative to htop
    docker-compose
    discord
    eza # better ls
    fd
    flameshot
    fzf
    ghcWithPkgs
    gnome.nautilus
    jq
    manix
    micro # nano alternative
    nerdfonts
    nix-init
    procs
    ripgrep
    sbt
    scala-cli
    scala_3
    slack
    telegram-desktop
    tldr
    wezterm
    xclip
    yazi
    qpdfview
    qimgv
    rustfmt
    gcc
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
    mimeApps = {
      enable = true;
      defaultApplications = {
        pdf = "qpdfview";
        jpg = "qimgv";
        png = "qimgv";
      };
    };
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
