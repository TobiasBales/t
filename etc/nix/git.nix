{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    git
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.git-absorb
    gitAndTools.git-codeowners
    gitAndTools.git-interactive-rebase-tool
    gitAndTools.git-trim
    gitAndTools.hub
    gitAndTools.tig
    onefetch
  ];

  programs.git = {
    enable = true;
    userName = "Tobias Bales";
    userEmail = "hi@tobiasbales.dev";
    extraConfig = {
      color.branch = "auto";
      color.diff = "auto";
      color.interactive = "auto";
      color.status = "auto";
      color.ui = true;
      core.autocrlf = "input";
      core.commitGraph = true;
      core.editor = "vim";
      core.pager = "diff-so-fancy | less --tabs=4 -RFX";
      credential.helper = "osxkeychain";
      diff.algorithm = "patience";
      gc.writeCommitGraph = true;
      github.user = "TobiasBales";
      hub.protocol = "git";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      protocol.version = "2";
      pull.rebase = true;
      rebase.autoStash = true;
      rerere.enabled = true;
      sequence.editor = "interactive-rebase-tool";
      trim.bases = "main,master";
    };
  };
}
