{ config, pkgs, ... }:  
{
  # Bootloader
  boot.loader.grub.enable = true; 
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  # Enable grub cryptodisk
  boot.loader.grub.enableCryptodisk=true;
  boot.initrd.luks.devices."luks-d03a64ea-e7f6-4e44-8f51-d5fdbfe89efa".keyFile = "/crypto_keyfile.bin";
  # Enable swap on luks
  boot.initrd.luks.devices."luks-4dc9f724-df93-40fe-a3c7-9d6c968d5459".device = "/dev/disk/by-uuid/4dc9f724-df93-40fe-a3c7-9d6c968d5459";
  boot.initrd.luks.devices."luks-4dc9f724-df93-40fe-a3c7-9d6c968d5459".keyFile = "/crypto_keyfile.bin";


}
