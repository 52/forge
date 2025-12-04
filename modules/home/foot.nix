{
  lib,
  config,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (osConfig) wayland;
  inherit (config) theme;
in
mkIf wayland.enable {
  # Set the default terminal.
  env.TERMINAL = "foot";

  # Enable "foot".
  # See: https://codeberg.org/dnkl/foot
  programs.foot.enable = true;

  # Manage the configuration file directly.
  # See: https://man.archlinux.org/man/foot.ini.5.en
  xdg.configFile."foot/foot.ini".text = ''
    [main]
    # Set the terminal font.
    ${lib.concatMapStringsSep "\n" (var: "font${var}=pixel:pixelsize=20") [
      ""
      "-bold"
      "-bold-italic"
      "-italic"
    ]}

    # Set the font size adjustment.
    font-size-adjustment=1px

    # Set the window padding.
    pad=15x10 center

    # Set the clipboard target.
    selection-target=both

    [colors]
    # Set the background color.
    background=${theme.colors.active.background}

    # Set the foreground color.
    foreground=${theme.colors.active.foreground}

    # Set the regular colors.
    regular0=${theme.colors.palette.regular.black}
    regular1=${theme.colors.palette.regular.red}
    regular2=${theme.colors.palette.regular.green}
    regular3=${theme.colors.palette.regular.yellow}
    regular4=${theme.colors.palette.regular.blue}
    regular5=${theme.colors.palette.regular.magenta}
    regular6=${theme.colors.palette.regular.cyan}
    regular7=${theme.colors.palette.regular.white}

    # Set the bright colors.
    bright0=${theme.colors.palette.bright.black}
    bright1=${theme.colors.palette.bright.red}
    bright2=${theme.colors.palette.bright.green}
    bright3=${theme.colors.palette.bright.yellow}
    bright4=${theme.colors.palette.bright.blue}
    bright5=${theme.colors.palette.bright.magenta}
    bright6=${theme.colors.palette.bright.cyan}
    bright7=${theme.colors.palette.bright.white}

    [key-bindings]
    # Unbind specified keys by assigning them to noop.
    # This prevents the terminal from interpreting the key
    # and sending problematic codes to applications (e.g. vim).
    noop=Print
  '';
}
