{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.vim;

  ## Vim version.
  ##
  #@ String
  version = "9.1.2050";

  ## Vim source.
  ##
  #@ Derivation
  src = pkgs.fetchFromGitHub {
    owner = "vim";
    repo = "vim";
    rev = "v${version}";
    hash = "sha256-d/fiDTvC1pAIvzs8kdO4tC7gQJz13feLPXFiUxXdoG0=";
  };

  ## Vim package.
  ##
  #@ Package
  vim = pkgs.vim-full.overrideAttrs (_: {
    inherit version src;
  });
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
      inherit vim;
    };
  };
}
