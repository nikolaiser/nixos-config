{ pkgs, lib, ... }:

{
  imports = [ ];

  home.file.".config/hypr" = {
    source = ./hypr-conf;
    recursive = true;
  };


  home.packages = with pkgs; [
    grim
    slurp
    swappy
    xdg-utils
  ];

  systemd.user.sessionVariables = {
    "NIXOS_OZONE_WL" = "1"; # for any ozone-based browser & electron apps to run on wayland
    "MOZ_ENABLE_WAYLAND" = "1"; # for firefox to run on wayland
    "MOZ_WEBRENDER" = "1";

    # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
    "LIBVA_DRIVER_NAME" = "nvidia";
    "XDG_SESSION_TYPE" = "wayland";
    "GBM_BACKEND" = "nvidia-drm";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "WLR_EGL_NO_MODIFIRES" = "1";
  };

  systemd.user.targets.hyprland-session = {
    Unit = {
      Description = "hyprland compositor session";
      BindsTo = [ "graphical-session.target" ];
      Wants = [
        "graphical-session-pre.target"
        "xdg-desktop-autostart.target"
      ];
      After = [
        "graphical-session-pre.target"
      ];
      Before = [
        "xdg-desktop-autostart.target"
      ];
    };
  };


  programs.waybar = {
    enable = true;
    style = ./waybar/style.css;

    settings = {
      "bar" = {
        layer = "top";
        position = "top";
        exclusive = true;
        passthrough = false;
        mod = "dock";
        height = 30;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" "pulseaudio" "pulseaudio#microphone" ];
        modules-right = [ "network" "battery" "tray" "hyprland/language" ];




        "pulseaudio" = {
          "format" = "{icon} {volume}% {format_source}";
          "format-bluetooth" = "{icon} {volume}% {format_source}";
          "format-bluetooth-muted" = "   {volume}% {format_source}";
          "format-muted" = "  {format_source}";
          "format-source" = " ";
          "format-source-muted" = " ";
          "format-icons" = {
            "headphone" = " ";
            "hands-free" = " ";
            "headset" = " ";
            "phone" = " ";
            "portable" = " ";
            "car" = " ";
            "default" = [
              " "
              " "
              " "
            ];
          };
          "tooltip-format" = "{desc}, {volume}%";
        };

        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = "Mic: {volume}%";
          "format-source-muted" = "Mic: Muted";
          "scroll-step" = 5;
        };
      };
    };

    systemd.enable = true;
    systemd.target = "hyprland-session.target";

  };

}

