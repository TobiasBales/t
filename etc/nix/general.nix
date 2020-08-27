{ config, pkgs, lib, ... }:
{
  home.file."Library/Application Support/MTMR/items.json".source = ./home/mtmr.json;
}
