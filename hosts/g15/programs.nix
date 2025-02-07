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
    discord
    alacritty
    tidal-hifi
    google-chrome
    onlyoffice-bin # MS-Office alternative
    telegram-desktop

    # Development
    gh
    go
    pnpm
    nixd # .nix language server
    hyprls # hyprland language server
    nodejs
    alejandra # .nix formatter

    # Code editors
    vscode-fhs
    zed-editor

    # Games
    prismlauncher
  ];

  programs = {
    fish.enable = true;
    git.enable = true;
    nix-ld.enable = true;
    steam.enable = true;
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
