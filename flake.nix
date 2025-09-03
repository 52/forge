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
        package = pkgs.emacs30;

        ## Set of GNU Emacs packages for the package version.
        ##
        #@ AttrSet
        epkgs = pkgs.emacsPackagesFor package;

        ## List of packages to install.
        ##
        #@ [Package]
        packages = with epkgs; [ evil ];

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
              $out/bin/emacs --batch \
                --eval "(native-compile \"${self}/early-init.el\" \"$out/share/emacs/native-lisp/early-init.eln\")" \
                --eval "(native-compile \"${self}/init.el\" \"$out/share/emacs/native-lisp/init.eln\")"

              wrapProgram $out/bin/emacs \
                --add-flags "--init-directory=\''${XDG_CONFIG_HOME:-\$HOME/.config}/emacs" \
                --add-flags "--load $out/share/emacs/native-lisp/early-init.eln" \
                --add-flags "--load $out/share/emacs/native-lisp/init.eln"
            '';
          };

        ## The GNU Emacs derivation.
        ##
        #@ Derivation
        forge = mkEmacsPackage { };
      in
      {
        overlays.default = _: prev: {
          ${name} = package;
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
