{ ...}:
let
  pkgsConfig = {
    allowUnfree = true;
  };

  packageSetsOverlay = self: super: {
    pkgsUnstable = import (
      fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
    ) { config = pkgsConfig; };
    pkgsMaster = import (
      fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz
    ) { config = pkgsConfig; };
    pkgsLocal = import (
      fetchTarball https://github.com/moaxcp/nixpkgs/archive/local.tar.gz
    ) { config = pkgsConfig; };
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
