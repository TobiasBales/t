{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];
  home-manager.users.tobias = ./home.nix;
  home-manager.useUserPackages = true;

  environment.systemPackages = with pkgs; [
    home-manager
    pinentry_mac
    terminal-notifier
  ];

  environment.shells = with pkgs; [ zsh ];

  environment.darwinConfig = "/t/etc/nix/darwin.nix";

  programs.bash.enable = false;
  programs.zsh.enable = true;
  programs.fish.enable = false;

  system.stateVersion = 4;
}

