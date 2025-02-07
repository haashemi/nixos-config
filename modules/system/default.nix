{...}: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./nix.nix
    ./nixpkgs.nix
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
}
