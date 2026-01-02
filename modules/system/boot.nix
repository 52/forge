_: {
  # Enable "systemd-boot".
  # See: https://wiki.archlinux.org/title/Systemd-boot
  boot.loader = {
    systemd-boot = {
      enable = true;

      # Limit the number of menu entries to 10 items.
      configurationLimit = 10;
    };

    # Set the menu timeout to 3 seconds.
    timeout = 3;

    # Allow the modification of EFI variables.
    efi.canTouchEfiVariables = true;
  };
}
