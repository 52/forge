{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
  inherit (config) theme;
  cfg = config.tmux;
in
{
  options.tmux = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the "tmux" module.

        This configures tmux with sensible defaults.
      '';
    };
  };

  config = mkIf cfg.enable {
    # Enable "tmux".
    # See: https://github.com/tmux/tmux/wiki
    home.packages = builtins.attrValues {
      inherit (pkgs) tmux;
    };

    # Manage the configuration file directly.
    # See: https://github.com/tmux/tmux/wiki/Getting-Started#configuring-tmux
    xdg.configFile."tmux/tmux.conf".text = ''
      set -g default-terminal "tmux-256color"

      set -ag terminal-overrides ",$TERM:Tc"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      set -g mouse on
      set -g focus-events on
      set -g history-limit 10000

      # Set the escape sequence delay.
      # Note: Lower values reduce the ESC delay in vim.
      set -sg escape-time 10

      # Start window and pane indices at 1.
      set -g base-index 1
      setw -g pane-base-index 1
      setw -g renumber-windows on

      unbind C-b
      set -g prefix C-,
      bind C-, send-prefix

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind x kill-window
      bind n next-window
      bind p previous-window
      bind c new-window -c "#{pane_current_path}"
      bind r command-prompt "rename-window '%%'"

      bind -r H resize-pane -L 15
      bind -r J resize-pane -D 15
      bind -r K resize-pane -U 15
      bind -r L resize-pane -R 15

      bind s split-window -h -c "#{pane_current_path}"
      bind v split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      set -g pane-border-indicators off
      set -g pane-border-style "fg=#${theme.colors.palette.regular.black}"
      set -g pane-active-border-style "fg=#${theme.colors.palette.bright.black}"
    '';
  };
}
