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
    onlyoffice-bin # MS-Office alternative
    telegram-desktop

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
