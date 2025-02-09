{pkgs, ...}: let
  username = "ali";
  hostName = "g15";
  timeZone = "Asia/Tehran";
in {
  imports = [
    ../../modules
    ./experimental.nix
    ./hardware.nix
    ./programs.nix
  ];

  hx = {
    system = {
      boot.enable = true;
      boot.silent = true;
      boot.plymouth = true;
      fonts.enable = true;
      powerManagement.enable = true;
    };

    hardware = {
      audio.enable = true;
      nvidia.enable = true;
      nvidia.enableToolkit = true;
    };

    desktop.hyprland.enable = true;

    programming.enable = true;
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

    # GA503QE's Bus IDs
    nvidia.prime = {
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
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
        "audio" # hx.hardware.audio
        "wheel" # sudo
        "docker" # docker
        "libvirtd" # experimental: QEMU/KVM
        "networkmanager" # networking
      ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
