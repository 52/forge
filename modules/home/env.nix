{
  lib,
  config,
  osConfig,
  ...
}:
let
  inherit (lib) concatStrings mapAttrsToList mkIf mkMerge mkOption types;
  inherit (osConfig) wayland;
  cfg = config.env;
in
{
  options.env = mkOption {
    type =
      with types;
      attrsOf (oneOf [
        str
        path
        int
        float
      ]);
    default = { };
    description = ''
      Set of environment variables.

      These variables will be available in the user's shell
      session and exported to "UWSM" when Wayland is enabled.
    '';
  };

  config = mkIf (cfg != { }) (mkMerge [
    # Set the session variables.
    { home.sessionVariables = cfg; }

    # Create the "uwsm/env" file when Wayland is enabled.
    (mkIf wayland.enable {
      xdg.configFile."uwsm/env".text = concatStrings (
        mapAttrsToList (name: value: ''
          export ${name}="${toString value}"
        '') cfg
      );
    })
  ]);
}
