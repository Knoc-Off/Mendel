{ pkgs, config, ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import <nur> # (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz")
    { 
      inherit pkgs;
    };
  };
}
