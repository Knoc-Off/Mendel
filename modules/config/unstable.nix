{ config, pkgs, ... }:
# Facinating way of doing a channel-less unstable deriviation.
#let
#  unstableTarball =
#    fetchTarball
#      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
#  unstableTarball = builtins.fetchGit {
#    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
#    ref = "master";
#    rev = "d473597e332a0bf83f826192684dad128ced147f";
#  };
#in
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <unstable> {
      #unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
}
