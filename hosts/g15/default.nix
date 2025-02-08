{
  pkgs,
  winapps,
  ...
}: let
  username = "ali";
  hostName = "g15";
  timeZone = "Asia/Tehran";
in {
  imports = [
    ../../modules
    ./hardware.nix
    ./programs.nix
  ];

  hx = {
    audio.enable = true;

    boot.enable = true;
    boot.silent = true;
    boot.plymouth = true;

    desktop.hyprland.enable = true;

    nvidia.enable = true;
    nvidia.enableToolkit = true;
    power.enable = true;
    fonts.enable = true;
    themes.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };

    cpu.amd.updateMicrocode = true;
  };

  networking = {
    hostName = hostName;
    nameservers = ["1.1.1.1"];
    networkmanager.enable = true;
  };

  services = {
    # Asus Linux - ROG Control Center
    asusd = {
      enable = true;
      enableUserService = true;
    };

    # Enable auto login
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = username;
    };

    # Enable printer drivers
    printing = {
      enable = true;
      drivers = [pkgs.foo2zjs]; # HP Laserjet Pro m12a driver
    };

    # Asus Linux - GPU Manager
    supergfxd.enable = true;
  };

  time.timeZone = timeZone;

  users = {
    defaultUserShell = pkgs.fish;

    users.${username} = {
      createHome = true;
      home = "/home/ali";
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

  # ################################
  # EXP: KVM
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [username];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  # EXP: WinApps
  environment.systemPackages = [
    winapps.winapps
    winapps.winapps-launcher
  ];
  # ################################

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
