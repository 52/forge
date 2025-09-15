{
  description = "GNU Emacs with sensible defaults";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
        };

        ## The package name.
        ##
        #@ String
        name = "forge";

        ## The GNU Emacs package.
        ##
        #@ Package
        package = pkgs.emacs-pgtk;

        ## Sets of GNU Emacs packages.
        ##
        #@ AttrSet
        epkgs = {
          ## Set of stable packages.
          ##
          #@ AttrSet
          stable = pkgs.emacsPackagesFor package;

          ## Set of unstable packages.
          ##
          #@ AttrSet
          unstable = pkgs-unstable.emacsPackagesFor package;
        };

        ## List of packages to install.
        ##
        #@ [Package]
        packages = with epkgs.unstable; [
          undo-fu
          undo-fu-session
          smartparens
          vertico
          orderless
          marginalia
          consult
          corfu
          treesit-auto
          vterm
          xclip
          evil
        ];

        ## The GNU Emacs derivation.
        ##
        #@ Derivation
        forge = pkgs.symlinkJoin {
          inherit name;

          paths = with epkgs.stable; [
            (emacsWithPackages (_: packages))
          ];

          buildInputs = [
            pkgs.makeWrapper
          ];

          postBuild = ''
            mkdir -p $out/src
            cp -r "${self}"/* $out/src
            chmod -R u+w $out/src

            wrapProgram $out/bin/emacs \
              --set NIX "1" \
              --append-flags "--init-directory $out/src"
          '';
        };
      in
      {
        apps.default = {
          type = "app";
          program = "${forge}/bin/emacs";
        };

        packages.default = forge;

        overlays.default = _: prev: {
          ${name} = forge;
        };

        # Shell used by "nix develop".
        # See: https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-develop
        devShell = pkgs.mkShell {
          shellHook = ''
            echo "Entering the 'github:52/forge' development environment"
            echo "Execute 'emacs' or 'emacs -nw' to open the build"
          '';

          packages =
            (with pkgs; [
              nixfmt-rfc-style
              deadnix
              statix
              nixd
            ])
            ++ [ forge ];
        };
      }
    );
}
