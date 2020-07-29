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
    userEmail = "tobiasbales@hey.com";
    extraConfig = {
      color.ui = true;
      core.commitGraph = true;
      credential.helper = "osxkeychain";
      diff.algorithm = "patience";
      gc.writeCommitGraph = true;
      github.user = "TobiasBales";
      hub.protocol = "git";
      merge.conflictstyle = "diff3";
      protocol.version = "2";
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };
}
