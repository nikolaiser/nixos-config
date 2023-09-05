{
  lib,
  pkgs,
  ...
}: {
  programs.neovim-ide = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
      };
    };
  };
}
