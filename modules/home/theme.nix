{
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.theme = {
    wallpaper = mkOption {
      type = types.path;
      default = lib.relativePath "local/137242.png";
      description = ''
        Path to the wallpaper file.

        This image is used as the desktop background across all outputs.
      '';
    };

    colors = {
      active = {
        background = mkOption {
          type = types.str;
          default = "1c1c1c";
          description = ''
            Background color for focused elements.

            This color is applied to bars and borders of active windows.
          '';
        };

        foreground = mkOption {
          type = types.str;
          default = "dedede";
          description = ''
            Foreground color for focused elements.

            This color is applied to text of active windows.
          '';
        };
      };

      inactive = {
        background = mkOption {
          type = types.str;
          default = "232323";
          description = ''
            Background color for unfocused elements.

            This color is applied to bars and borders of inactive windows.
          '';
        };

        foreground = mkOption {
          type = types.str;
          default = "666666";
          description = ''
            Foreground color for unfocused elements.

            This color is applied to text of inactive windows.
          '';
        };
      };

      palette = {
        regular = {
          black = mkOption {
            type = types.str;
            default = "242424";
            description = ''
              Color for regular black.

              This color is applied to ANSI color 0.
            '';
          };

          red = mkOption {
            type = types.str;
            default = "f62b5a";
            description = ''
              Color for regular red.

              This color is applied to ANSI color 1.
            '';
          };

          green = mkOption {
            type = types.str;
            default = "47b413";
            description = ''
              Color for regular green.

              This color is applied to ANSI color 2.
            '';
          };

          yellow = mkOption {
            type = types.str;
            default = "e3c401";
            description = ''
              Color for regular yellow.

              This color is applied to ANSI color 3.
            '';
          };

          blue = mkOption {
            type = types.str;
            default = "24acd4";
            description = ''
              Color for regular blue.

              This color is applied to ANSI color 4.
            '';
          };

          magenta = mkOption {
            type = types.str;
            default = "f2affd";
            description = ''
              Color for regular magenta.

              This color is applied to ANSI color 5.
            '';
          };

          cyan = mkOption {
            type = types.str;
            default = "13c299";
            description = ''
              Color for regular cyan.

              This color is applied to ANSI color 6.
            '';
          };

          white = mkOption {
            type = types.str;
            default = "e6e6e6";
            description = ''
              Color for regular white.

              This color is applied to ANSI color 7.
            '';
          };
        };

        bright = {
          black = mkOption {
            type = types.str;
            default = "616161";
            description = ''
              Color for bright black.

              This color is applied to ANSI color 8.
            '';
          };

          red = mkOption {
            type = types.str;
            default = "ff4d51";
            description = ''
              Color for bright red.

              This color is applied to ANSI color 9.
            '';
          };

          green = mkOption {
            type = types.str;
            default = "35d450";
            description = ''
              Color for bright green.

              This color is applied to ANSI color 10.
            '';
          };

          yellow = mkOption {
            type = types.str;
            default = "e9e836";
            description = ''
              Color for bright yellow.

              This color is applied to ANSI color 11.
            '';
          };

          blue = mkOption {
            type = types.str;
            default = "5dc5f8";
            description = ''
              Color for bright blue.

              This color is applied to ANSI color 12.
            '';
          };

          magenta = mkOption {
            type = types.str;
            default = "feabf2";
            description = ''
              Color for bright magenta.

              This color is applied to ANSI color 13.
            '';
          };

          cyan = mkOption {
            type = types.str;
            default = "24dfc4";
            description = ''
              Color for bright cyan.

              This color is applied to ANSI color 14.
            '';
          };

          white = mkOption {
            type = types.str;
            default = "ffffff";
            description = ''
              Color for bright white.

              This color is applied to ANSI color 15.
            '';
          };
        };
      };
    };
  };
}
