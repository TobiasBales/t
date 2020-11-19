{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./home/extraConfig.vim;

    plugins = with pkgs.vimPlugins; [
      # Syntax / Language Support
      vim-nix
      vim-ruby
      vim-go
      vim-toml
      vim-pandoc
      vim-pandoc-syntax
      vim-terraform
      vim-yaml
      plantuml-syntax

      # Auto completion
      coc-json
      coc-nvim

      # UI
      vim-gitgutter
      vim-devicons
      vim-airline
      gruvbox

      # Tmux integration
      vim-tmux-navigator

      # Editor Features
      vim-surround # cs"'
      vim-repeat # cs"'...
      vim-commentary # gcap
      # vim-ripgrep
      vim-indent-object # >aI
      vim-eunuch # :Rename foo.rb
      vim-unimpaired # [\space to add newline above current line
      supertab
      vim-endwise        # add end, } after opening block
      ale
      nerdtree

      # Buffer / Pane / File Management
      fzf-vim # all the things

      # Panes / Larger features
      tagbar # <leader>5
      vim-fugitive # Gblame
    ];
  };

  home.file.".config/nvim/coc-settings.json".source = ./home/nvim/coc-settings.json;
}
