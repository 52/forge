{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  # "Apple Fonts".
  # See: https://developer.apple.com/fonts
  apple-fonts = pkgs.callPackage ./apple-fonts.nix { };

  # "Atom Fonts"
  # See: https://typeof.net/Iosevka
  atom-fonts = pkgs.callPackage ./atom-fonts.nix { };
}
