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
  # Enable "NetworkManager".
  # See: https://github.com/NetworkManager/NetworkManager
  networking.networkmanager.enable = true;

  # Enable "Avahi".
  # See: https://avahi.org
  services.avahi = {
    enable = true;

    # Enable the mDNS NSS plugin for IPv4.
    # See: https://github.com/avahi/nss-mdns
    nssmdns4 = true;

    # Enable local service publishing.
    publish = {
      enable = true;

      # Announce the locally used domain name.
      domain = true;

      # Publish local user services.
      userServices = true;
    };
  };

  # Manage the "networkmanager" group.
  users.groups.networkmanager = {
    members = builtins.attrNames (filterAttrs (_: user: user.isNormalUser or false) users.extraUsers);
  };
}
