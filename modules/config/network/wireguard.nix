{ config, pkgs, ... }:
{
  networking.wg-quick.interfaces = 
  let
    country = "eu";
    profile = 2;
    # Random number support? if profile set to -1 then generate random 
    # Randomness is very hard to achieve, no clear support for it.
    # i can curl a html page that stores salts, then do math on them
    # other than that i dont think its possible or useful.

    area = { 
      us = [ "US_1_SC.conf" ]; 
      eu = [ "DE_1_SC.conf" "DE_14.conf" "DE_14_SC.conf" ]; 
    }."${country}";

    config = __elemAt area profile;
    name = __elemAt (__split ''\.conf'' config) 0;

    # Functions
    file = builtins.split "\n" "${builtins.readFile ./wireguard-profiles/${config}}";
    find = (str:  __filter (x: if __isString x then ''${__elemAt (builtins.split " = " x) 0}''  == str else false) file);
    
    getval = (x: __elemAt (builtins.split " = " (__elemAt (find x) 0)) 2); 
    
    ## Define values 
    address = [''${getval "Address"}''];
    publicKey = getval "PublicKey";
    dns =  [''${getval "DNS"}''];
    privateKey = getval "PrivateKey";
    allowedIPs =  [''${getval "AllowedIPs"}'']; 
    endpoint = getval "Endpoint";

    ## actual wireguard config:
  in {
    "${name}" = {
      # inherit is same as x = x
      inherit address
              dns
              privateKey;
      mtu = 1250; # Should have a if defined else 1250
      autostart = true;
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
