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
    ../../modules
    ./hardware.nix
  ];

  hx = {
    boot.enableModifications = true;
    boot.plymouth.enable = true;
    boot.silent.enable = true;

    desktop.hyprland.enable = true;

    nvidia.enable = true;
    nvidia.enableToolkit = true;

    fonts.enable = true;
    themes.enable = true;
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
      hyprls # hyprland language server
      nodejs
      corepack
      alejandra # .nix formatter

      # Code editors
      neovim
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
    networkmanager.enable = true;
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
      drivers = [pkgs.foo2zjs]; # HP Laserjet Pro m12a driver
    };

    # Asus Linux - GPU Manager
    supergfxd.enable = true;
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
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = ["--all"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
