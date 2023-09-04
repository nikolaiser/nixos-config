{ config, lib, pkgs, ... }:

{ 
  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -la";
    };

   zplug = {
    enable = true;
    plugins = [
      { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      {name = "zsh-users/zsh-syntax-highlighting"; }
      {name = "spaceship-prompt/spaceship-prompt"; }
      ];
    };  

    initExtra = ''if [ "$TMUX" = "" ]; then tmux; fi'';

  };
}
