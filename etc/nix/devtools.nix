{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    aws-iam-authenticator
    awscli
    docker-compose
    dive
    fzf
    global
    jq
    ktlint
    kubectl
    kubectx
    lazydocker
    lefthook
    ngrok
    nmap
    overmind
    terraform
    terraform-lsp
    tflint
  ];
}
