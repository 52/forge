{

  lib,
  xorg,
  p7zip,
  fetchurl,
  stdenvNoCC,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "apple-fonts";
  version = "1.0";

  srcs = [
    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
      sha256 = "sha256-Lk14U5iLc03BrzO5IdjUwORADqwxKSSg6rS3OlH9aa4=";
    })

    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
      sha256 = "sha256-bUoLeOOqzQb5E/ZCzq0cfbSvNO1IhW1xcaLgtV2aeUU=";
    })

    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
      sha256 = "sha256-CMNP+sL5nshwK0lGBERp+S3YinscCGTi1LVZVl+PuOM=";
    })

    (fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
      sha256 = "sha256-HC7ttFJswPMm+Lfql49aQzdWR2osjFYHJTdgjtuI+PQ=";
    })
  ];

  nativeBuildInputs = [
    xorg.mkfontscale
    xorg.mkfontdir
    p7zip
  ];

  sourceRoot = ".";

  unpackPhase = ''
    for dmg in $srcs; do
      7z x "$dmg"
    done

    cd SFProFonts
    7z x "SF Pro Fonts.pkg"
    7z x "Payload~"
    cd ..

    cd SFCompactFonts
    7z x "SF Compact Fonts.pkg"
    7z x "Payload~"
    cd ..

    cd SFMonoFonts
    7z x "SF Mono Fonts.pkg"
    7z x "Payload~"
    cd ..

    cd NYFonts
    7z x "NY Fonts.pkg"
    7z x "Payload~"
    cd ..
  '';

  installPhase = ''
    find . -name "*.otf" -exec install -Dm644 {} -t $out/share/fonts/opentype \;
    find . -name "*.ttf" -exec install -Dm644 {} -t $out/share/fonts/truetype \;

    mkfontscale "$out/share/fonts/opentype"
    mkfontdir "$out/share/fonts/opentype"

    mkfontscale "$out/share/fonts/truetype"
    mkfontdir "$out/share/fonts/truetype"
  '';

  meta = with lib; {
    homepage = "https://developer.apple.com/fonts";
    description = "Apple Fonts for NixOS";
    platforms = platforms.all;
    license = licenses.unfree;
  };
}
