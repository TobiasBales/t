{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    act
    aws-iam-authenticator
    awscli
    direnv
    dive
    docker-compose
    fzf
    global
    graphviz
    jq
    ktlint
    kubectl
    kubectx
    lazydocker
    lefthook
    libxml2
    lorri
    ngrok
    nmap
    nodejs
    overmind
    ruby
    terraform
    terraform-lsp
    tflint
    yubikey-agent
  ];
}
