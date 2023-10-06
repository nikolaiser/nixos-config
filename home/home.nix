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

  pinnedForti = pkgs.openfortivpn.overrideAttrs (
    old: {
      src = builtins.fetchTarball {
        url = "https://github.com/adrienverge/openfortivpn/archive/refs/tags/v1.20.4.tar.gz";
        sha256 = "1dzw16ndvghkkhq8z5w6vyxblrjkmns0mfh8r6z8q4r95dal59i4";
      };
    }
  );

  defaultPkgs = with pkgs;
    [
      arandr
      bat # cat alternative
      bottom # alternative to htop
      chromium
      discord
      docker-compose
      eza # better ls
      fd
      flameshot
      fzf
      gcc
      ghcWithPkgs
      gnome.nautilus
      helm
      jq
      kubectl
      kubectx
      manix
      micro # nano alternative
      minikube
      nerdfonts
      nix-init
      pinnedForti
      procs
      qimgv
      qpdfview
      ripgrep
      rustfmt
      scala-cli
      scala_3
      slack
      sops
      telegram-desktop
      tldr
      wezterm
      xclip
      yazi
      (sbt.override { jre = jdk17; })
      dig
      util-linux
      mongosh
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
