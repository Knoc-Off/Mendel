{ config, lib, pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    home.sessionVariables = {
      EDITOR = "nvim";
    };
    programs.bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        #PS1 = ''\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '';

      };
      bashrcExtra = ''
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
              edit "$file"
            ;;
        esac
        }
        
        function swapps1 () {
          PS1="\[\033[1;32m\]$1\[\033[0m\] "
        }
        
        function gitps1 {
          swapps1 "\W\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'):\u@\H\[$(tput sgr0)\]"
        }

      '';
      shellAliases = 
      {

      };
    }; 
  };
}
