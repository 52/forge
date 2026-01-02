{
  lib,
  config,
  ...
}:
let
  inherit (lib) filterAttrs;
  inherit (config) users;
in
{
  # Enable "PipeWire".
  # See: https://pipewire.org
  services.pipewire = {
    enable = true;

    # Enable "JACK" compatibility.
    # See: https://jackaudio.org
    jack.enable = true;

    # Enable "PulseAudio" compatibility.
    # See: https://wiki.archlinux.org/title/PulseAudio
    pulse.enable = true;

    # Enable "ALSA" compatibility.
    # See: https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture
    alsa = {
      enable = true;

      # Enable 32-bit "ALSA" support on 64-bit systems.
      support32Bit = true;
    };
  };

  # Remove the ".pulse-cookie" file from $HOME.
  services.pulseaudio.extraClientConf = "cookie-file = /tmp/pulse-cookie";

  # Enable real-time scheduling for better performance.
  # See: https://discourse.nixos.org/t/how-to-use-pipewire-instead-of-pulseaudio/22853/3
  security.rtkit.enable = true;

  # Manage the "audio" group.
  users.groups.audio = {
    members = builtins.attrNames (filterAttrs (_: user: user.isNormalUser or false) users.extraUsers);
  };
}
