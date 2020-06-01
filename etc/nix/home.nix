{ config, pkgs, lib, ... }:

let
  relativeXDGConfigPath = ".config";
  relativeXDGDataPath = ".local/share";
  relativeXDGCachePath = ".cache";
in {
  imports = [
    ./devtools.nix
    ./git.nix
    ./go.nix
    ./ruby.nix
    ./shell.nix
    ./tmux.nix
    ./vim.nix
  ];

  xdg.enable = true;
  xdg.configHome = "/Users/tobias/${relativeXDGConfigPath}";
  xdg.dataHome = "/Users/tobias/${relativeXDGDataPath}";
  xdg.cacheHome = "/Users/tobias/${relativeXDGCachePath}";

  programs.home-manager.enable = true;
}

