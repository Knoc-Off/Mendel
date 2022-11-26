{ config, lib, pkgs, ... }:
let
  # Packages for the user:


  # Packages for root:
  

in
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
    trash-cli
  ];

  home-manager.users.niko = { pkgs, ... }: {
    home.packages = with pkgs; [
      # CLI tools
      fd
      fzf
      nnn
      ripgrep
      tealdeer

      # CLI Apps
      unstable.mosh
      btop
      unstable.lazygit
      unstable.sshfs

      # Internet
      jitsi-meet
      element-desktop
      ungoogled-chromium
      nur.repos.xddxdd.qbittorrent-enhanced-edition

      # personal
      unstable.whatsapp-for-linux
      nur.repos.moredread.joplin-desktop
      unstable.trilium-desktop
      unstable.easyeffects

      # Graphics
      unstable.gimp
      # [todo] Spotify with adblock
      # Do with overides during install process.
      # Fetch from abba123, edit desktop exec, to lg preload
      # spotify

      # Language Servers:
      unstable.nodejs
      rnix-lsp
      nodePackages.bash-language-server
      unstable.sumneko-lua-language-server
    ];
  };

#  programs.steam = {
#    enable = true;
#    remotePlay.openFirewall = false;
#    dedicatedServer.openFirewall = false;
#  };
}
