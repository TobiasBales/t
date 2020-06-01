{ config, pkgs, lib, ... }:
{
  programs.home-manager.enable = true;

  imports = [
    ./devtools.nix
    ./git.nix
    ./go.nix
    ./ruby.nix
    ./shell.nix
    ./tmux.nix
    ./vim.nix
  ];
}

