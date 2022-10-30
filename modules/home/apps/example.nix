{ pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    #home.packages = with pkgs; [ 
    #];
    programs.bat = {
      enable = true;
    };
  };
}
