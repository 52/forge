{
  pkgs,
  ...
}:
{
  fonts = {
    # Install system fonts.
    # See: https://wiki.nixos.org/wiki/fonts
    packages = builtins.attrValues {
      inherit (pkgs)
        corefonts

        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji

        material-symbols
        font-awesome

        tamzen

        apple-fonts
        ;
    };

    fontconfig = {
      defaultFonts = rec {
        # Set the default sans-serif font.
        sansSerif = [
          "SF Pro Text"
          "Noto Sans"
          "Noto Sans CJK SC"
          "Noto Sans CJK JP"
          "Noto Color Emoji"
        ];

        # Set the default monospace font.
        monospace = [
          "SF Mono"
          "Noto Sans Mono"
          "Noto Sans Mono CJK SC"
          "Noto Sans Mono CJK JP"
          "Noto Color Emoji"
        ];

        # Serif fonts were a glorious mistake.
        # This defaults to sans-serif instead.
        serif = sansSerif;

        # Set the default emoji font.
        emoji = [ "Noto Color Emoji" ];
      };

      localConf = ''
        <fontconfig>
          <alias>
            <family>pixel</family>
            <prefer>
              <family>Tamzen</family>
            </prefer>
          </alias>

          <match target="font">
            <test name="family" compare="eq" qual="any">
              <string>Tamzen</string>
            </test>
            <edit name="antialias" mode="assign">
              <bool>false</bool>
            </edit>
            <edit name="hinting" mode="assign">
              <bool>false</bool>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
}
