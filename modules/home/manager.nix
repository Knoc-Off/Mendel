{ pkgs, ... }:
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
    users.niko = { pkgs, ... }: {

      # nix Dir-env shell
      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;


      programs.home-manager.enable = true;
      home.sessionVariables = {
          EDITOR = "nvim";
        };
    };
  };
}
