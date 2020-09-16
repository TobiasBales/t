{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];
  home-manager.users.tobias = ./home.nix;
  home-manager.useUserPackages = true;

  environment.systemPackages = with pkgs; [
    home-manager
    pinentry_mac
    terminal-notifier
  ];

  environment.shells = with pkgs; [ zsh ];
  environment.loginShell = pkgs.zsh;

  environment.darwinConfig = "/opt/t/etc/nix/darwin.nix";

  programs.bash.enable = false;
  programs.zsh.enable = true;
  programs.fish.enable = false;

  environment.userLaunchAgents = {
    yubikeyAgent = {
      enable = true;
      source = ./home/yubikey-agent.plist;
      target = "yubikey-agent.plist";
    };
    lorriAgent = {
      enable = true;
      source = ./home/lorri-daemon.plist;
      target = "lorri-daemon.plist";
    };
  };

  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "FiraCode" "JetBrainsMono" ];
    })
  ];

  system.stateVersion = 4;

  programs.nix-index.enable = true;

  nix.gc.automatic = true;
  nix.gc.user = "tobias";
  nix.gc.options = "--max-freed $((25 * 1024**3 - 1024 * $(df -P -k /nix/store | tail -n 1 | awk '{ print $4 }')))";

  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.NSGlobalDomain._HIHideMenuBar = false;

  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-delay = "0.1";
  system.defaults.dock.autohide-time-modifier = "0.1";
  system.defaults.dock.expose-animation-duration = "0.0";
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.showhidden = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 48;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = false;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;
}

