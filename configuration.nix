{ config, pkgs, ... }:
{
  imports = [ 
    ./bootup.nix
    ./hardware-configuration.nix
    ./modules/home/manager.nix  # - user configs
    ./modules/manager.nix       # - System configs
    <home-manager/nixos>
  ];

   /* System Config structure

   modules/          - every module that builds my system
   ├─ manager.nix      - this loads the user, and configs
   ├─ config/          - system configs
   │ ├─ nur.nix          - Nix User Repo
   │ ├─ overlays.nix     - package overlays, unstable.
   │ ├─ programs.nix     - Applications without added configs
   │ ├─ services.nix     - Services for my computer
   │ ├─ unstable.nix     - Migrate to this from unstable.
   │ └─ network/         - network configs
   │ ' ├─ hosts.nix        - block data to ips's
   │ ' ├─ manager.nix      - control which are loaded
   │ ' ├─ wireguard.nix    - Wireguard module 
   │ ' └─ wireguard-profiles - wireguard profiles
   └─ home/          - User settings
   ' ├─ manager.nix    - where the user is configured
   ' └─ apps/          - applications with specific configs
   ' ' ├─ zsh.nix        - main shell
   ' ' ├─ bash.nix       - shell
   ' ' ├─ nushell.nix    - rust shell
   ' ' ├─ alacritty.nix  - Terminal Emulator
   ' ' ├─ firefox.nix    - firefox profile 
   ' ' ├─ neovim.nix     - modal editor 
   ' ' ├─ bat.nix        - cat alternative 
   ' ' ├─ git.nix        - git config 
   ' ' ├─ sway.nix       - template
   ' ' └─ example.nix    - sway wm config
  */

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
