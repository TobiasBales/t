{ config, pkgs, lib, ... }:

{
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
}
