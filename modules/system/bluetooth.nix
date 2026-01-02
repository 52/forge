_: {
  # Enable "BlueZ".
  # See: https://www.bluez.org
  hardware.bluetooth = {
    enable = true;

    # Automatically start bluetooth at boot.
    powerOnBoot = true;

    settings.General = {
      # Enable D-Bus experimental interfaces.
      Experimental = true;

      # Enable faster advertising intervals.
      FastConnectable = true;
    };
  };
}
