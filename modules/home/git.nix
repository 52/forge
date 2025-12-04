{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkOption mkIf types;
  inherit (config) env;
  cfg = config.git;
in
{
  options.git = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the "git" module.

        This configures Git with sensible defaults.
      '';
    };

    name = mkOption {
      type = types.str;
      default = throw "Must provide a non-empty string";
      description = ''
        The user name used in commits.

        Ths will be shown as the author name in commit history.
      '';
    };

    email = mkOption {
      type = types.str;
      default = throw "Must provide a non-empty string";
      description = ''
        The user email used in commits.

        Ths will be shown as the author email in commit history.
      '';
    };
  };

  config = mkIf cfg.enable {
    # Enable "git".
    # See: https://git-scm.com
    programs.git = {
      enable = true;

      settings = {
        user = {
          inherit (cfg) name email;
        };

        core = {
          # Set the default editor.
          editor = env.EDITOR;

          # Monitor the file-system for changes.
          fsmonitor = true;

          # Enable caching of untracked files.
          untrackedCache = true;
        };

        push = {
          # Push only the current branch.
          default = "simple";

          # Automatically create remote branches.
          autoSetupRemote = true;

          # Automatically push annotated tags.
          followTags = true;
        };

        rebase = {
          # Automatically squash commits.
          autoSquash = true;

          # Automatically stash changes.
          autoStash = true;

          # Automatically update dependent branches.
          updateRefs = true;
        };

        diff = {
          # Use the histogram diff algorithm.
          algorithm = "histogram";

          # Highlight moved lines in different colors.
          colorMoved = "plain";

          # Use descriptive prefixes.
          mnemonicPrefix = true;

          # Detect and display renamed files.
          renames = true;
        };

        commit = {
          # Clean up commit messages at the scissors markers.
          cleanup = "scissors";

          # Display the full diff in the commit message editor.
          verbose = true;
        };

        # Set the default branch name.
        init.defaultBranch = "master";

        # Sort branches by the most recent commit.
        branch.sort = "-committerdate";

        # Sort tags by the version and name.
        tag.sort = "version:refname";

        # Enable columized output.
        column.ui = "auto";

        # Enable colored output.
        color.ui = "auto";

        # Enable autocorrect for mistyped commands.
        help.autocorrect = 1;
      };
    };
  };
}
