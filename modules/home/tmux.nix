{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
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
    programs.tmux = {
      enable = true;

      # Manage the configuration file directly.
      # See: https://github.com/tmux/tmux/wiki/Getting-Started#configuring-tmux
      extraConfig = ''
        # Terminal overrides for true color support.
        set -ag terminal-overrides ",xterm-256color:RGB"
        set -g default-terminal "tmux-256color"

        # Fix the <ESC> delay in vim.
        set -sg escape-time 0

        # Set the history limit.
        set -g history-limit 50000

        # Enable mouse scroll.
        set -g mouse on
      '';
    };
  };
}
