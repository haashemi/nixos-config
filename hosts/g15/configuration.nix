{pkgs, ...}: let
  username = "ali";
  hostName = "g15";
  locale = "en_US.UTF-8";
  timeZone = "Asia/Tehran";
in {
  imports = [./hardware-configuration.nix];

  boot = {
    # Clean boot screen [1/3]
    consoleLogLevel = 0;

    # Clean boot screen [2/3]
    initrd.verbose = false;

    # TODO: Learn more about bootspec.
    # It seems good to be enabled, idk.
    bootspec.enableValidation = true;

    # https://wiki.archlinux.org/title/Silent_boot#sysctl
    kernel.sysctl = {
      "kernel.printk" = "3 3 3 3";
    };

    # Basically the best linux kernel AFAIK.
    # https://wiki.archlinux.org/title/Kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Clean boot screen [3/3]
    # https://wiki.archlinux.org/title/Silent_boot
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
    ];

    # UEFI Boot settings
    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot.enable = true;
      systemd-boot.editor = false;

      timeout = 5;
    };
  };

  documentation = {
    enable = false;
  };

  environment = {
    homeBinInPath = true;
    localBinInPath = true;

    plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      elisa
      okular
      kate
      khelpcenter
      baloo-widgets
      krdp
    ];

    systemPackages = with pkgs; [
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

      home-manager
    ];
  };

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      liberation_ttf
      fira-code
      fira-code-symbols
      courier-prime
      terminus_font
      cascadia-code
      input-fonts
      oxygenfonts
      freefont_ttf
      intel-one-mono

      # Icons
      font-awesome_5
      noto-fonts
      noto-fonts-emoji
      mplus-outline-fonts.githubRelease

      # Persian fonts
      ir-standard-fonts
      vazir-fonts
      vazir-code-font
      shabnam-fonts

      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.hack
      nerd-fonts.meslo-lg
      nerd-fonts.roboto-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.sauce-code-pro
    ];

    fontDir = {
      enable = true;
    };

    fontconfig = {
      defaultFonts = {
        # emoji = [];
        monospace = [
          "Input Mono"
          "Vazir Code"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Vazir"
        ];
        serif = [
          "DejaVu Serif"
          "Vazir"
        ];
      };
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # TODO: nvidia = { };
  };

  i18n = {
    defaultLocale = locale;
    # TODO: Fix perl locale issue
  };

  # TODO: More research required
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
    nix-ld.enable = true;
  };

  services = {
    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = true;

      autoLogin.enable = true;
      autoLogin.user = username;
    };
  };

  swapDevices = [
    {
      size = 16 * 1024;
      device = "/var/lib/swapfile";
    }
  ];

  # Enable automatic updates
  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };

    switch = {
      enableNg = true;
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "23.05";
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
    # TODO: use nvidia-container
    enableNvidia = true;
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
}
