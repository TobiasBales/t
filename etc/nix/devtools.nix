{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    awscli
    docker-compose
    global
    jq
    ktlint
    lefthook
    overmind
  ];
}
