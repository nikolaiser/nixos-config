{ config, lib, pkgs, ... }:

{ 
  programs.zsh = {
    enable = true;
    shellAliases = {
      la = "ls -la";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gp = "git push";
    };

   zplug = {
    enable = true;
    plugins = [
      { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
      {name = "zsh-users/zsh-syntax-highlighting"; }
      {name = "spaceship-prompt/spaceship-prompt"; }
      ];
    };  

    initExtra = ''if [ "$TMUX" = "" ]; then tmux new-session -A -s main; fi'';

  };
}
