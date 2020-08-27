{ config, pkgs, lib, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.home-manager.enable = true;

  imports = [
    ./devtools.nix
    ./git.nix
    ./general.nix
    ./go.nix
    ./ruby.nix
    ./shell.nix
    ./tmux.nix
    ./vim.nix
  ];
}

