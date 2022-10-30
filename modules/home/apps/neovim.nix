{ pkgs, ... }:
{
  programs.neovim.defaultEditor = true;
  home-manager.users.niko = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      extraConfig = 
      "
        set autoindent 
        set expandtab 
        set tabstop=2 
        set shiftwidth=2
        set undofile
      ";
      #plugins = with pkgs.vimPlugins; [
      plugins = with pkgs; [
        vimPlugins.direnv-vim # For .direnv + nixshell
        vimPlugins.yankring
        vimPlugins.vim-nix
        vimPlugins.nvim-treesitter
        vimPlugins.nvim-lspconfig
        vimPlugins.nvim-cmp
        vimPlugins.fzf-vim
        vimPlugins.fzfWrapper
        vimPlugins.haskell-vim
        vimPlugins.vim-lua
        vimPlugins.coc-lua
        vimPlugins.rust-vim
        vimPlugins.coc-rust-analyzer
        vimPlugins.vim-markdown
        vimPlugins.vim-json
        vimPlugins.coc-json
        vimPlugins.neoformat
        nur.repos.m15a.vimExtraPlugins.firenvim
        nur.repos.m15a.vimExtraPlugins.zephyrium
      ];
    };
  }; 
  home-manager.users.root = { pkgs, ... }: {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      extraConfig =
      "
        set autoindent
        set expandtab
        set tabstop=2
        set shiftwidth=2
      ";
      plugins = with pkgs; [
        vimPlugins.yankring
        vimPlugins.vim-nix
        vimPlugins.nvim-treesitter
        vimPlugins.nvim-lspconfig
        vimPlugins.nvim-cmp
        vimPlugins.fzf-vim
        vimPlugins.fzfWrapper
        vimPlugins.haskell-vim
        vimPlugins.vim-lua
        vimPlugins.coc-lua
        vimPlugins.rust-vim
        vimPlugins.coc-rust-analyzer
        vimPlugins.vim-markdown
        nur.repos.m15a.vimExtraPlugins.firenvim
        nur.repos.m15a.vimExtraPlugins.zephyrium
      ];
    };
  };

}
