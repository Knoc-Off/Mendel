{ pkgs, config, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <unstable> { config = config.nixpkgs.config; };
      nur = import <nur> { inherit pkgs; };
    };
  };
}
