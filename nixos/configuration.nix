{ pkgs, consts, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../modules/nixos/docker.nix
    # ../modules/nixos/fonts.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = consts.hostName;
  networking.networkmanager.enable = true;

  # Time zone and locale
  time = {
    timeZone = consts.timeZone;
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = consts.locale;

  # Plasma 6
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ali";
  services.desktopManager.plasma6.enable = true;

  # Users
  users.users = {
    "${consts.username}" = {
      isNormalUser = true;
      extraGroups = [
        "audio"
        "wheel"
        "docker"
        "networkmanager"
      ];
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    xz
    zip
    unzip
    ncdu
    wget
    tree
    file
    which
    screen
    dnsutils # dig & nslookup
  ];

  # Remove (the uncommented) optional plasma6 packages.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
    okular
    kate
    khelpcenter
    baloo-widgets
    krdp
    # (lib.getBin qttools) # Expose qdbus in PATH
    # ark
    # gwenview
    # dolphin
    # dolphin-plugins
    # spectacle
    # ffmpegthumbs
    # xwaylandvideobridge # exposes Wayland windows to X11 screen capture
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.input-fonts.acceptLicense = true;

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  # Enable flakes
  nix.settings.experimental-features = "nix-command flakes";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
