{
  description = "GNU Emacs with sensible defaults";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
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

        ## Set of GNU Emacs packages for the package version.
        ##
        #@ AttrSet
        epkgs = pkgs.emacsPackagesFor package;

        ## List of packages to install.
        ##
        #@ [Package]
        packages = with epkgs; [
          spacious-padding
          evil
        ];

        ## Create a custom GNU Emacs package.
        ##
        #@ AttrSet -> Derivation
        mkEmacsPackage =
          {
            ## Tree-sitter packages to install.
            ## See: https://github.com/orgs/tree-sitter-grammars
            ##
            #@ Package
            grammars ? epkgs.treesit-grammars.with-all-grammars,

            ## List of extra packages to install.
            ##
            #@ [Package]
            extraPackages ? [ ],
          }:
          pkgs.symlinkJoin {
            inherit name;

            paths = [
              (epkgs.emacsWithPackages (_: packages ++ extraPackages ++ [ grammars ]))
            ];

            buildInputs = [
              pkgs.makeWrapper
            ];

            postBuild = ''
              mkdir -p $out/src
              cp -r "${self}"/* $out/src
              chmod -R u+w $out/src

              export EMACSNATIVELOADPATH=$out/eln-cache

              $out/bin/emacs -L $out/src -L $out/src/modules --batch \
                -f batch-byte-compile $out/src/*.el $out/src/**/*.el
                
              $out/bin/emacs -L $out/src -L $out/src/modules --batch \
                -f batch-native-compile $out/src/*.el $out/src/**/*.el
                
              wrapProgram $out/bin/emacs \
                --set EMACSNATIVELOADPATH "$out/eln-cache" \
                --set EMACSTHEMEPATH "$out/src/themes:" \
                --set EMACSLOADPATH "$out/src/modules:" \
                --append-flags "--init-directory $out/src"
            '';
          };

        ## The GNU Emacs derivation.
        ##
        #@ Derivation
        forge = mkEmacsPackage { };
      in
      {
        apps.default = {
          type = "app";
          program = "${forge}/bin/emacs";
        };

        packages.default = {
          ${name} = forge;
        };

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
