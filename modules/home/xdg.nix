{
  lib,
  config,
  ...
}:
let
  inherit (lib) mapAttrs mkMerge;
  inherit (config) home;

  # User directory paths.
  # See: https://www.freedesktop.org/wiki/Software/xdg-user-dirs
  paths = {
    # Set the "XDG_DESKTOP_DIR" directory.
    # See: https://wiki.archlinux.org/title/XDG_user_directories
    desktop = "Desktop";
    # Set the "XDG_DOWNLOAD_DIR" directory.
    # See: https://wiki.archlinux.org/title/XDG_user_directories
    download = "Downloads";
    # Set the "XDG_DOCUMENTS_DIR" directory.
    # See: https://wiki.archlinux.org/title/XDG_user_directories
    documents = "Documents";
    # Set the "XDG_PICTURES_DIR" directory.
    # See: https://wiki.archlinux.org/title/XDG_user_directories
    pictures = "Media/Images";
    # Set the "XDG_VIDEOS_DIR" directory.
    # See: https://wiki.archlinux.org/title/XDG_user_directories
    videos = "Media/Video";
    # Set the "XDG_MUSIC_DIR" directory.
    # See: https://wiki.archlinux.org/title/XDG_user_directories
    music = "Media/Audio";
  };
in
{
  # Enable "XDG".
  # See: https://specifications.freedesktop.org/basedir-spec/latest
  xdg = {
    enable = true;
    userDirs = mkMerge [
      {
        enable = true;

        # Automatically create the XDG user directories.
        createDirectories = true;

        extraConfig = {
          # Disable the "XDG_PUBLICSHARE_DIR" directory.
          XDG_PUBLICSHARE_DIR = "/var/empty";
          # Disable the "XDG_TEMPLATES_DIR" directory.
          XDG_TEMPLATES_DIR = "/var/empty";
        };
      }

      # Map the user directories to absolute paths.
      (mapAttrs (_: path: "${home.homeDirectory}/${path}") paths)
    ];
  };

  # Force programs to adhere to the "XDG" specification.
  home.preferXdgDirectories = true;
}
