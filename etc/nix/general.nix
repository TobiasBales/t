{ config, pkgs, lib, ... }:
{
  home.file.".alacritty.yml".source = ./home/alacritty.yml;
  home.file."Library/Application Support/MTMR/items.json".source = ./home/mtmr.json;
  home.packages = with pkgs; [
    streamlink
  ];
}
