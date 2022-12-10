{ config, pkgs, ... }:
{
  imports = [
    ./bootup.nix
    ./hardware-configuration.nix
    ./modules/home/manager.nix # - user configs
    ./modules/manager.nix # - System configs
    <home-manager/nixos>
  ];

  # testing this out
  nix.settings.auto-optimise-store = true;



  /* System Config structure
    Channels:
    home-manager  https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz
    nixos         https://nixos.org/channels/nixos-22.05
    unstable      https://channels.nixos.org/nixos-unstable
    nur           https://github.com/nix-community/NUR/archive/master.tar.gz

  */

  # sway stuff
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };



  # Experimental Nix settings 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.utf8";
    LC_IDENTIFICATION = "de_DE.utf8";
    LC_MEASUREMENT = "de_DE.utf8";
    LC_MONETARY = "de_DE.utf8";
    LC_NAME = "de_DE.utf8";
    LC_NUMERIC = "de_DE.utf8";
    LC_PAPER = "de_DE.utf8";
    LC_TELEPHONE = "de_DE.utf8";
    LC_TIME = "de_DE.utf8";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # dont change manually 
  system.stateVersion = "22.05";
}
