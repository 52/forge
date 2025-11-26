{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (osConfig) wayland keyboard;
  inherit (config) theme env;
in
mkIf wayland.enable {
  # Install local dependencies.
  home.packages = builtins.attrValues {
    inherit (pkgs)
      spotify
      vesktop
      ;
  };

  # <todo>
  # <todo>
  wayland.windowManager.hyprland = {
    enable = true;

    # <todo>
    # <todo>
    package = null;

    # <todo>
    # <todo>
    systemd.enable = false;

    settings = {
      # <todo>
      # <todo>
      "$mod" = "SUPER";

      input = {
        # <todo>
        kb_layout = keyboard.layout;

        # <todo>
        kb_variant = keyboard.variant;

        # <todo>
        repeat_delay = 150;
        repeat_rate = 100;
      };

      bind = [
        # <todo>
        # <todo>
        "$mod, T, exec, uwsm app -- ${env.TERMINAL or "foot"}"

        # <todo>
        # <todo>
        "$mod, F, exec, uwsm app -- ${env.BROWSER or "firefox"}"
      ];
    };
  };
}
