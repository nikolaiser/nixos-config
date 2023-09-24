{pkgs, ...}: let
  aorus43 = "00ffffffffffff001c540043010101012e1f0104c5462778fbc6a5b14d38b626115054254a00d1c081809500b30001010101010101014dd000a0f0703e8030203500b9882100001e000000fd0c30903b3b89010a202020202020000000fc00414f5255532046563433550a20000000ff003231343630423030323036320a02c6020333714d020311121304292f20103f615d23090707830100006d1a0000020b3090000f8c158015e305c301e6060d018c8012f65b006ea0a01f5017201804b9882100001ef5bd0064a0a055501220f80cb9882100001e967f8078703821401c203804b9882100001e000000000000000000000000000000000000000000002b701279030003013c5fe80004ff0977001b801f009f0566000880070060e90104ff0e770007801f006f08240004800700ceac0104ff0e9f002f801f006f087e0002800400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000390";
  thinkpadBuiltin = "00ffffffffffff0006af91d200000000161e0104a51e1378035f55a755499d220d4f5500000001010101010101010101010101010101fa3c80b870b0244010103e002dbc10000018000000fd00303c4b4b10010a202020202020000000fe0041554f0a202020202020202020000000fe004231343055414e30322e31200a00ff";
  notify = "${pkgs.libnotify}/bin/notify-send";
in {
  services.autorandr = {
    enable = true;

    hooks = {
      predetect = {};

      preswitch = {};

      postswitch = {};
    };

    profiles = {
      "away" = {
        fingerprint = {
          eDP-1 = thinkpadBuiltin;
        };

        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "1920x1200";
            rate = "60.03";
            rotate = "normal";
          };
        };
      };

      "home1" = {
        fingerprint = {
          DP-1 = aorus43;
          eDP-1 = thinkpadBuiltin;
        };

        config = {
          DP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2160";
            rate = "120.00";
            rotate = "normal";
          };
          eDP-1 = {
            enable = true;
            crtc = 1;
            position = "3840x1538";
            mode = "1920x1200";
            rate = "60.03";
            rotate = "normal";
          };
        };
      };

      "home2" = {
        fingerprint = {
          DP-3 = aorus43;
          eDP-1 = thinkpadBuiltin;
        };

        config = {
          DP-3 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2160";
            rate = "120.00";
            rotate = "normal";
          };
          eDP-1 = {
            enable = true;
            crtc = 1;
            position = "3840x1538";
            mode = "1920x1200";
            rate = "60.03";
            rotate = "normal";
          };
        };
      };
    };
  };
}
