{ config, lib, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    niv
    bash
    wget
    git
    lutris
    firefox
    opensnitch
    opensnitch-ui
  ];

  home-manager = {
    users.niko = { pkgs, ... }: {
      home.packages = with pkgs; [
        # CLI tools
        fd
        fzf
        ripgrep
        tealdeer

        # CLI Apps
        unstable.mosh
        btop
        unstable.lazygit
        sl # Vital for system functionality

        # Internet
        jitsi-meet
        element-desktop
        ungoogled-chromium
        nur.repos.xddxdd.qbittorrent-enhanced-edition

        # personal
        nur.repos.moredread.joplin-desktop
        unstable.easyeffects
        unstable.rpi-imager
        unstable.nodejs # For vim coc

        # Graphics
        unstable.gimp
        # [todo] Spotify with adblock
        # spotify
        # nur.repos.instantos.spotify-adblock
      ];
    };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
  };
}
