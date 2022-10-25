{ config, pkgs, ... }:
{
  services = { 
    # OpenSnitch report connections.
    opensnitch.enable = true;

    # Disable CUPS
    printing.enable = false;

    # Flatpak
    flatpak.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Keyboard
      layout = "us";
      xkbVariant = "";

      # Enable touchpad support
      libinput.enable = true;

      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
