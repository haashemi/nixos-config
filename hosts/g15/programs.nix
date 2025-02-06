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
    unzip
    stow # Dotfiles manager
    aria2 # Download manager
    tmux # Terminal multiplexer
    screen # Terminal multiplexer
    neofetch # System information

    # Encoding stuff
    pkgs-stable.ffmpeg-full

    # GUI Apps
    nekoray
    discord
    tidal-hifi
    google-chrome
    telegram-desktop

    # Development
    go
    nixd # .nix language server
    hyprls # hyprland language server
    nodejs
    corepack
    alejandra # .nix formatter

    # Code editors
    vscode-fhs
    zed-editor

    # Games
    prismlauncher

    # NOT CATEGORIZED, YET
    gh
    mpv
    ranger
    alacritty
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
