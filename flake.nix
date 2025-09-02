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

        ## <todo>
        ##
        #@ String
        name = "forge";

        ## <todo>
        ##
        #@ Package
        package = pkgs.emacs30;

        ## <todo>
        ##
        #@ AttrSet
        epkgs = pkgs.emacsPackagesFor package;

        ## <todo>
        ##
        #@ [Package]
        packages = with epkgs; [ evil ];

        ## <todo>
        ##
        #@ AttrSet -> Derivation
        mkEmacsPackage =
          {
            ## <todo>
            ##
            #@ Package
            grammars ? epkgs.treesit-grammars.with-all-grammars,

            ## <todo>
            ##
            #@ [Package]
            extraPackages ? [ ],
          }:
          pkgs.symlinkJoin {
            inherit name;

            buildInputs = [ pkgs.makeWrapper ];

            paths = [
              (epkgs.emacsWithPackages (_: packages ++ extraPackages ++ [ grammars ]))
            ];

            postBuild = ''
              # <todo>
              # <todo>
              $out/bin/emacs --batch \
                --eval "(native-compile \"${self}/init.el\" \"$out/share/emacs/native-lisp/init.eln\")"

              # <todo>
              # <todo>
              wrapProgram $out/bin/emacs \
                --add-flags "--init-directory=\''${XDG_CONFIG_HOME:-\$HOME/.config}/emacs" \
                --add-flags "--load $out/share/emacs/native-lisp/init.eln"
            '';
          };

        ## <todo>
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
