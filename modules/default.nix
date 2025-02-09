{...}: {
  imports = [
    ./desktop/hyprland.nix
    ./desktop/plasma6.nix

    ./hardware/audio.nix
    ./hardware/nvidia.nix

    ./system

    ./programming.nix
    ./themes.nix
  ];
}
