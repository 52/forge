{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) filterAttrs;
  inherit (config) users;
in
{
  # Install system-wide dependencies.
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      bubblewrap

      ripgrep
      fd
      jq
      ;
  };

  boot.kernel.sysctl = {
    # Ignore ICMP redirects.
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    # Never send ICMP redirects.
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;

    # Reject source-routed packets.
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.default.accept_source_route" = 0;

    # Enable strict reverse-path filtering.
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
  };

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

    # Enable the mDNS NSS plugin for IPv6.
    # See: https://github.com/avahi/nss-mdns
    nssmdns6 = true;

    # Enable local service publishing.
    publish = {
      enable = true;

      # Announce the locally used domain name.
      domain = true;

      # Publish local user services.
      userServices = true;
    };
  };

  # Enable "Firejail".
  # See: https://github.com/netblue30/firejail
  programs.firejail.enable = true;

  # Manage the "networkmanager" group.
  users.groups.networkmanager = {
    members = builtins.attrNames (filterAttrs (_: user: user.isNormalUser or false) users.extraUsers);
  };
}
