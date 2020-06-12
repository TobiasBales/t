{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    awscli
    docker-compose
    fzf
    global
    jq
    ktlint
    lefthook
    overmind
    terraform
    terraform-lsp
    tflint
  ];
}
