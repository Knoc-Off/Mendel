{ pkgs, ... }:
{
  home-manager.users.niko = { pkgs, ... }: {
    home.packages = with pkgs; [
      unstable.chroma # Required for colorize...
      imagemagick # Required for catomg
      thefuck # If you forget sudo or something
      qrencode
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
      };
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [
#        "branch"
#        "catimg"
#        "colored-man-pages"
        "colorize"
        #"common-aliases"
        #"cp"
        "extract"
        "fancy-ctrl-z"
        "fd"
        "mosh"
        #"thefuck"
        #"gh"
        #"git"
      ];
      shellAliases = {
        rm = ''echo "use trash-cli instead"'';
        remove = "rm";
        tmux = "TERM=screen-256color tmux";
      };
#      plugins = [
#        {
#          name = "zsh-you-should-use";
#          src = pkgs.zsh-you-should-use;
#        }
#        {
#          name = "syntax-highlighting";
#          src = pkgs.zsh-syntax-highlighting;
#        }
#        {
#          name = "zsh-fzf-tab";
#          src = pkgs.zsh-fzf-tab;
#        }
#        {
#          name = "zsh-completions";
#          src = pkgs.zsh-completions;
#        }
#      ];
      initExtra = __readFile ../configs/zshrc.sh; 
    };
  };
}
