{ config, lib, pkgs, ... }:
{
  imports =
    [ 
      ./apps/git.nix
      ./apps/neovim.nix
      ./apps/alacritty.nix
      ./apps/firefox.nix
      ./apps/bash.nix
      ./apps/zsh.nix
      ./apps/cli-tools.nix
#      ./apps/swaytest.nix
    ];

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  users.users.niko = {
    isNormalUser = true;
    description = "Niko";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.niko = { pkgs, ... }: {
      programs.home-manager.enable = true;
      home = {
        sessionVariables = {
          EDITOR = "nvim";
        };
      };
    };
  };
}
