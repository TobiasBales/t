{ config, pkgs, lib, ... }:

let
  relativeXDGDataPath = ".local/share";
in {
  home.packages = with pkgs; [
    exa
    ripgrep
    pwgen
    shellcheck
    tldr
  ];

  programs.bat.enable = true;

  programs.broot.enable = true;

  programs.starship = {
    enable = true;
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
  };
}
