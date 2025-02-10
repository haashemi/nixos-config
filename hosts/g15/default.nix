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
      bluetooth.enable = true;
      nvidia.enable = true;
      nvidia.enableToolkit = true;
      printing.enable = true;
    };

    desktop.hyprland.enable = true;
    asusLinux.enableAll = true;
    programming.enable = true;
    themes.enable = true;
  };

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

  time = {
    timeZone = timeZone;
    hardwareClockInLocalTime = true;
  };

  networking = {
    hostName = hostName;
    nameservers = ["1.1.1.1"];
    networkmanager.enable = true;
  };

  services = {
    # Enable auto login
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = username;
    };
  };

  hardware = {
    cpu.amd = {
      updateMicrocode = true;
    };

    # GA503QE specific
    nvidia.prime = {
      amdgpuBusId = "PCI:6:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
