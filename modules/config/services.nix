{ config, pkgs, ... }:
{

  services = { 

    # OpenSnitch report connections.
    opensnitch.enable = true;

    # Disable CUPS
    # printing.enable = true;
    # printing.drivers = [ pkgs.gutenprint pkgs.hplip pkgs.hplipWithPlugin ];

    # Flatpak
    flatpak.enable = true;

    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      videoDrivers = [ "amdgpu" ];

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
  #GPU
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];
}
