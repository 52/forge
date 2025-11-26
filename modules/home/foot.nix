{
  lib,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (osConfig) wayland;
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
    font=monospace:size=14:weight=Light

    # Set the font size adjustment.
    font-size-adjustment=2px

    # Set the window padding.
    pad=12x12

    # Set the clipboard target.
    selection-target=both

    [key-bindings]
    # Unbind specified keys by assigning them to noop.
    # This prevents the terminal from interpreting the key
    # and sending problematic codes to applications (e.g. vim).
    noop=Print
  '';
}
