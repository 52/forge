_: {
  services.openssh = {
    enable = true;
    ports = [ 15555 ];
  };

  programs.ssh = {
    startAgent = true;

    hostKeyAlgorithms = [
      "ssh-ed25519"
      "ssh-ed25519-cert-v01@openssh.com"
    ];

    pubkeyAcceptedKeyTypes = [
      "ssh-ed25519"
      "ssh-ed25519-cert-v01@openssh.com"
    ];

    extraConfig = ''
      AddKeysToAgent yes
    '';

    knownHosts = {
      "github.com".publicKey =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

      "github.com/rsa" = {
        hostNames = [ "github.com" ];
        publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt";
      };

      "github.com/ecdsa" = {
        hostNames = [ "github.com" ];
        publicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=";
      };
    };
  };
}
