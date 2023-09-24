{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      la = "ls -la";
      tree = "${pkgs.eza}/bin/eza -T";
      htop = "${pkgs.bottom}/bin/btm";
      cat = "bat";
      nano = "micro";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gp = "git push";
      ps = "${pkgs.procs}/bin/procs";
    };

    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    historySubstringSearch.enable = true;

    zplug = {
      enable = true;
      plugins = [
        {name = "spaceship-prompt/spaceship-prompt";}
      ];
    };

    initExtra = ''
      if [ "$TMUX" = "" ]; then tmux new-session -A -s main; fi
      SPACESHIP_PROMPT_ASYNC=false

      tmux-gc() {
        tmux ls | rg '^(\d+):.*' -r '$1' | xargs -n1 tmux kill-session -t
      }
    '';
  };
}
