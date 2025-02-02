{pkgs, ...}: {
  imports = [
    ./plymouth.nix # https://wiki.archlinux.org/title/Plymouth
    ./silent.nix # https://wiki.archlinux.org/title/Silent_boot
  ];

  # Kernel choice:  https://wiki.archlinux.org/title/Kernel
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot.enable = true;
      systemd-boot.editor = false;
    };
  };
}
