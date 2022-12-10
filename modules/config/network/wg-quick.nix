{ ... }:
{
  networking.wg-quick.interfaces = 
  let
    country = "eu";
    profile = 0;
    area = { 
      test = [ "testing.conf" ];
      us = [ "GA.conf" ]; 
      eu = [ "DE_14_SC.conf" ]; 
    }."${country}";

    config = __elemAt area profile;
    name = __elemAt (__split ''\.conf'' config) 0;

    # Functions
    file = builtins.split "\n" "${builtins.readFile ./wireguard-profiles/${config}}";
    find = (str:  __filter (x: if __isString x then ''${__elemAt (builtins.split " = " x) 0}''  == str else false) file);
    getval = (x: __elemAt (builtins.split " = " (__elemAt (find x) 0)) 2); 
    
    # values 
    address = [''${getval "Address"}''];
    publicKey = getval "PublicKey";
    dns =  [''${getval "DNS"}''];
    privateKey = getval "PrivateKey";
    allowedIPs =  [''${getval "AllowedIPs"}'']; 
    endpoint = getval "Endpoint";

    # wireguard config:
  in {
    "${name}" = {
      # inherit is same as x = x
      inherit address
              dns
              privateKey;
      mtu = 1250; # Should have a if defined else 1250
      autostart = true;
      #listenPort = 20575;
      peers = [
        {
          inherit publicKey
                  allowedIPs
                  endpoint;
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
