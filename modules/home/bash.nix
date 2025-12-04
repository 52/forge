{
  config,
  ...
}:
{
  # Set the default shell.
  env.SHELL = "bash";

  # Enable "bash".
  # See: https://www.gnu.org/software/bash
  programs.bash = {
    enable = true;

    # Limit the history size to n-lines.
    historySize = 500000;

    # Limit the on disk history file to n-lines.
    historyFileSize = 100000;

    # Remove the ".bash_history" file from $HOME.
    historyFile = "${config.xdg.dataHome}/bash/bash_history";

    historyControl = [
      # Ignore duplicate entries in history.
      "ignoredups"

      # Remove duplicate entries from history.
      "erasedups"
    ];

    shellOptions = [
      # Enable recursive pattern matching with "**".
      "globstar 2> /dev/null"

      # Enable case-insensitive filename matching.
      "nocaseglob"

      # Append new lines to the history file.
      "histappend"

      # Check the window size after each command.
      "checkwinsize"

      # Save multi-line commands as a single history entry.
      "cmdhist"

      # Automatically prepend "cd" to directory names.
      "autocd 2> /dev/null"

      # Automatically correct spelling errors in "cd".
      "cdspell 2> /dev/null"

      # Automatically correct spelling errors in completion.
      "dirspell 2> /dev/null"
    ];

    shellAliases = {
      ".." = "cd ..";

      df = "df -h";
      du = "du -h -c";

      ls = "ls -lF -G --group-directories-first --color=auto";
      la = "ls -lAF -G --group-directories-first --color=auto";

      g = "git";
      ga = "git add";
      gp = "git push";
      gd = "git diff";
      gc = "git commit";
      gs = "git status";
      gb = "git branch";
      gl = "git log --decorate --oneline --graph";

      n = "nix";
      nd = "nix develop";

      v = "vim";
      vi = "vim";

      t = "tmux";
      tl = "tmux ls";
      td = "tmux detach";
      ta = "tmux attach -t";
      tk = "tmux kill-session -t";
    };

    initExtra = ''
      ## Enable "bash-sensible".
      ## See: https://github.com/mrzool/bash-sensible

      # Enable case-insensitive completion.
      bind "set completion-ignore-case on"

      # Treat hyphens and underscores as equivalent.
      bind "set completion-map-case on"

      # Display all matches immediately.
      bind "set show-all-if-ambiguous on"

      # Append slashes to symlinked directories.
      bind "set mark-symlinked-directories on"

      # Move the cursor to EOL when cycling through history.
      bind "set history-preserve-point off"

      # Enable cycling through tab completion options.
      bind 'tab: menu-complete'
      bind '"\e[Z": menu-complete-backward'

      # Enable incremental history search with arrow keys.
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\e[C": forward-char'
      bind '"\e[D": backward-char'

      ## Load the "__git_ps1" command.
      . $HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh

      ## Load the custom prompt.
      PS1='\n\[\e[32m\]\w''$(__git_ps1 "\[\e[31m\] [%s]")\[\e[36m\]''${IN_NIX_SHELL:+ *}\[\e[0m\] '
    '';
  };
}
