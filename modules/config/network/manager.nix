{ ... }:
{
  imports = [
    ./wireguard.nix
    #./hosts.nix
  ];
  networking = {
    hostName = "lapix"; # Define your hostname.
    networkmanager.enable = true;
    firewall.enable = true;
  };
}
