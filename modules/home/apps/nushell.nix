{ config, lib, pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    #home.packages = with pkgs; [ 
    #];
  programs.nushell = {

    envFile.text = 
    ''
      let-env FOO = 'BAR'
    '';
    configFile.text = 
    ''
      let $config = {
      filesize_metric: false
      table_mode: rounded
      use_ls_colors: true
      }
    '';


  };


}
