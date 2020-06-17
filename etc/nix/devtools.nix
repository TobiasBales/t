{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    aws-iam-authenticator
    awscli
    docker-compose
    fzf
    global
    jq
    ktlint
    lazydocker
    lefthook
    overmind
    terraform
    terraform-lsp
    tflint
  ];
}
