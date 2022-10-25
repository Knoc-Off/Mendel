{ config, lib, pkgs, ... }:
{
  imports =
    [ 
      ./config/network/manager.nix
      ./config/nur.nix
      ./config/unstable.nix
      #./config/overlays.nix
      ./config/services.nix
      ./config/programs.nix
    ];
}
