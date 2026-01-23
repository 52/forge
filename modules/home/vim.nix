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

  ## Vim configuration.
  ##
  #@ Derivation
  conf = pkgs.fetchFromGitHub {
    owner = "52";
    repo = "vim";
    rev = "e5c74ae1d19d83060412b1a025c90d06db6c341f";
    hash = "sha256-rgQYGANWZkFMsfBcDvHq6D0iXXLvSnYQx5Npw4cs22o=";
    fetchSubmodules = true;
  };

  ## Vim package.
  ##
  #@ Package
  package = pkgs.vim-full.overrideAttrs (_: {
    inherit version src;
  });

  ## Vim derivation.
  ##
  #@ Package
  vim = package.customize {
    vimrcConfig.customRC = ''
      set runtimepath=${conf},$VIMRUNTIME,${conf}/after
      set packpath=${conf},$VIMRUNTIME,${conf}/after
    '';
  };
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
