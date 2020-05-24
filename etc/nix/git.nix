{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    git
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.git-absorb
    gitAndTools.git-interactive-rebase-tool
    gitAndTools.hub
    gitAndTools.tig
    onefetch
  ];

  programs.git = {
    enable = true;
    userName = "Tobias Bales";
    userEmail = "tobias.bales@gmail.com";
    extraConfig = {
      hub.protocol = "https";
      github.user = "TobiasBales";
      color.ui = true;
      pull.rebase = true;
      merge.conflictstyle = "diff3";
      credential.helper = "osxkeychain";
      diff.algorithm = "patience";
      protocol.version = "2";
      core.commitGraph = true;
      gc.writeCommitGraph = true;
    };
  };
}
