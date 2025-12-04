{
  inputs,
  ...
}:
{
  # Add custom packages.
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # Add custom overrides.
  overrides = final: prev: { };

  # Add unstable packages.
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config = {
        allowUnfree = true;
      };
    };
  };

  # Add the "github:nix-community/nur" overlay.
  nur = inputs.nur.overlays.default;

  # Add the "github:52/vix" overlay.
  vix = inputs.vix.overlays.default;
}
