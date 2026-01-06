{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  # "Apple Fonts".
  # See: https://developer.apple.com/fonts
  apple-fonts = pkgs.callPackage ./apple-fonts.nix { };
}
