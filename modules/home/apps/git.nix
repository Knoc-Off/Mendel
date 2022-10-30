{ pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    #home.packages = with pkgs; [ 
    #];
    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull; # Install git wiith all the optional extras
        userName = "knoc-off";
      userEmail = "github@knoc.one";
      extraConfig = {
        core.editor = "vim";
        # Cache git credentials for 15 minutes
        credential.helper = "cache";
      };
    }; 
  };

  # Cnfigure gh cli too
}
