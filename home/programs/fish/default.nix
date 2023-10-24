{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if status is-interactive
      and not set -q TMUX
        exec tmux new-session -A -s main
      end
    '';

    plugins = [
    ];


    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      la = "ls -la";
      tree = "${pkgs.eza}/bin/eza -T";
      htop = "${pkgs.bottom}/bin/btm";
      cat = "bat";
      nano = "micro";
      #ga = "git add";
      #gc = "git commit";
      #gco = "git checkout";
      #gp = "git push";
      #ps = "${pkgs.procs}/bin/procs";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
