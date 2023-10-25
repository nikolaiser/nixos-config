{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      dracula
      yank
    ];

    extraConfig = ''
      set -g prefix C-a

      # act like vim
      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind-key C-x display-popup -E "tms"

      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      set-option -g history-limit 50000

      set -g allow-passthrough on

      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -g @dracula-plugins "battery time"
      set -g @dracula-show-powerline true
      set -g @dracula-show-flags true
      set -g @dracula-show-location false
      set -g @dracula-show-fahrenheit false
      set -g @dracula-show-left-icon session
      set -g status-position top
      run-shell ${pkgs.tmuxPlugins.dracula}/share/tmux-plugins/dracula/dracula.tmux
    '';
  };
}
