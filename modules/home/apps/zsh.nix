{ pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    home.packages = with pkgs; [
      unstable.chroma # Required for colorize...
      imagemagick # Required for catomg
      thefuck # If you forget sudo or something
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

      

        
        alias uniq="awk '{lines[$0]=$0} END{for(l in lines) print l}'"
        PS1=" %F{3}%3~ %f%# "

        EDITOR="nvim"
        function edit () {
          if [[ ! -w "$(dirname $(realpath '$1'))" ]]; then
            sudo nvim "$1"
            return;
          fi
          if [[ ! -w "$(realpath '$1'))" ]]; then
            sudo nvim "$1"
            return;
          fi
          nvim $1
        }
        # Should search for a matching word in apps
        function nx () {
          if [ ! $1 ]; then
            exa -T /etc/nixos/
          else
            case $1 in
              rb)
                sudo nixos-rebuild switch
              ;;
              rt)
                sudo nixos-rebuild test
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
       
        # Function that generates a shell.nix in the 
        # current dir, should take some inputs
        function nix-shellgen () { 
          # Parse args, should make them string-inputs
          # env - generate a direnv and allow
          # stable,unstable,nur - the imports
          # pkgs - what programs should be added
          # run - the shellhook to be added.
          # etc...

          # right now im gonna do a shit implamentation
          if [ $1 ]; then
            echo "arguments? who do you think I am";
          fi
          if [[ -f ./shell.nix ]]; then return 1; fi

          echo \
"{ pkgs ? import <nixpkgs> {},  unstable ? import <unstable> {}}:
pkgs.mkShell {
  buildInputs = [
  ];
  shellHook = \"
  \";
}" > shell.nix;
          if [[ -f ./.envrc ]]; then return 1; fi
          echo "use nix" > .envrc;
          direnv allow

        }


        # Silence Direnv output:
        export DIRENV_LOG_FORMAT=
      '';
    };
  };
}
