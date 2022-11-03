{ config, pkgs, ... }:
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

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  

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
    users.niko = { config, pkgs, ... }: {


      nixpkgs.config = {
        allowUnfree = true;
        packageOverrides = pkgs: {
          unstable = import <unstable> { config = config.nixpkgs.config; };
          nur = import <nur> { inherit pkgs; };
        };
      };

      # nix Dir-env shell
      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;

      programs.ssh.extraConfig = "abc";
      programs.ssh.matchBlocks = {
        "relay" = {
          hostname = "192.168.2.224";
          user = "pi";
          #identityFile = "/home/john/.ssh/foo_rsa";
        };
      };

      programs.home-manager.enable = true;
      home.sessionVariables = {
          EDITOR = "nvim";
        };
    };
  };
}
