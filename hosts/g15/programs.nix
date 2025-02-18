{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # CLI: Resource monitoring
    btop
    htop
    ncdu
    aria2 # Download manager

    # CLI
    dig
    zip
    stow
    unzip
    ranger # File browser

    # Encoding stuff
    pkgs-stable.ffmpeg

    # GUI Apps
    mpv
    nekoray
    webcord
    alacritty
    tidal-hifi
    google-chrome
    telegram-desktop

    # Office suite
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.fa_IR
    hunspellDicts.en_US-large

    # Games
    prismlauncher
  ];

  programs = {
    fish.enable = true;
    git.enable = true;

    # Games
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
    gamemode = {
      enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = ["--all"];
    };
  };
}
