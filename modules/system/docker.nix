{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.docker;
in
{
  options.docker = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the "docker" module.

        This enables Docker containers and sets sane
        default configurations.
      '';
    };

    members = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        List of users to add to the "docker" group.

        These users will have permissions to manage Docker
        containers without requiring root privileges.
      '';
    };
  };

  config = mkIf cfg.enable {
    # Install system-wide dependencies.
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        kubectl
        ;
    };

    # Enable "Docker".
    # See: https://docs.docker.com
    virtualisation.docker = {
      enable = true;

      # Enable the periodic pruning of resources.
      autoPrune.enable = true;
    };

    # Manage the "docker" group.
    users.groups.docker = {
      inherit (cfg) members;
    };
  };
}
