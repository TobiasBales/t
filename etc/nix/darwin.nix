{ config, pkgs, lib, ...}:
{
  home.packages = with pkgs; [
    pinentry_mac
    terminal-notifier
  ];
}
