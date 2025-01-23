{ pkgs, consts, ... }:
{
  imports = [
    ./fonts.nix
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = consts.hostName;
  networking.networkmanager.enable = true;

  # Time zone and locale
  time.timeZone = consts.timeZone;
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = consts.locale;

  # Plasma 6
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = consts.username;
  services.desktopManager.plasma6.enable = true;

  # Swap file
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

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

  # Default shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # System packages
  environment.systemPackages = with pkgs; [
    home-manager
  ];

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

  # Enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 1d";
  nix.settings.auto-optimise-store = true;

  # Enable flakes
  nix.settings.experimental-features = "nix-command flakes";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
