{ config, pkgs, lib, ... }:

let
  relativeXDGConfigPath = ".config";
  relativeXDGDataPath = ".local/share";
  relativeXDGCachePath = ".cache";
  osConfigFile = if builtins.currentSystem == "x86_64-linux" then ./linux.nix else ./darwin.nix;
in {
  imports = [ osConfigFile ];

  home.packages = with pkgs; [
    awscli
    docker-compose
    exa
    git
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.git-absorb
    gitAndTools.git-interactive-rebase-tool
    gitAndTools.hub
    gitAndTools.tig
    global
    go
    golangci-lint
    jq
    ktlint
    lefthook
    onefetch
    overmind
    pwgen
    shellcheck
    tldr
  ];

  xdg.enable = true;
  xdg.configHome = "/Users/tobias/${relativeXDGConfigPath}";
  xdg.dataHome = "/Users/tobias/${relativeXDGDataPath}";
  xdg.cacheHome = "/Users/tobias/${relativeXDGCachePath}";

  programs.home-manager.enable = true;
  programs.bat.enable = true;
  programs.broot.enable = true;

  programs.git = {
    enable = true;
    userName = "Tobias Bales";
    userEmail = "tobias.bales@gmail.com";
    extraConfig = {
      hub.protocol = "https";
      github.user = "TobiasBales";
      color.ui = true;
      pull.rebase = true;
      merge.conflictstyle = "diff3";
      credential.helper = "osxkeychain";
      diff.algorithm = "patience";
      protocol.version = "2";
      core.commitGraph = true;
      gc.writeCommitGraph = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    defaultKeymap = "emacs";
    shellAliases = import ./home/aliases.nix;
    history = {
      path = "${relativeXDGDataPath}/zsh/.zsh_history";
      size = 50000;
      save = 50000;
    };
    initExtraBeforeCompInit = builtins.readFile ./home/pre-compinit.zsh;
    initExtra = builtins.readFile ./home/post-compinit.zsh;

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.3";
          sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
    ];

    sessionVariables = rec {
      NVIM_TUI_ENABLE_TRUE_COLOR = "1";

      HOME_MANAGER_CONFIG = /t/etc/nix/home.nix;

      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";

      EDITOR = "vim";
      VISUAL = EDITOR;
      GIT_EDITOR = EDITOR;

      GOPATH = "$HOME";

      PATH = "$HOME/bin:$PATH";

      DOKKU_HOST="prettyrandom.net";
    };
    # envExtra
    # profileExtra
    # loginExtra
    # logoutExtra
    # localVariables
  };

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
      nerdtree

      # Buffer / Pane / File Management
      fzf-vim # all the things

      # Panes / Larger features
      tagbar # <leader>5
      vim-fugitive # Gblame
    ];
  };

  programs.tmux = {
    enable = true;
    secureSocket = false;
    aggressiveResize = true;
    shortcut = "a";
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = builtins.readFile ./home/extraConfig.tmux;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      pain-control
      gruvbox
    ];
  };

  programs.starship = {
    enable = true;
  };
}

