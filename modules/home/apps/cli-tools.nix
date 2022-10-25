{ config, lib, pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    programs.exa = {
      enable = true;
      enableAliases = true;
    }; 
    programs.bat = {
      enable = true;
      config = {
#        map-syntax = [
#          "*.jenkinsfile:Groovy" "*.props:Java Properties" 
#        ];

        theme = "TwoDark"; 
      };
    };

  };
}
