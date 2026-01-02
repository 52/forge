{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.vim;
in
{
  options.vim = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the "vim" module.

        This configures vim with sensible defaults.
      '';
    };
  };

  config = mkIf cfg.enable {
    # Set the default editor.
    env.EDITOR = "vim";

    # Enable "vim".
    # See: https://www.vim.org
    home.packages = builtins.attrValues {
      inherit (pkgs)
        vix
        ;
    };
  };
}
