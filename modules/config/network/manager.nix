{ ... }:
{
  imports = [
    #./wireguard.nix
    ./wg-quick.nix
    #./hosts.nix
  ];
  networking = {
    hostName = "lapix PC"; # Define your hostname.
    networkmanager.enable = true;
    firewall.enable = true;
  };
}
