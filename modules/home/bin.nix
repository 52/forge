{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) relativePath;

  ## Package name.
  ##
  #@ String
  pname = "forge";

  ## Package version.
  ##
  #@ String
  version = "0.1.0";

  ## Package derivation.
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
