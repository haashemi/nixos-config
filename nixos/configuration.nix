{
  pkgs,
  consts,
  ...
}: {
  imports = [
    ./fonts.nix
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot.enable = true;
    systemd-boot.consoleMode = "max";
  };

  # Networking
  # TODO: Explore the other networking options
  networking.hostName = consts.hostName;
  networking.networkmanager.enable = true;

  # Time zone and locale
  # TODO: Explore the other i18n options
  time.hardwareClockInLocalTime = true; # a Windows dual boot fix
  time.timeZone = consts.timeZone;

  i18n.defaultLocale = consts.locale;

  # DE/DM
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;

    autoLogin.enable = true;
    autoLogin.user = consts.username;
  };

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
    ranger

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
    # zed-editor

    home-manager
  ];

  programs = {
    fish.enable = true;
    kdeconnect.enable = true;
  };

  # Remove some optional plasma6 packages.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
    okular
    kate
    khelpcenter
    baloo-widgets
    krdp
  ];

  # Enable docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Enable automatic updates
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Enable flakes
  nix.settings.experimental-features = "nix-command flakes";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
