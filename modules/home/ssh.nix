{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkOption mkIf types;
  inherit (config) git;
  cfg = config.ssh;
in
{
  options.ssh = {
    enableGitIntegration = mkOption {
      type = types.bool;
      default = git.enable or false;
      description = ''
        Whether to enable the SSH integration for Git.

        This configures match blocks and URL rewrites for
        popular platforms like "GitHub" and "GitLab".
      '';
    };

    enableGitSigning = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable SSH-based commit signing.

        This enables the use of SSH keys for signing commits
        instead of "GPG" (GNU Privacy Guard).
      '';
    };
  };

  config = lib.mkMerge [
    {
      # Enable "SSH".
      # See: https://www.openssh.com
      programs.ssh = {
        enable = true;

        # Disable the default values.
        enableDefaultConfig = false;

        # Configure the default match block.
        matchBlocks."*" = {
          # Automatically add keys to the "ssh-agent".
          addKeysToAgent = "yes";

          # Set the preferred cryptographic algorithms.
          extraOptions = {
            HostKeyAlgorithms = "ssh-ed25519,ssh-ed25519-cert-v01@openssh.com";
            PubkeyAcceptedAlgorithms = "ssh-ed25519,ssh-ed25519-cert-v01@openssh.com";
          };
        };
      };

      # Enable "ssh-agent".
      # See: https://en.wikipedia.org/wiki/ssh-agent
      services.ssh-agent.enable = true;

      # Fix: Ordering for managed compositors (e.g. UWSM) compatibility.
      # See: https://github.com/Vladimir-csp/uwsm/issues/75
      systemd.user.services."ssh-agent" = {
        # Force "ssh-agent" to run before "graphical-session".
        Unit.Before = [ "graphical-session-pre.target" ];

        Service = {
          # Export "SSH_AUTH_SOCK" to the user environment after "ssh-agent" starts.
          # This ensures that all services can access the socket.
          ExecStartPost = "systemctl --user set-environment \"SSH_AUTH_SOCK=%t/ssh-agent\"";

          # Afterwards, we unset "SSH_AUTH_SOCK" when "ssh-agent" stops.
          # This prevents any stale socket references.
          ExecStopPost = "systemctl --user unset-environment SSH_AUTH_SOCK";
        };
      };
    }

    (mkIf cfg.enableGitIntegration {
      # Set the "git" match block.
      programs.ssh.matchBlocks."git" = {
        # Set the user for authentication.
        user = "git";

        # Match only on "GitHub" and "GitLab" hosts.
        host = "github.com gitlab.com";

        # Set the identity file (Private Key).
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";

        # Only use the specified identity.
        identitiesOnly = true;
      };

      # Force rewrite "HTTPS" to "SSH".
      programs.git.settings.url = {
        "ssh://git@github.com".insteadOf = "https://github.com";
        "ssh://git@gitlab.com".insteadOf = "https://gitlab.com";
      };

      # Pre-populate the "known_hosts" file.
      home.file.".ssh/known_hosts".text = ''
        github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
        gitlab.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf
      '';
    })

    (mkIf cfg.enableGitSigning {
      programs.git = {
        signing = {
          # Enable signing by default.
          signByDefault = true;

          # Set the public key file.
          key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        };

        # Set the signing format to "SSH".
        settings.gpg.format = "ssh";
      };
    })
  ];
}
