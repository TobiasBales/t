{ config, pkgs, lib, ... }:

let
  relativeXDGConfigPath = ".config";
  relativeXDGDataPath = ".local/share";
  relativeXDGCachePath = ".cache";
  osConfigFile = if builtins.currentSystem == "x86_64-linux" then ./linux.nix else ./darwin.nix;
in {
  imports = [
    ./devtools.nix
    ./git.nix
    ./go.nix
    ./shell.nix
    ./tmux.nix
    ./vim.nix
    osConfigFile 
  ];

  xdg.enable = true;
  xdg.configHome = "/Users/tobias/${relativeXDGConfigPath}";
  xdg.dataHome = "/Users/tobias/${relativeXDGDataPath}";
  xdg.cacheHome = "/Users/tobias/${relativeXDGCachePath}";

  programs.home-manager.enable = true;
}

