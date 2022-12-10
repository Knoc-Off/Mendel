{ ... }:
let

# create set of each profile, then set below
in
{
  # open firewall
  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };

  # Enable WireGuard
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "10.100.0.2/24" ];
      listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "path to private key file";

      peers = [
        # For a client configuration, one peer entry for the server will suffice.

        {
          # Public key of the server (not a file path).
          publicKey = "{server public key}";

          # Forward all the traffic via VPN.
          allowedIPs = [ "0.0.0.0/0" ];
          # Or forward only particular subnets
          #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

          # Set this to the server IP and port.
          endpoint = "{server ip}:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };

  # networking.wg-quick.interfaces = 
  # let
  #   country = "us";
  #   profile = 0;
  #   area = { 
  #     test = [ "testing.conf" ];
  #     us = [ "GA.conf" ]; 
  #     eu = [ "DE_14_SC.conf" ]; 
  #   }."${country}";

  #   config = __elemAt area profile;
  #   name = __elemAt (__split ''\.conf'' config) 0;

  #   # Functions
  #   file = builtins.split "\n" "${builtins.readFile ./wireguard-profiles/${config}}";
  #   find = (str:  __filter (x: if __isString x then ''${__elemAt (builtins.split " = " x) 0}''  == str else false) file);
  #   getval = (x: __elemAt (builtins.split " = " (__elemAt (find x) 0)) 2); 
    
  #   # values 
  #   address = [''${getval "Address"}''];
  #   publicKey = getval "PublicKey";
  #   dns =  [''${getval "DNS"}''];
  #   privateKey = getval "PrivateKey";
  #   allowedIPs =  [''${getval "AllowedIPs"}'']; 
  #   endpoint = getval "Endpoint";

  #   # wireguard config:
  # in {
  #   "${name}" = {
  #     # inherit is same as x = x
  #     inherit address
  #             dns
  #             privateKey;
  #     mtu = 1250; # Should have a if defined else 1250
  #     autostart = true;
  #     #listenPort = 20575;
  #     peers = [
  #       {
  #         inherit publicKey
  #                 allowedIPs
  #                 endpoint;
  #         persistentKeepalive = 25;
  #       }
  #     ];
  #   };
  # };
}
