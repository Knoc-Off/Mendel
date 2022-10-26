{ config, lib, pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    home.packages = with pkgs; [
      unstable.chroma # Required for colorize...
      imagemagick # Required for catomg
      thefuck
    ];

    programs.mcfly = {
      enable = true;
      enableZshIntegration = true;
      keyScheme = "vim";
    };

    programs.zsh = {
      enable = true;
      sessionVariables = {
        ZSH_COLORIZE_TOOL = "chroma";
        EDITOR = "nvim";
        };
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [
        "branch"
        "catimg"
        "colored-man-pages"
        "colorize"
        "common-aliases"
        "cp"
        "extract"
        "fancy-ctrl-z"
        "fd"
        "mosh"
        #"sudo"
        "thefuck"
        #"gh"
        #"git"
      ];
      plugins = [
        {
          name = "zsh-you-should-use";
          src = pkgs.zsh-you-should-use;
        }
        {
          name = "syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
        }
        {
          name = "zsh-fzf-tab";
          src = pkgs.zsh-fzf-tab;
        }
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
        }
      ];
      initExtra = ''
        # ~/.zshrc
        autoload -Uz vcs_info # enable vcs_info
        precmd () { vcs_info } # always load before displaying the prompt
        zstyle ':vcs_info:*' formats ' %s(%F{red}%b%f)' # git(main)

        ## DirEnv Config
        eval "$(direnv hook zsh)"

      

        EDITOR="nvim"
        PS1=" %F{3}%3~ %f%# "
        
        alias uniq="awk '{lines[$0]=$0} END{for(l in lines) print l}'"

        function edit () {
          if [[ ! -w "$(dirname $(realpath '$1'))" ]]; then
            sudoedit "$1"
            return;
          fi
          if [[ ! -w "$(realpath '$1'))" ]]; then
            sudoedit "$1"
            return;
          fi
          nvim $1
        }
        # Should search for a matching word in apps
        function nx () {
          if [ ! $1 ]; then
            echo "
              modules/          - every module that builds my system
              ├─ manager.nix      - this loads the user, and configs
              ├─ config/          - system configs
              │  ├─ nur.nix          - Nix User Repo
              │  ├─ overlays.nix     - package overlays, unstable.
              │  ├─ programs.nix     - Applications without added configs
              │  ├─ services.nix     - Services for my computer
              │  ├─ unstable.nix     - Migrate to this from unstable.
              │  └─ network/         - network configs
              │  '  ├─ hosts.nix        - block data to ips's
              │  '  ├─ manager.nix      - control which are loaded
              │  '  ├─ wireguard.nix    - Wireguard module
              │  '  └─ wireguard-profiles - wireguard profiles
              └─ home/          - User settings
              '  ├─ manager.nix    - where the user is configured
              '  └─ apps/          - applications with specific configs
              '  '  ├─ zsh.nix        - main shell
              '  '  ├─ bash.nix       - shell
              '  '  ├─ nushell.nix    - rust shell
              '  '  ├─ alacritty.nix  - Terminal Emulator
              '  '  ├─ firefox.nix    - firefox profile
              '  '  ├─ neovim.nix     - modal editor
              '  '  ├─ bat.nix        - cat alternative
              '  '  ├─ git.nix        - git config
              '  '  ├─ sway.nix       - sway config
              '  '  └─ example.nix    - template config
            "
          else
            case $1 in
              rb)
                sudo nixos-rebuild switch
              ;;
              cf)
                edit /etc/nixos/configuration.nix
              ;;
              *)
                # Search for match in /apps
                file=$(fd . /etc/nixos/ -e nix -E .git -E wireguard-profiles -H | fzf --query "$@")
                if [[ $file == "" ]]; then return; fi
                EDITOR="nvim" edit "$file"
              ;;
            esac
          fi
        }
       
      '';
    };
  };
}
