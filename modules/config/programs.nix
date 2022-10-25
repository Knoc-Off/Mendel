{ config, lib, pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vim
    bash
    wget
    git
    lutris
    unstable.ferium
    firefox
    opensnitch
    opensnitch-ui
  ];

  home-manager = {
    users.niko = { pkgs, ... }: {
      home.packages = with pkgs; [

        ## CLI
        # CLI tools
        fd
        fzf
        ripgrep
        tealdeer

        # CLI Apps
        mosh
        btop

        # Toolchain
        rustup
        
        ## GUI
        # Graphics
        gimp
        unstable.inkscape-with-extensions
        
        # Internet
        jitsi-meet
        element-desktop
        ungoogled-chromium
        nur.repos.xddxdd.qbittorrent-enhanced-edition

        # personal
        nur.repos.moredread.joplin-desktop
        unstable.easyeffects
      ];
    };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
  };
}
