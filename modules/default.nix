{...}: {
  imports = [
    ./desktop/hyprland.nix
    ./desktop/plasma6.nix

    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/printing.nix
    ./hardware/nvidia.nix

    ./system

    ./asusLinux.nix
    ./programming.nix
    ./themes.nix
  ];
}
