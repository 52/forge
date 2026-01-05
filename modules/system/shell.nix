{
  pkgs,
  ...
}:
{
  # Install system-wide dependencies.
  # See: https://wiki.nixos.org/wiki/Command_Shell
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      nixfmt-rfc-style
      deadnix
      statix
      nixd

      ripgrep
      unzip
      fd
      jq
      ;
  };
}
