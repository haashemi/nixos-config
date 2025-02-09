{...}: {
  imports = [
    ./boot.nix
    ./fonts.nix
    ./powerManagement.nix
  ];

  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };

    switch = {
      enableNg = true;
    };
  };

  # Disable all documentation generations
  documentation = {
    enable = false;
    doc.enable = false;
    info.enable = false;
    man.enable = false;
    nixos.enable = false;
  };

  # ٍEnable auto cleanups and flakes
  nix = {
    gc.automatic = true;
    optimise.automatic = true;
    settings.experimental-features = "nix-command flakes";
  };

  # Allow unfree packages and fonts installations
  nixpkgs = {
    config = {
      allowUnfree = true;
      input-fonts.acceptLicense = true;
    };
  };
}
