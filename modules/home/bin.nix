{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) relativePath;

  ## The package name.
  ##
  #@ String
  pname = "forge";

  ## The package version.
  ##
  #@ String
  version = "0.1.0";

  ## The package derivation.
  ##
  #@ Derivation
  forge = pkgs.stdenv.mkDerivation {
    inherit pname version;

    src = relativePath "bin";

    nativeBuildInputs = with pkgs; [
      amber-lang
      makeWrapper
    ];

    buildPhase = ''
      amber build main.ab ${pname}
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp ${pname} $out/bin/${pname}
      chmod +x $out/bin/${pname}

      wrapProgram $out/bin/${pname} \
        --prefix PATH : "${pkgs.bc}/bin"
    '';
  };
in
{
  home.packages = [ forge ];
}
