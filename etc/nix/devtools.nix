{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    act
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
    nodejs
    nmap
    overmind
    ruby
    terraform
    terraform-lsp
    tflint
  ];
}
