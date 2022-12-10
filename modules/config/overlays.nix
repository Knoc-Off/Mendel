{ config, ... }:
let


  packageSetsOverlay = self: super: {
    unstable = import <unstable>
      { config = config.nixpkgs.config; };
    nur = import <nur>
      { inherit pkgs; };
  };

  upgradesOverlay = self: super: {
    fubbo = super.unstable.ferium;
    nurpy = super.nur.repos.mic92.hello-nur;
  };

  overlays =
    [
      packageSetsOverlay
      upgradesOverlay
    ];
in
{
  nixpkgs.overlays = overlays;

  home-manager.users.niko = { config, pkgs, ... }:
    {
      nixpkgs.overlays = overlays;
    };
}
