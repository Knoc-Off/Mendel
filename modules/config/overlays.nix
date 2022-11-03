{ ... }:
let
  pkgsConfig = {
    allowUnfree = true;
  };

  packageSetsOverlay = self: super: {
    unstable = import <unstable>
      { config = pkgsConfig; };
    nur = import <nur>
      { config = pkgsConfig; };
  };

  upgradesOverlay = self: super: {
    dropbox = super.pkgsUnstable.dropbox;
    jbake = super.pkgsUnstable.jbake;
  };

  overlays = [ packageSetsOverlay
               upgradesOverlay
             ];
in
{
  nixpkgs.overlays = overlays;
  nixpkgs.config = pkgsConfig;
}
