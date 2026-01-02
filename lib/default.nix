{
  lib,
  inputs,
  ...
}:
rec {
  ## Convert a path to a relative path from the flake root.
  ##
  ## ```nix
  ## relativePath "system/audio.nix"
  ## ```
  ##
  #@ String -> Path
  relativePath = lib.path.append ../.;

  ## Read the contents of a file from a path relative to the flake root.
  ##
  ## ```nix
  ## readFileRelative "bin/forge"
  ## ```
  ##
  #@ String -> String
  readFileRelative = path: builtins.readFile (relativePath path);

  ## Filter a list of filenames by extension.
  ##
  ## ```nix
  ## filterExt "rs" [ "main.rs" "rust-toolchain" ]
  ## ```
  ##
  #@ String -> [String] -> [String]
  filterExt = ext: files: builtins.filter (name: builtins.match ".*\\.${ext}" name != null) files;

  ## Import all ".nix" files from a directory.
  ##
  ## ```nix
  ## importAll "system"
  ## ```
  ##
  #@ String -> [Path]
  importAll =
    dir:
    map (name: relativePath dir + "/${name}") (
      filterExt "nix" (builtins.attrNames (builtins.readDir (relativePath dir)))
    );

  ## Create a user with a home-manager configuration.
  ##
  ## ```nix
  ## mkUser {
  ##   name = "max";
  ##   groups = [ "wheel" "docker" ];
  ##   packages = with pkgs; [ vim git ];
  ##   stateVersion = "24.11";
  ## }
  ## ```
  ##
  #@ AttrSet -> AttrSet
  mkUser =
    {
      ## Name of the system user account.
      ##
      #@ String
      name,

      ## Description of the system user account.
      ##
      #@ String
      description ? "",

      ## List of groups the user belongs to.
      ##
      #@ [String]
      extraGroups ? [ ],

      ## Whether this is a user account.
      ##
      #@ Bool
      isNormalUser ? true,

      ## List of packages to install for the user.
      ##
      #@ [Package]
      packages ? [ ],

      ## Set of secrets to provision for the user.
      ##
      #@ AttrSet
      secrets ? { },

      ## Home-manager modules configuration.
      ##
      #@ AttrSet
      home ? { },

      ## Home-manager state version.
      ## See: https://github.com/nix-community/home-manager/issues/5794
      ##
      #@ String
      stateVersion,
    }:
    {
      users.extraUsers.${name} = {
        inherit description isNormalUser extraGroups;
      };

      home-manager.users.${name} = lib.mkMerge [
        # Import "agenix" and configure secrets when available.
        # See: https://github.com/ryantm/agenix
        (lib.mkIf (secrets != { }) {
          imports = builtins.attrValues {
            inherit (inputs.agenix.homeManagerModules)
              default
              ;
          };

          age = {
            identityPaths = [ "/home/${name}/.age-key" ];
            secrets = lib.mapAttrs (path: cfg: {
              file = "${inputs.nix-secrets}/${path}.age";
              path = "/home/${name}/${cfg.target}";
              inherit (cfg) mode;
            }) secrets;
          };
        })

        # Install user packages when provided.
        (lib.mkIf (packages != [ ]) {
          home.packages = packages;
        })

        # Set the home-manager state version.
        # This should match the NixOS release version.
        {
          home.stateVersion = stateVersion;
        }

        # Merge the home-manager configuration.
        home
      ];
    };
}
