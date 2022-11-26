{ config, pkgs, ... }:
{
  imports =
    [
      ./apps/git.nix
      ./apps/neovim.nix
      ./apps/helix.nix
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

  # Write to file ~/.ssh/config
  # add all of my host configs

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

      home.file.".ssh/config".text = 
        ''
        Host kobbl
            HostName kobbl.co
            Port 22
            User root
          
            # any other fancy option needed to log in
            # ProxyJump foo ...
          
            IdentitiesOnly yes
            IdentityFile ~/.ssh/id_rsa
          
          host relay
            HostName 192.168.8.165
            Port 8224
            User root
            IdentitiesOnly yes
            IdentityFile ~/.ssh/id_rsa
          
          host nixpi
            HostName 192.168.8.165
            Port 8188
            User root
            IdentitiesOnly yes
            IdentityFile ~/.ssh/id_rsa
        '';

      #      nixpkgs.config = {
      #        allowUnfree = true;
      #        packageOverrides = pkgs: {
      #          unstable = import <unstable> { config = config.nixpkgs.config; };
      #          nur = import <nur> { inherit pkgs; };
      #        };
      #      };

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
