{
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) attrNames filterAttrs readFileRelative relativePath;

  # List of scripts inside the "bin" directory.
  scripts = attrNames (
    filterAttrs (_: type: type == "regular") (builtins.readDir (relativePath "bin"))
  );
in
{
  # Install custom scripts, see: "bin" folder.
  home.packages = builtins.map (
    name: pkgs.writeScriptBin name (readFileRelative "bin/${name}")
  ) scripts;
}
