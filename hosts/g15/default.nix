{
  pkgs,
  pkgs-stable,
  ...
}: let
  username = "ali";
  hostName = "g15";
  timeZone = "Asia/Tehran";
in {
  imports = [
    ../../modules/boot
    ../../modules/desktop
    ../../modules/fonts

    ./hardware.nix
  ];

  hx = {
    boot.plymouth.enable = true;
    boot.silent.enable = true;
    desktop.hyprland.enable = true;
    fonts.enable = true;
  };

  # Enable auto login
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = username;
  };

  # TODO: Modularize everything from this line

  environment = {
    homeBinInPath = true;
    localBinInPath = true;

    systemPackages = with pkgs; [
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
      nil # .nix language server
      nixd # .nix language server
      nodejs
      corepack
      alejandra # .nix formatter

      # Code editors
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

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      open = true;

      prime = {
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";

        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };

    nvidia-container-toolkit = {
      enable = true;
    };
  };

  networking = {
    hostName = hostName;

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

  nix = {
    gc = {
      automatic = true;
      dates = "00:00";
    };

    optimise = {
      automatic = true;
      dates = ["00:00"];
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      input-fonts.acceptLicense = true;
    };
  };

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

  # Enable automatic updates
  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };

    switch = {
      enableNg = true;
    };
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = timeZone;
  };

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

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = ["--all"];
    };

    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
