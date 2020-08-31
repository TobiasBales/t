{ config, pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    forwardAgent = false;
    serverAliveInterval = 30;
    serverAliveCountMax = 6;
    extraConfig = builtins.readFile ./home/ssh-config;
  };
}
