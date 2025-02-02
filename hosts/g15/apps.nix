{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # CLI: Resource monitoring
    btop
    htop
    ncdu

    # CLI
    aria2
    tmux
    screen
    neofetch
    ffmpeg

    # GUI Apps
    nekoray
    discord
    tidal-hifi
    google-chrome
    telegram-desktop

    # Development
    go
    nil # .nix language server
    nixd # .nix language server
    nodejs
    corepack
    alejandra # .nix formatter

    # Code editors
    vscode
    zed-editor

    # Games
    prismlauncher

    # NOT CATEGORIZED, YET
    gh
    mpv
    neovim # Maybe use the 'program' one?
    ranger
    alacritty
  ];

  programs = {
    fish.enable = true;
    git.enable = true;
    nix-ld.enable = true;
    steam.enable = true;
  };

  services = {
    # Asus Linux - ROG Control Center
    asusd = {
      enable = true;
      enableUserService = true;
    };

    printing = {
      enable = true;
      drivers = [pkgs.foo2zjs];
    };

    # Asus Linux - GPU Manager
    supergfxd.enable = true;

    xserver = {
      videoDrivers = ["nvidia"];
    };
  };
}
