{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # CLI: Resource monitoring
    btop # Resource monitor
    htop # Process viewer
    ncdu # Disk usage

    # CLI
    tmux # Terminal multiplexer
    stow # Dotfiles manager
    aria2 # Download manager
    unzip
    ranger # File browser
    screen # Terminal multiplexer
    go-task
    neofetch # System information

    # Encoding stuff
    pkgs-stable.ffmpeg-full

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
