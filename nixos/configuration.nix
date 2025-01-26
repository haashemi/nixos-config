{
  pkgs,
  config,
  consts,
  ...
}: {
  imports = [
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/docker.nix
    ./modules/fonts.nix

    ./hardware-configuration.nix
  ];

  # A 'maybe' fix slow shutdown/reboot time.
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # Networking
  # TODO: Explore the other networking options
  networking = {
    hostName = consts.hostName;

    networkmanager.enable = true;

    firewall = rec {
      allowedTCPPortRanges = [
        # KDE Connect
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };

  # Time zone and locale
  # TODO: Explore the other i18n options
  time.hardwareClockInLocalTime = true; # a Windows dual boot fix
  time.timeZone = consts.timeZone;

  i18n.defaultLocale = consts.locale;

  # Swap file
  swapDevices = [
    {
      size = 16 * 1024;
      device = "/var/lib/swapfile";
    }
  ];

  # Users
  users = {
    defaultUserShell = pkgs.fish;

    users.${consts.username} = {
      createHome = true;
      home = "/home/${consts.username}";
      isNormalUser = true;
      useDefaultShell = true;
      extraGroups = [
        "audio"
        "wheel"
        "docker"
        "networkmanager"
      ];
    };
  };

  # System packages and programs
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

    # GUI Apps
    nekoray
    tidal-hifi
    google-chrome
    telegram-desktop

    # Development
    go
    nixd # .nix language server
    nodejs
    corepack
    alejandra # .nix formatter

    # Code editors
    vscode
    # neovim
    # zed-editor

    home-manager
  ];

  programs = {
    fish.enable = true;
  };

  # Enable OpenGL
  # https://wiki.nixos.org/wiki/AMD_GPU
  # https://wiki.nixos.org/wiki/OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable automatic updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Enable flakes
  nix.settings.experimental-features = "nix-command flakes";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
